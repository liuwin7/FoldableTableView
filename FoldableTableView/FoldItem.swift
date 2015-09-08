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

    /// 保存identifier和item的映射关系
    private var identifierFoldItem = [String: FoldItem]()
    
    init?(foldIdentifier: String, foldName: String?, foldOpened: Bool, subFoldItems: [FoldItem]?) {
        self.foldIdentifier = foldIdentifier
        self.foldName = foldName
        self.foldOpened = foldOpened
        self.subFoldItems = subFoldItems
        if let subItems = self.subFoldItems {
            var allIdentifiders = Set<String>() // 临时保存当前节点的所有子节点的id
            for subItem in subItems {
                // 有重复的foldIdentifier创建就会失败
                let itemIdentifier = subItem.foldIdentifier
                if allIdentifiders.contains(itemIdentifier) {
                    return nil
                }
                allIdentifiders.insert(itemIdentifier)
                identifierFoldItem[itemIdentifier] = subItem
                subItem.superFoldItem = self
            }
            self.foldOpened = false
        }
    }
    
    convenience init?(foldIdentifier: String, foldName: String?, subFoldItems: [FoldItem]?) {
        self.init(foldIdentifier: foldIdentifier, foldName: foldName, foldOpened:false, subFoldItems: subFoldItems)
    }

    init(foldIdentifier: String, foldName: String?, subFoldItem: FoldItem) {
        self.foldIdentifier = foldIdentifier
        self.foldName = foldName
        self.foldOpened = false
        subFoldItem.superFoldItem = self
        self.subFoldItems = [subFoldItem]
    }
    
    init(foldIdentifier: String, foldName: String?) {
        self.foldIdentifier = foldIdentifier
        self.foldName = foldName
        self.foldOpened = true
        self.subFoldItems = nil
    }
    
    
    // MARK: - computed properties
    
    var allSubItems: [FoldItem] {
        return Array(identifierFoldItem.values)
    }
    
    var isVisible: Bool {
        guard let superItem = self.superFoldItem else {
            return false
        }
        return superItem.foldOpened
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
    
    func foldItem(identifier: String) ->FoldItem? {
        return identifierFoldItem[identifier]
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
    private class func nodeLevel(item: FoldItem?) ->Int {
        guard let item = item else {
            return 0
        }
        return nodeLevel(item.superFoldItem) + 1
    }
}