//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Neel Arora on 7/31/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        // MARK: You can edit items here with CoreData
        
        // Set acccessoryType if item.done is true then add .checkmark else : then have .none
        // This is Substitue for an if statements
        return cell
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        // When the add button gets clicked
        let action = UIAlertAction(title: "Add Category", style: .default) { action in
            // MARK: Creating with CoreData
            
            let newItem = Category(context: self.context)
            newItem.name = textField.text!
            self.categoryArray.append(newItem)
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
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add New Category"
            textField = alertTextField
        }
        // When the highlight of the text field goes away
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    //MARK: Data Manipulation Methods
    func saveItems(){
        do{
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
        
        
        self.tableView.reloadData()
    }
    func loadItems(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        // Must specify the data type of the out put
        do{
            categoryArray = try context.fetch(request)
        }catch{
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
}
