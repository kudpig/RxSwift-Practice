//
//  Router.swift
//  RxSwift-Practice
//
//  Created by Shinichiro Kudo on 2021/09/14.
//

import UIKit

final class Router {
    
    static let shared = Router()
    private init() {}
    
    func showRoot(window: UIWindow?) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! HomeViewController
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
    
    func showFirst(fromVC: UIViewController) {
        let storyboard = UIStoryboard(name: "FirstSample", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! FirstSampleViewController
        
        show(fromVC: fromVC, nextVC: vc)
    }
    
    func showSecond(fromVC: UIViewController) {
        let storyboard = UIStoryboard(name: "SecondSample", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! SecondSampleViewController
        
        show(fromVC: fromVC, nextVC: vc)
    }
    
    func showThird(fromVC: UIViewController) {
        let storyboard = UIStoryboard(name: "ThirdSample", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! ThirdSampleViewController
        
        show(fromVC: fromVC, nextVC: vc)
    }
    
    func showCallbackCounter(fromVC: UIViewController) {
        let vc = CallbackCounterViewController()
        
        show(fromVC: fromVC, nextVC: vc)
    }
    
    func showDelegateCounter(fromVC: UIViewController) {
        let vc = DelegateCounterViewController()
        
        show(fromVC: fromVC, nextVC: vc)
    }
    
    func showRxSwiftCounter(fromVC: UIViewController) {
        let vc = RxSwiftCounterViewController()
        
        show(fromVC: fromVC, nextVC: vc)
    }
    
    func showFilter(fromVC: UIViewController) {
        let storyboard = UIStoryboard(name: "Filter", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! FilterViewController
        
        show(fromVC: fromVC, nextVC: vc)
    }
    
    
    func showOther(fromVC: UIViewController) {
        let storyboard = UIStoryboard(name: "Other", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! OtherViewController
        
        show(fromVC: fromVC, nextVC: vc)
    }
    
    
    private func show(fromVC: UIViewController, nextVC: UIViewController) {
        if let nav = fromVC.navigationController {
            nav.pushViewController(nextVC, animated: true)
        } else {
            fromVC.present(nextVC, animated: true, completion: nil)
        }
    }
}
