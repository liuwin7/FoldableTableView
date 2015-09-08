//
//  FoldItemList.swift
//  FoldableTableView
//
//  Created by tropsci on 15/9/7.
//  Copyright © 2015年 topsci. All rights reserved.
//

import Foundation

class FoldItemList {
    
    private var topFoldItem: FoldItem = FoldItem(foldIdentifier: "TopFoldItemIdentifer", foldName: "top item")
    
    private var visibleFoldItems = [FoldItem]()
    
    init(foldItems: [FoldItem]) {
        let tempFoldItem = FoldItem(foldIdentifier: "TopFoldItemIdentifer", foldName: "top item", foldOpened: true, subFoldItems: foldItems)
        if tempFoldItem != nil {
            topFoldItem = tempFoldItem!
            visibleFoldItems = foldItems
        }
        topFoldItem.foldOpened = true
    }
    
    // MARK: - Properties
    var allFoldItems:[FoldItem] {
        return topFoldItem.allSubItems
    }
    
    func visibles() ->[FoldItem] {
        return visibleFoldItems
    }
    
    // MARK: - Public Methods
    
    func openFoldItem(item: FoldItem) -> (Int, Int) {
        item.foldOpened = true
        var start = 0, end = 0
        // 把打开的item的所有子item加入到visible
        if let subItems = item.subFoldItems {
            var itemIndex = 0

            for subItem in visibleFoldItems {
                if subItem.foldIdentifier == item.foldIdentifier {
                    break
                }
                itemIndex++
            }
            
            start = itemIndex
            for subItem in subItems {
                itemIndex++
                visibleFoldItems.insert(subItem, atIndex:itemIndex)
            }
            end = itemIndex
        }
        return (start, end)
    }
    
    func closeFoldItem(item: FoldItem) -> (Int, Int){
        item.foldOpened = false
        var start = 0, end = 0
        
        // 把关闭的item的所有子item从visible中删掉
        if let subItems = item.subFoldItems {
            
            var itemIndex = 0
            for subItem in visibleFoldItems {
                if subItem.foldIdentifier == item.foldIdentifier {
                    break
                }
                itemIndex++
            }
            start = itemIndex
            end = itemIndex + subItems.count
            let subItemStartIndex = itemIndex + 1
            visibleFoldItems.removeRange(Range(start: subItemStartIndex, end: subItemStartIndex + subItems.count))
        }
        return (start, end)
    }
    
    func foldItem(foldIdentifier identifier: String) ->FoldItem? {
        return topFoldItem.foldItem(identifier)
    }
    
    
}