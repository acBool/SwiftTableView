//
//  TableHomeListViewController.swift
//  SwiftTableView
//
//

import UIKit
import ESPullToRefresh
import HandyJSON

class TableHomeListViewController: TableBaseViewController {
    
    var page = 0
    lazy var viewModel: TableHomeListViewModel = {
        let viewModel = TableHomeListViewModel()
        viewModel.selectRowBlock = {[unowned self] (row: Int) in
            let model: TableHomeCircleModel = self.viewModel.dataSourceArray[row]
            let cellFrame: TableHomeListCellFrame = self.viewModel.cellFrameArray[row]
            self.navigationController?.pushViewController(TableDetailViewController(model: model,cellFrame: cellFrame), animated: true)
        }
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
        if self.viewModel.dataSourceArray.count == 0 {
            specView.tableView.es.startPullToRefresh()
        }
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
                for _ in 1...dataArray.count {
                    let cellFrame = TableHomeListCellFrame()
                    self.viewModel.cellFrameArray.append(cellFrame)
                }
                specView.tableView.reloadData()
            }
        }
        
        specView.tableView.es.addInfiniteScrolling {
            [unowned self] in
            let dataArray:[TableHomeCircleModel] = self.readDataFromLocal(index: self.page)
            if dataArray.count > 0 {
                self.page += 1
                self.viewModel.dataSourceArray += dataArray
                for _ in 1...dataArray.count {
                    let cellFrame = TableHomeListCellFrame()
                    self.viewModel.cellFrameArray.append(cellFrame)
                }
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
