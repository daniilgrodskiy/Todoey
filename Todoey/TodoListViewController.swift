//
//  ViewController.swift
//  Todoey
//
//  Created by Daniil Grodskiy on 2/4/18.
//  Copyright © 2018 Daniil Grodskiy. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    //by simply inheriting a UITableViewController and adding a TableView to the storyboard instead of a UIViewController, all of the IBOutlets and being the delegate/datasource is all taken care of
    
    var itemArray = ["Find Mike", "Buy Eggos", "Destory Demogorgon"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            //changed 'itemArray = defaults.array(forKey: "TodoListArray") as! [String]'
            ///into an if-statement that checks to see if a value for our array exists
            itemArray = items
            
        }
        

    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //creates number of rows based on the # of items in 'itemArray'
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //kind of like making an object
        //"make an object of the cell identifier "ToDoItemCell" called cell [THIS IS NOT WHAT YOU'RE DOING BUT IT HELPS UNDERSTAND THIS ALL]
        //let the text of each cell be determined by the item in the array and its associated row value
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //function is used for selecting rows
        
        //print(itemArray[indexPath.row])
        //gonna print the number of the specific cell row that is tapped
        
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        //affects the current cell
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        //affects accessoryType property and checks to see whether it already has a checkmark or not

        
        tableView.deselectRow(at: indexPath, animated: true)
        //flashes gray for a second but then goes back to being white
        
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        //created so that this local variable can be accessed later and turned into alertTextField; before, alertTextField was a local variable inside a function, but now, it can be turned into a local variable inside this IBAction
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        //makes a new alert
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on the our UIAlert
            
            self.itemArray.append(textField.text!)
            //adds what we typed in the text field into an array
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            //line is necessary to actually getting what we typed in the textfield into the cells
            //MUST HAVE THIS LINE
            
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
    
    
    




}

