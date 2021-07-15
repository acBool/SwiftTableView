//
//  TableHomeCircleModel.swift
//  SwiftTableView
//
//

import UIKit
import HandyJSON

class TablePicture: HandyJSON {
    var imgUrl: String = ""
    var imgHeight: Int = 0
    var imgWidth: Int = 0
    
    required init() {}
}

class TableHomeCircleModel: HandyJSON {
    var headImageIndex: Int = 0
    var nickName: String = ""
    var type: String = ""
    var content: String = ""
    var id: Int = 0
    var link: String = ""
    var imgArray: [TablePicture] = []
    
    required init() {}
}
