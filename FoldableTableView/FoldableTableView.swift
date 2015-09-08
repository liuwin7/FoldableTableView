//
//  FoldableTableView.swift
//  FoldableTableView
//
//  Created by topsci_ybma on 15/9/5.
//  Copyright (c) 2015年 topsci. All rights reserved.
//

import UIKit

class FoldableTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Life Cycle
    
    private var foldItemList = FoldItemList(foldItems: [])
    
    override func awakeFromNib() {
        self.dataSource = self
        self.delegate = self
    }
    
    // MARK: - Public Methods
    func configureItemList(itemList: FoldItemList) {
        self.foldItemList = itemList
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foldItemList.visibles().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellReusableID = "foldableTableViewCellReusableID"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReusableID)!
        let foldItem = foldItemList.visibles()[indexPath.row]
        cell.indentationLevel = foldItem.foldLevel - 1
        cell.indentationWidth = 20
        cell.textLabel?.text = foldItem.foldName!
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let foldItem = foldItemList.visibles()[indexPath.row]
        
        // 获取变化的indexpath
        var indexPaths = [NSIndexPath]();
        let items: (start: Int, end: Int)
        if foldItem.foldOpened {
            items = foldItemList.closeFoldItem(foldItem)
        } else {
            items = foldItemList.openFoldItem(foldItem)
        }
        
        // 叶子节点，不需要改变
        if items.start == items.end {
            return
        }
        
        for index in (items.start + 1)...(items.end) {
            let operationIndexPath = NSIndexPath(forRow: index, inSection: indexPath.section)
            indexPaths.append(operationIndexPath)
        }

        // Modify UI
        if indexPaths.count != 0 {
            if foldItem.foldOpened == true {
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Top)
            } else {
                tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Top)
            }
        }
    }
}
