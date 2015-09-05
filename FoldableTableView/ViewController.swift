//
//  ViewController.swift
//  FoldableTableView
//
//  Created by topsci_ybma on 15/9/5.
//  Copyright (c) 2015年 topsci. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: FoldableTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.configureFoldTableViewData()
    }
    
    func configureFoldTableViewData() {
        // 个人中心
        let personalCenterItem = FoldItem(foldIdentifier: "personalItem", foldName:NSLocalizedString("personalItem", comment: "Personal Center"))
        
        // 我的订单
        let vipFlightOrderItem = FoldItem(foldIdentifier: "vipFlightOrderItem", foldName: NSLocalizedString("vipFlightOrderItem", comment: "VIP Flight order"))
        let flightOrderItem = FoldItem(foldIdentifier: "flightOrderItem", foldName: NSLocalizedString("flightOrderItem", comment: "Flight Order"), subFoldItems: [vipFlightOrderItem])
        let mineOrderItem = FoldItem(foldIdentifier: "mineOrderItem", foldName: NSLocalizedString("mineMessageItem", comment: "Mine Message"), subFoldItems:[flightOrderItem])
        
        // 我的消息
        let flightMessageItem = FoldItem(foldIdentifier: "flightMessageItem", foldName: NSLocalizedString("flightMessageItem", comment: "Flight Message"))
        let systemMessageItem = FoldItem(foldIdentifier: "systemMessageItem", foldName: NSLocalizedString("systemMessageItem", comment: "System Message"))
        let mineMessageItem = FoldItem(foldIdentifier: "mineMessageItem", foldName: NSLocalizedString("mineMessageItem", comment: "Mine Message"), subFoldItems: [flightMessageItem, systemMessageItem])
        
        // 意见反馈
        let feedbackItem = FoldItem(foldIdentifier: "feedbackItem", foldName: NSLocalizedString("feedbackItem", comment: "Feedback"))
        
        // 关于我们
        let aboutUsItem = FoldItem(foldIdentifier: "aboutUsItem", foldName: NSLocalizedString("aboutUsItem", comment: "About Us"))
        
        tableView.configureFoldMenuItems([personalCenterItem, mineOrderItem, mineMessageItem, feedbackItem, aboutUsItem])
    }

}

