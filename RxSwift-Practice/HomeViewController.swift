//
//  HomeViewController.swift
//  RxSwift-Practice
//
//  Created by Shinichiro Kudo on 2021/09/14.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBAction func tapFirstSampleButton(_ sender: UIButton) {
    }
    
    @IBAction func tapSecondSampleButton(_ sender: UIButton) {
    }
    
    @IBAction func tapOtherSampleButton(_ sender: UIButton) {
        Router.shared.showOther(fromVC: self)
    }

}
