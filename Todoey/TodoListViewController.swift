//
//  TodoListViewController.swift
//  Todoey
//
//  Created by John Kine on 2018-09-15.
//  Copyright © 2018 John Kine. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let  dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
        
    }
    
    //MARK - Tableview Datasource Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Item.instance.itemData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as! ToDoListCell
        
        cell.toDoListCellLbl.text = Item.instance.itemData[indexPath.row].itemDesciption
        cell.accessoryType = Item.instance.itemData[indexPath.row].done! ? .checkmark : .none
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            Item.instance.setItemStatus(index: indexPath.row, completed: !Item.instance.itemData[indexPath.row].done!)
            saveItems()
            cell.accessoryType = Item.instance.itemData[indexPath.row].done! ? .checkmark : .none

        }
    }
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = itemdata(itemDesciption: textField.text, done: false)
            Item.instance.addItem(item: newItem)
            self.saveItems()
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                //var list:[itemdata] = [itemdata]()
                //list = try decoder.decode([itemdata].self, from: data)
                Item.instance.loadItemList(itemList: try decoder.decode([itemdata].self, from: data))
            } catch {
                print("Error encoding item array, \(error)")
            }
        }
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(Item.instance.itemData)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
    }
    
}
