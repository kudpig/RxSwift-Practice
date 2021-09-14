//
//  DelegateCounterViewController.swift
//  RxSwift-Practice
//
//  Created by Shinichiro Kudo on 2021/09/14.
//

import UIKit

protocol CounterDelegate: AnyObject {
    func updateCount(count: Int)
}

final class CounterPresenter {
    
    private var count = 0 {
        didSet {
            delegate?.updateCount(count: count)
        }
    }
    
    private var delegate: CounterDelegate?
    
    func attachView(_ delegate: CounterDelegate) {
        self.delegate = delegate
    }
    
    func detachView() {
        self.delegate = nil
    }
    
    func incrementCount() {
        count += 1
    }
    
    func decrementCount() {
        count -= 1
    }
    
    func resetCount() {
        count = 0
    }
    
}

final class DelegateCounterViewController: UIViewController {
    
    @IBOutlet private weak var countLabel: UILabel!
    
    private let presenter = CounterPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Delegate"
        presenter.attachView(self)
    }
    
    @IBAction private func countUp(_ sender: UIButton) {
        presenter.incrementCount()
    }
    
    @IBAction private func countDown(_ sender: UIButton) {
        presenter.decrementCount()
    }
    
    @IBAction private func countReset(_ sender: UIButton) {
        presenter.resetCount()
    }

}

extension DelegateCounterViewController: CounterDelegate {
    func updateCount(count: Int) {
        countLabel.text = String(count)
    }
}
