//
//  RxSwiftCounterViewModel.swift
//  RxSwift-Practice
//
//  Created by Shinichiro Kudo on 2021/09/14.
//

import Foundation
import RxSwift
import RxCocoa

// これは単なる構造体
// ViewのUI部品として扱う
struct CounterViewModelInput {
    //　Observableとして定義。監視対象として登録できる型。今回はタップイベントを監視したいのでVoid型
    let countUpButton: Observable<Void>
    let countDownButton: Observable<Void>
    let countResetButton: Observable<Void>
    /*
     countUpButtonの中身は、インスタンス生成時(View側でのinit時)に
     countUpButton.rx.tap.asObservable()が与えられる
     つまり、
     var countUpButton: Observable<Void> {
         retrun countUpButton.rx.tap.asObservable()
     }
     といった基本の形になると考えてよい
     */
}

// viewModelに準拠させる。Viewにoutputするもの(ルール)
protocol CounterViewModelOutput: AnyObject {
    var counterText: Driver<String?> { get }
}

// ViewModelそのもののルール
protocol CounterViewModelType: AnyObject {
    
    var outputs: CounterViewModelOutput? { get }
    
    func setup(input: CounterViewModelInput)
    
}

final class CounterRxViewModel: CounterViewModelType {
    
    var outputs: CounterViewModelOutput?
    
    private let countRelay = BehaviorRelay<Int>(value: 0) // Int型の観測対象で既に0を持っている
    private let initialCount = 0
    private let disposeBag = DisposeBag()
    
    init() {
        self.outputs = self
        resetCount()
    }
    
    func setup(input: CounterViewModelInput) {
        input.countUpButton
            .subscribe(onNext: { [weak self] in
                self?.incrementCount()
            })
            .disposed(by: disposeBag)
        
        input.countDownButton
            .subscribe(onNext: { [weak self] in
                self?.decrementCount()
            })
            .disposed(by: disposeBag)
        
        input.countResetButton
            .subscribe(onNext: { [weak self] in
                self?.resetCount()
            })
            .disposed(by: disposeBag)
    }
    
    private func incrementCount() {
        let count = countRelay.value + 1
        countRelay.accept(count) // subscribeの時の.onNextと同じと考えてよい。購読対象(ストリーム)にvalueを流す
    }
    
    private func decrementCount() {
        let count = countRelay.value - 1
        countRelay.accept(count)
    }
    
    private func resetCount() {
        countRelay.accept(initialCount)
    }
    
}

extension CounterRxViewModel: CounterViewModelOutput {
    var counterText: Driver<String?> {
        return countRelay
            .map { "Rxパターン: \($0)" }
            .asDriver(onErrorJustReturn: nil)
    }
}
