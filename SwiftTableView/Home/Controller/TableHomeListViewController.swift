//
//  TableHomeListViewController.swift
//  SwiftTableView
//
//

import UIKit
import ESPullToRefresh
import HandyJSON

class TableHomeListViewController: TableBaseViewController {

    //typealias SpecViewType = TableHomeListView
    
    var page = 0
    lazy var viewModel: TableHomeListViewModel = {
        let viewModel = TableHomeListViewModel()
        return viewModel
    }()
    
    lazy var specView: TableHomeListView = {
        let view = TableHomeListView()
        view.backgroundColor = TableStyle.shared.mainBgColor()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = _L("Home")
        self.setupUI()
        self.setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        specView.tableView.es.startPullToRefresh()
    }
}

extension TableHomeListViewController {
    func setupUI() {
        specView.frame = self.view.bounds
        self.view.addSubview(specView)
    }
    
    func setupData() {
        specView.tableView.delegate = viewModel
        specView.tableView.dataSource = viewModel
        specView.tableView.reloadData()
        
        specView.tableView.es.addPullToRefresh {
            [unowned self] in
            let dataArray:[TableHomeCircleModel] = self.readDataFromLocal(index: 0)
            specView.tableView.es.stopPullToRefresh()
            // 获取到数据后，将原数据清空，并将page置为0
            if dataArray.count > 0 {
                self.page = 1
                self.viewModel.dataSourceArray.removeAll()
                self.viewModel.dataSourceArray += dataArray
                self.viewModel.cellFrameArray.removeAll()
                self.viewModel.cellFrameArray += Array(repeating: TableHomeListCellFrame(), count: dataArray.count)
                specView.tableView.reloadData()
            }
        }
        
        specView.tableView.es.addInfiniteScrolling {
            [unowned self] in
            let dataArray:[TableHomeCircleModel] = self.readDataFromLocal(index: self.page)
            if dataArray.count > 0 {
                self.page += 1
                self.viewModel.dataSourceArray += dataArray
                self.viewModel.cellFrameArray += Array(repeating: TableHomeListCellFrame(), count: dataArray.count)
                specView.tableView.reloadData()
                specView.tableView.es.stopLoadingMore()
            }else {
                // 显示无数据状态
                specView.tableView.es.noticeNoMoreData()
            }
        }
    }
    
}


extension TableHomeListViewController {
    // 从本地读取数据，模拟网络请求
    func readDataFromLocal(index: Int) -> Array<TableHomeCircleModel> {
        let path = Bundle.main.path(forResource: String(index), ofType: "json")
        if path != nil {
            do {
                let fileContent = try NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue)
                if let mappedObject = JSONDeserializer<TableBaseResp>.deserializeFrom(json: fileContent as String) {
                    if mappedObject.code == 0 {
                        return mappedObject.data
                    }
                    return []
                }else{
                    return []
                }
            }catch _ as Error? {
                return []
            }
        }
        return []
    }
}
