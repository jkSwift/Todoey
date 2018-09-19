//
//  Item.swift
//  Todoey
//
//  Created by John Kine on 2018-09-17.
//  Copyright © 2018 John Kine. All rights reserved.
//

import Foundation

struct itemdata : Codable {
    var itemDesciption:String?
    var done:Bool?
}
class Item  {
    
    static let instance = Item()
    
    private var _itemlist = [itemdata]()
    
    func loadItemList(itemList:[itemdata]) {
        _itemlist = itemList
    }
    
    func addItem(item:itemdata) {
        _itemlist.append(item)
    }
    
    func setItemStatus(index:Int, completed:Bool) {
        _itemlist[index].done = completed
    }
    
    var itemData:[itemdata] {
        return _itemlist
    }
    
}
