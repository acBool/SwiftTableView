//
//  TableBaseResp.swift
//  SwiftTableView
//
//

import Foundation
import HandyJSON

class TableBaseResp:  HandyJSON{
    var code: Int = -1
    var msg: String = ""
    var data: [TableHomeCircleModel] = []
    
    required init() {}
}
