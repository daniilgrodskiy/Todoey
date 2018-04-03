//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Daniil Grodskiy on 4/3/18.
//  Copyright © 2018 Daniil Grodskiy. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()

    }
    
    
    //MARK: - TableView Datasource Methods
    //1st: numberOfRowsInSection
    //2nd: cellForRowAt indexPath:
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //creates number of rows based on the # of items in 'itemArray'
        
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //"make an object (sort of) of the cell identifier "ToDoItemCell" called cell"
        //let the text of each cell be determined by the item in the array and its associated row value
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    //1st: didSelectRowAt
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //function is used for selecting rows
        //what happends when you tap on a cell

        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            //we're wrapping it around a conditional because indexPathForSelectedRow is an optional
            
            destinationVC.selectedCategory = categories[indexPath.row]
            
        }
    }
    
    
    
    //MARK: - Data Manipulation Methods
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    //MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on the our UIAlert
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            
            self.saveCategories()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            //this is creating a textfield inside the alert
            
            textField = field
            textField.placeholder = "Add a new category"

        }
        
        present(alert, animated: true, completion: nil)
        
    }
    

    
    
    
}
