//
//  TableDetailViewController.swift
//  SwiftTableView
//
//

import UIKit

class TableDetailViewController: TableBaseViewController {

    var dataModel: TableHomeCircleModel
    var cellFrame: TableHomeListCellFrame
    lazy var viewModel: TableDetailViewModel = {
        let viewModel = TableDetailViewModel()
        viewModel.model = self.dataModel
        return viewModel
    }()
    
    lazy var specView: TableDetailView = {
        let view = TableDetailView()
        view.backgroundColor = TableStyle.shared.mainBgColor()
        return view
    }()
    
    init(model: TableHomeCircleModel, cellFrame: TableHomeListCellFrame) {
        self.dataModel = model
        self.cellFrame = cellFrame
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = _L("Detail")
        self.setupUI()
        self.bindModel()
        self.setupData()
    }
    
}

extension TableDetailViewController {
    func setupUI() {
        specView.frame = self.view.bounds
        self.view.addSubview(specView)
    }
    
    func bindModel() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(
            top: 0, left: kHomeMargin, bottom: 0,
            right: kHomeMargin)
        layout.minimumInteritemSpacing = kHomeMargin
        if self.dataModel.imgArray.count == 1 {
            // 仅一张图片，特殊处理
            layout.itemSize = cellFrame.onePicSize
        }else {
            layout.itemSize = CGSize(width: kHomePicWH, height: kHomePicWH)
        }
        specView.flowLayout = layout
        specView.contentHeight = cellFrame.contentHeight
        specView.bindHeaderData(model: self.dataModel)
    }
    
    func setupData() {
        specView.collectionView.delegate = viewModel
        specView.collectionView.dataSource = viewModel
        
        specView.collectionView.reloadData()
    }
}
