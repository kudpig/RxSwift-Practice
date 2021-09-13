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