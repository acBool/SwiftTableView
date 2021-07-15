//
//  TableSpecViewProtocol.swift
//  SwiftTableView
//
//

import UIKit

protocol TableSpecViewProtocol {
    associatedtype SpecViewType: UIView
    var specView: SpecViewType {get}
}

extension TableSpecViewProtocol where Self: UIViewController {
    var specView: Self.SpecViewType {
        return view as! Self.SpecViewType
    }
}
