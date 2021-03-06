//
//  ThirdSampleViewController.swift
//  RxSwift-Practice
//
//  Created by Shinichiro Kudo on 2021/09/14.
//

import UIKit
import RxSwift
import RxCocoa

final class ThirdSampleViewController: UIViewController {
    
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.rx.text
            .map { text -> String? in
                guard let text = text else { return nil }
                return "いま\(text.count)文字"
            }
            .bind(to: countLabel.rx.text)
            .disposed(by: disposeBag)
        
        textField.rx.text
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
    }

}
