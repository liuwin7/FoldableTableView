//
//  FoldableTableView.swift
//  FoldableTableView
//
//  Created by topsci_ybma on 15/9/5.
//  Copyright (c) 2015年 topsci. All rights reserved.
//

import UIKit

class FoldableTableView: UITableView, UITableViewDelegate, UITableViewDataSource{
    
    private var menuList:FoldMenuList = FoldMenuList(foldIdentifier: "foldTableViewList")
    
    // MARK: - Public Methods
    func configureFoldMenuItems(items: [FoldItem]) {
        self.menuList.addSubFoldItems(items)
    }
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        self.dataSource = self
        self.delegate = self
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let visibleCount = menuList.openedItemCount - 1
        return visibleCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellReusableID = "foldableTableViewCellReusableID"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReusableID)!
        let foldItem = self.menuList.allVisibleItems![indexPath.row]
        cell.indentationLevel = foldItem.foldLevel - 1
        cell.indentationWidth = 20
        cell.textLabel?.text = foldItem.foldName!
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let foldItem = menuList.allVisibleItems![indexPath.row]
        foldItem.foldOpened = !(foldItem.foldOpened)
        
        var row = indexPath.row + 1
        var indexPaths = [NSIndexPath]();
        if let subFoldItems = foldItem.allVisibleItems?.count {
            for _ in 0..<subFoldItems {
                let operationIndexPath = NSIndexPath(forRow: row++, inSection: indexPath.section)
                indexPaths.append(operationIndexPath)
            }
        } else {
            return
        }
        
        if indexPaths.count != 0 {
            if foldItem.foldOpened == true {
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Top)
            } else {
                tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Top)
            }
        }
    }
}
