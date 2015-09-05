//
//  FoldItem.swift
//  FoldableTableView
//
//  Created by topsci_ybma on 15/9/5.
//  Copyright (c) 2015年 topsci. All rights reserved.
//

import Foundation

// MARK: - FoldItem
class FoldItem {
    
    // MARK: - stored properties
    
    let foldIdentifier: String
    let foldName: String?
    var foldOpened: Bool = true
    var subFoldItems: [FoldItem]?
    var superFoldItem: FoldItem?

    init(foldIdentifier: String, foldName: String?, foldOpened: Bool, subFoldItems: [FoldItem]?) {
        self.foldIdentifier = foldIdentifier
        self.foldName = foldName
        self.foldOpened = foldOpened
        self.subFoldItems = subFoldItems
        if let subItems = self.subFoldItems {
            for subItem in subItems {
                subItem.superFoldItem = self
            }
        }
    }
    
    convenience init(foldIdentifier: String, foldName: String?, subFoldItems: [FoldItem]?) {
        self.init(foldIdentifier: foldIdentifier, foldName: foldName, foldOpened:false, subFoldItems: subFoldItems)
    }

    convenience init(foldIdentifier: String, foldName: String?) {
        self.init(foldIdentifier: foldIdentifier, foldName: foldName, subFoldItems: nil)
    }
    
    
    // MARK: - computed properties
    
    var openedItemCount: Int {
        return FoldItem.countFoldItem(self)
    }
    
    // fold level
    var foldLevel: Int {
        return FoldItem.nodeLevel(self) - 1
    }
    
    // MARK: - Public methods
    
    func addSubFoldItem(item: FoldItem) {
        if subFoldItems == nil {
            subFoldItems = [FoldItem]()
        }
        subFoldItems?.append(item)
    }
    
    func addSubFoldItems(items: [FoldItem]) {
        for item in items {
            item.superFoldItem = self
            addSubFoldItem(item)
        }
    }
    
    // MARK: - subscript
    
    subscript(index: Int) -> FoldItem? {
        get {
            if let subItems = subFoldItems {
                return subItems[index]
            }
            return nil
        }
        
        set(newFoldItem) {
            if newFoldItem == nil {
                return
            }
            if subFoldItems != nil {
                subFoldItems![index] = newFoldItem!
            }
        }
    }
    
    // MARK: - Private
    
    private class func countFoldItem(item: FoldItem?) ->Int {
        guard let item = item else {
            return 0
        }
        guard let subItems = item.subFoldItems else {
            return 1
        }
        if !item.foldOpened {
            return 1
        } else {
            var sum = 1
            for subItem in subItems {
                sum += countFoldItem(subItem)
            }
            return sum
        }
    }
    
    private class func nodeLevel(item: FoldItem?) ->Int {
        guard let item = item else {
            return 0
        }
        return nodeLevel(item.superFoldItem) + 1
    }
}

typealias FoldMenuList = FoldItem

extension FoldMenuList {
    
    convenience init(foldIdentifier: String) {
        self.init(foldIdentifier: foldIdentifier, foldName: "", foldOpened:true, subFoldItems: nil)
    }
    
    var allVisibleItems: [FoldItem]? {
        guard let subItems = self.subFoldItems else {
            return nil;
        }
        var visibleItems = [FoldItem]()
        for item in subItems {
            FoldMenuList.add(item, to: &visibleItems)
        }
        return visibleItems
    }
    
    // MARK: - Private
    private class func add(item: FoldItem?, inout to visibleItems: [FoldItem]) {
        guard let item = item else {
            return
        }
        guard let subItems = item.subFoldItems else {
            visibleItems.append(item);
            return
        }
        if !item.foldOpened {
            visibleItems.append(item);
            return
        } else {
            visibleItems.append(item);
            for subItem in subItems {
                add(subItem, to: &visibleItems)
            }
            return
        }
    }

}
