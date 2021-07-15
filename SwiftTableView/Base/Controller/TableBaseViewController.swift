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
    }
    
    deinit {
        #if DEBUG
            print("---deinit---%@",self)
        #endif
    }
}
