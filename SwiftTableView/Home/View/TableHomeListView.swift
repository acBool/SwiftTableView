//
//  TableHomeListView.swift
//  SwiftTableView
//
//

import UIKit

class TableHomeListView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = _L("Home")
        label.font = TableStyle.shared.bh1()
        label.textColor = TableStyle.shared.navBarTitleColor()
        label.sizeToFit()
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = TableStyle.shared.mainBgColor()
        tableView.showsVerticalScrollIndicator = true
        registerCell(tableView: tableView)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.pin.hCenter().top(kStatusBarHeight).height(kNavBarHeight)
        tableView.pin.below(of: titleLabel).left().right().bottom()
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(tableView)
    }
}


extension TableHomeListView {
    func registerCell(tableView: UITableView) {
        tableView.register(TableHomeBaseCell.self, forCellReuseIdentifier: "TableHomeBaseCell")
        tableView.register(TableHomeWordCell.self, forCellReuseIdentifier: "TableHomeWordCell")
        tableView.register(TableHomeOnePicCell.self, forCellReuseIdentifier: "TableHomeOnePicCell")
        tableView.register(TableHomeTTPicCell.self, forCellReuseIdentifier: "TableHomeTTPicCell")
        tableView.register(TableHomeFourPicCell.self, forCellReuseIdentifier: "TableHomeFourPicCell")
        tableView.register(TableHomeFSPicCell.self, forCellReuseIdentifier: "TableHomeFSPicCell")
        tableView.register(TableHomeSENPicCell.self, forCellReuseIdentifier: "TableHomeSENPicCell")
    }
}
