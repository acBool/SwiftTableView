//
//  TableHomeCellFactory.swift
//  SwiftTableView
//
//

import Foundation
import UIKit

enum TableHomeCellType: Int {
    case TableHomeCellTypeWord = 1
    case TableHomeCellTypeOnePic
    case TableHomeCellTypeTTPic
    case TableHomeCellTypeFourPic
    case TableHomeCellTypeFSPic
    case TableHomeCellTypeSENPic
}

class TableHomeCellFactory {
    static func createCellWithType(type: TableHomeCellType,tableView: UITableView) -> TableHomeBaseCell {
        switch type{
        case .TableHomeCellTypeWord:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableHomeWordCell") as? TableHomeWordCell
            if cell == nil {
                return TableHomeWordCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "TableHomeWordCell")
            }
            return cell!
        case .TableHomeCellTypeOnePic:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableHomeOnePicCell") as? TableHomeOnePicCell
            if cell == nil {
                return TableHomeOnePicCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "TableHomeWordCell")
            }
            return cell!
        case .TableHomeCellTypeTTPic:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableHomeTTPicCell") as? TableHomeTTPicCell
            if cell == nil {
                return TableHomeTTPicCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "TableHomeTTPicCell")
            }
            return cell!
        case .TableHomeCellTypeFourPic:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableHomeFourPicCell") as? TableHomeFourPicCell
            if cell == nil {
                return TableHomeFourPicCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "TableHomeFourPicCell")
            }
            return cell!
        case .TableHomeCellTypeFSPic:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableHomeFSPicCell") as? TableHomeFSPicCell
            if cell == nil {
                return TableHomeFSPicCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "TableHomeFSPicCell")
            }
            return cell!
        case .TableHomeCellTypeSENPic:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableHomeSENPicCell") as? TableHomeSENPicCell
            if cell == nil {
                return TableHomeSENPicCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "TableHomeSENPicCell")
            }
            return cell!
        }
    }
}
