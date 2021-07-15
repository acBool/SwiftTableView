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
        //tableView.register(TableHomeBaseCell.self, forCellReuseIdentifier: "TableHomeBaseCell")
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
