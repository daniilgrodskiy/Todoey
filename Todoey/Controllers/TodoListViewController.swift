//
//  ViewController.swift
//  Todoey
//
//  Created by Daniil Grodskiy on 2/4/18.
//  Copyright © 2018 Daniil Grodskiy. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    //by simply inheriting a UITableViewController and adding a TableView to the storyboard instead of a UIViewController, all of the IBOutlets and being the delegate/datasource is all taken care of
    
    var todoItems: Results<Item>?
    //an EMPTY array of Item objects; the '()' means that it's empty
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet {
            //all of this will happen when the optional selectedCategory is given a value
            loadItems()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //creates number of rows based on the # of items in 'itemArray'
        
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
            
        }
        return cell
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            //checking to see if todoItems is not nil, and if it's not then, we pick out the item at indexPath.row and set it equal to item
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        tableView.reloadData()
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once "Add Item" is clicked in our UIAlert
            if let currentCategory = self.selectedCategory {
                //gotta make sure currentCategory isn't empty
                do {
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            //this is creating a textfield inside the alert
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        //these two lines above are important to actually making the alert popup??!!??
    }
    
    
    func loadItems() {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }


}

//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate {

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {

            loadItems()
            
            DispatchQueue.main.async{
                //DispatchQueue is in charge of asigning the roles of all the threads
                //necessary to specify that the we are affecting the main thread
                searchBar.resignFirstResponder()
                //makes the searchBar no longer the thing that is currently selected
            }
            
        }
    }
    
}



