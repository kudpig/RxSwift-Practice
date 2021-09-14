//
//  FirstSampleViewController.swift
//  RxSwift-Practice
//
//  Created by Shinichiro Kudo on 2021/09/14.
//

import UIKit
import RxSwift
import RxCocoa

class FirstSampleViewController: UIViewController {
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let helloWorldSubject = PublishSubject<String>() // <観測対象の型>
        
        helloWorldSubject
            .subscribe(onNext: { message in
                print("onNext: \(message)")
            }, onCompleted: {
                print("onCompleted")
            }, onDisposed: {
                print("onDisposed")
            })
            .disposed(by: disposeBag)
            
        
        helloWorldSubject.onNext("Hello World!")
        helloWorldSubject.onNext("Hello World!!!")
        helloWorldSubject.onCompleted()
        helloWorldSubject.onNext("Hello World!!!!!") // helloWorldSubjectはonCompletedによってクラスが破棄されたので実行されない
    }

}
