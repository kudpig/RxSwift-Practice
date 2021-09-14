//
//  SampleCounterViewController.swift
//  RxSwift-Practice
//
//  Created by Shinichiro Kudo on 2021/09/14.
//

import UIKit

final class CallbackCounterViewModel {
    
    private var count = 0
    
    func incrementCount(callback: (Int) -> ()) {
        count += 1
        callback(count)
    }
    
    func decrementCount(callback: (Int) -> ()) {
        count -= 1
        callback(count)
    }
    
    func resetCount(callback: (Int) -> ()) {
        count = 0
        callback(count)
    }
    
}


final class CallbackCounterViewController: UIViewController {
    
    @IBOutlet private weak var countLabel: UILabel!
    
    private var viewModel: CallbackCounterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Callback"
        viewModel = CallbackCounterViewModel()
    }
    
    @IBAction private func countUp(_ sender: UIButton) {
        viewModel.incrementCount(callback: { [weak self] count in
            self?.updateCountLabel(count)
        })
    }
    
    @IBAction private func countDown(_ sender: UIButton) {
        viewModel.decrementCount(callback: { [weak self] count in
            self?.updateCountLabel(count)
        })
    }
    
    @IBAction private func countReset(_ sender: UIButton) {
        viewModel.resetCount(callback: { [weak self] count in
            self?.updateCountLabel(count)
        })
    }
    
    private func updateCountLabel(_ count: Int) {
        countLabel.text = String(count)
    }
    
}
