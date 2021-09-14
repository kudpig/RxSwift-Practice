//
//  SecondSampleViewController.swift
//  RxSwift-Practice
//
//  Created by Shinichiro Kudo on 2021/09/14.
//

import UIKit
import RxSwift
import RxCocoa

class Sample2ViewModel {
    
    var helloWorldObservable: Observable<String> {
        return helloWorldSubject.asObservable()
    }
    
    private let helloWorldSubject = PublishSubject<String>()
    
    func updateItem() {
        helloWorldSubject.onNext("Hello World!")
        helloWorldSubject.onNext("Hello World!!!")
        helloWorldSubject.onNext("Hello World!!!!!")
        helloWorldSubject.onCompleted()
    }
}

class SecondSampleViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: Sample2ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = Sample2ViewModel()
        
        viewModel.helloWorldObservable
            .subscribe { value in
                print("value = \(value)")
            }
            .disposed(by: disposeBag)
        
        viewModel.updateItem()
    }
   
}
