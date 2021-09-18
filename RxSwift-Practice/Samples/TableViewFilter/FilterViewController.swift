//
//  FilterViewController.swift
//  RxSwift-Practice
//
//  Created by Shinichiro Kudo on 2021/09/15.
//

import UIKit
import RxSwift
import RxCocoa

struct Item {
    let imageName: String
    let title: String
}

final class DammyAPI {
    static func get() -> [Item] {
        let items = [
            Item(imageName: "house", title: "Home"),
            Item(imageName: "gear", title: "Settings"),
            Item(imageName: "person.circle", title: "Profile"),
            Item(imageName: "airplane", title: "Flights"),
            Item(imageName: "bell", title: "Activity")
        ]
        return items
    }
}

//ViewModelの出力に関するprotocol
protocol FilterItemViewModelOutput {
    var items: Observable<[Item]> { get }
}

final class FilterItemViewModel: FilterItemViewModelOutput {
    
    private var outputs: FilterItemViewModelOutput?
    
    // itemsObservableにObservable機能を持たせ、ストリームに設定する(イベントを流されるところ)
    // itemsObservable = itemsSubject.asObservable()
    var items: Observable<[Item]> {
        return itemsSubject.asObservable() // asObservable()でObservable型にしreturnしている
    }
    
    private let itemsSubject = PublishSubject<[Item]>() // subjectはイベント発生もさせることができる(.onNextなどのメソッドを持つ)
    
    func initialItemsSetting() {
        let items = DammyAPI.get()
        itemsSubject.onNext(items)
        itemsSubject.onCompleted()
    }
    
    /*
     ----:初期値:---->:onNext:----->:onNext:----->
                       検知           検知
    検知のタイミングで、View側でsubscribeが実行される
    */
    
    // つまりここまでで、itemsSubjectに変化があった場合(onNextなどが発生したなど)に検知される設定をした
}

final class FilterViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: FilterItemViewModel!

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FilterItemViewModel()
        bindTableData()
        viewModel.initialItemsSetting()
    }
    
    private func bindTableData() {
        viewModel.items
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
                cell.textLabel?.text = element.title
                return cell
            }
            .disposed(by: disposeBag)
    }
    
}
