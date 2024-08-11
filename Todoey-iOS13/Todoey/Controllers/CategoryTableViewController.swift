//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Neel Arora on 7/31/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
class CategoryTableViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    var categoryArray: Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        tableView.rowHeight = 80.0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Found"
        cell.backgroundColor = UIColor.systemRed
        return cell
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        // When the add button gets clicked
        let action = UIAlertAction(title: "Add Category", style: .default) { action in
            // MARK: Creating with CoreData
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
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
    func save(category: Category){
        do{
            try realm.write{
                realm.add(category)
            }
        }catch{
            print("Error saving context \(error)")
        }
        
        
        self.tableView.reloadData()
    }
    func loadItems(){
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
    }
    // MARK: Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let category = self.categoryArray?[indexPath.row]{
            do{
                try self.realm.write{
                    self.realm.delete(category)
                }
            }catch{
                print("Error While Running: \(error)")
            }
        }
    }
    
}

