//
//  HomeViewController.swift
//  RxSwift-Practice
//
//  Created by Shinichiro Kudo on 2021/09/14.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBAction func tapFirstSampleButton(_ sender: UIButton) {
        Router.shared.showFirst(fromVC: self)
    }
    
    @IBAction func tapSecondSampleButton(_ sender: UIButton) {
        Router.shared.showSecond(fromVC: self)
    }
    
    @IBAction func tapThirdSampleButton(_ sender: UIButton) {
        Router.shared.showThird(fromVC: self)
    }
    
    @IBAction func tapOtherSampleButton(_ sender: UIButton) {
        Router.shared.showOther(fromVC: self)
    }

    @IBAction func tapCallbackCounter(_ sender: UIButton) {
        Router.shared.showCallbackCounter(fromVC: self)
    }
    
    
    @IBAction func tapDelegateCounter(_ sender: UIButton) {
        Router.shared.showDelegateCounter(fromVC: self)
    }
    
    
}
