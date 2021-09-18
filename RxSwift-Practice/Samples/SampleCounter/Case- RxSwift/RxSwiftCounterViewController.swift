//
//  RxSwiftCounterViewController.swift
//  RxSwift-Practice
//
//  Created by Shinichiro Kudo on 2021/09/14.
//

import UIKit
import RxSwift
import RxCocoa

final class RxSwiftCounterViewController: UIViewController {
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countUpButton: UIButton!
    @IBOutlet weak var countDownButton: UIButton!
    @IBOutlet weak var countResetButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    private var viewModel: CounterRxViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel = CounterRxViewModel()
        // input用の構造体を生成
        // rx.tap.asObservableとすることで、tapを購読する
        // tapイベントであるVoid型をストリームに流す
        let input = CounterViewModelInput(countUpButton: countUpButton.rx.tap.asObservable(),
                                          countDownButton: countDownButton.rx.tap.asObservable(),
                                          countResetButton: countResetButton.rx.tap.asObservable())
        // viewModelをインスタンス化
        viewModel.setup(input: input)
        
        viewModel.outputs?.counterText
            .drive(countLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    
}
