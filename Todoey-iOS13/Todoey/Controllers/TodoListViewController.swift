//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData
class TodoListViewController: UITableViewController {
    var itemArray = [Item]()
// MARK: Reading data from the CoreData database
    var selectedCategory: Category? {
        didSet{
            loadItems()
        }
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // .standard  is a signle ton, because, all the information that is being
    // added are all going to the same plist.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(dataFilePath)

        
        //        }
        // Do any additional setup after loading the view.
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        // MARK: You can edit items here with CoreData

        // Set acccessoryType if item.done is true then add .checkmark else : then have .none
        // This is Substitue for an if statements
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        // !ItemArray, This makes it opposite
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        
        // The order matters a lot to delete the items
        // MARK: Where you could delete items from the CoreData database

        // When you are changing something you need to use context.save
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todey Item", message: "", preferredStyle: .alert)
        
        // When the add button gets clicked
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            // MARK: Creating with CoreData

            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            // You can't append your own custom modules to the UserDefault, at this point
            // Use a database, only use UserDefault for small pieces of data like volume
            //            let encoder = PropertyListEncoder()
            //            do{
            //                let data = try encoder.encode(self.itemArray)
            //                try data.write(to: self.dataFilePath!)
            //            }catch{
            //                print("Error encoding item array \(error)")
            //            }
            self.saveItems()
            
            
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
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
        
        
        self.tableView.reloadData()
    }
    // This makes it so that the default value is Item.fetchRequest()
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        if let additionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        }else{
            request.predicate = categoryPredicate
        }
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
//        request.predicate = compoundPredicate
        // Must specify the data type of the out put
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
   

}
// Use Extensions to split up the controller
// MARK: - Search Bar Methods
extension TodoListViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        // The way it works is we are saying look at the title that contains, whatever is in the serarch bar
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadItems(with: request, predicate: predicate)
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
