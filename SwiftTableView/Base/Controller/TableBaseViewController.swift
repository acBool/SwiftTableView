//
//  TableBaseViewController.swift
//  SwiftTableView
//
//

import UIKit

class TableBaseViewController: UIViewController {
    
    //typealias SpecViewType = UIView
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = TableStyle.shared.mainBgColor()
        self .setupNavigationBackButton()
    }
    
    func setupNavigationBackButton() {
        if let value = self.navigationController?.viewControllers.count {
            if value > 1 {
                let btn = UIButton(type: .custom)
                btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
                btn.adjustsImageWhenHighlighted = false
                btn.contentHorizontalAlignment = .left
                btn.setImage(UIImage(named: "ic_nav_black_back"), for: .normal)
                btn.addTarget(self, action: #selector(popBackAction), for: .touchUpInside)
                let barItem = UIBarButtonItem(customView: btn)
                self.navigationItem.leftBarButtonItems = [barItem]
            }
        }
    }
    
    @objc func popBackAction() {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    deinit {
        #if DEBUG
            print("---deinit---%@",self)
        #endif
    }
}
