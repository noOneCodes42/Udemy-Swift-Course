//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
class TodoListViewController: SwipeTableViewController {
    var itemArray: Results<Item>?
    let realm = try! Realm()
// MARK: Reading data from the CoreData database
    var selectedCategory: Category? {
        didSet{
            loadItems()
            tableView.rowHeight = 80.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(dataFilePath)

        
        //        }
        // Do any additional setup after loading the view.
        
    }
    // MARK: This is where we use the database to see how man rows are there and also, if there are any text or not
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = itemArray?[indexPath.row].title ?? "No Items Found"
        cell.accessoryType = itemArray! [indexPath.row].done ? .checkmark : .none
//        if let item = itemArray?[indexPath.row] {
//            cell.textLabel?.text = item.title
//            // MARK: You can edit items here with CoreData
//
//            // Set acccessoryType if item.done is true then add .checkmark else : then have .none
//            // This is Substitue for an if statements
            
//        }else{
//            cell.textLabel?.text = "No Items Added"
//        }
//        
        return cell
    }
    // MARK: This is where we change the checkmark
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = itemArray?[indexPath.row]{
            do{
                try realm.write{
                    item.done = !item.done
//                    realm.delete(item)
                }
            }catch{
                print("The error is \(error)")
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        
        
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todey Item", message: "", preferredStyle: .alert)
        
        // When the add button gets clicked
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            // MARK: Creating with Realm
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write{
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    print(error)
                }
            }
            self.tableView.reloadData()
           

            //            newItem.title = textField.text!
//            newItem.done = false
//            newItem.parentCategory = self.selectedCategory
//            self.itemArray.append(newItem)

            
            
            self.tableView.reloadData()
        }
        // When the textfield gets created
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        // When the highlight of the text field goes away
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func saveItems(){
        do{
            print("hi")
        }catch{
            print("Error saving context \(error)")
        }
        
        
        self.tableView.reloadData()
    }
    // This makes it so that the default value is Item.fetchRequest()
    func loadItems(){
        itemArray = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let items = itemArray?[indexPath.row]{
            do{
                try realm.write{
                    realm.delete(items)
                }
            }catch{
                print("Error Loading Content \(error)")
            }
        }
    }
    

}
// Use Extensions to split up the controller
// MARK: - Search Bar Methods
extension TodoListViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // This line of code makes it so that it sorts it by the time and also the text.
        itemArray = itemArray?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
