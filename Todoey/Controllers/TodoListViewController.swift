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
    
    var itemArray = [Item]()
    
    let dataFilePath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    //create a new plist in the path that represents the NSUserDefaults


    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            //changed 'itemArray = defaults.array(forKey: "TodoListArray") as! [String]'
//            ///into an if-statement that checks to see if a value for our array exists
//            itemArray = items
//        }
        

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
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator =>
        //value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//        SAME AS
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
        
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //function is used for selecting rows
        //what happends when you tap on a cell
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        SAME AS
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        saveItems()
        
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
            
            let newItem = Item()
            newItem.title = textField.text!
            
            
            self.itemArray.append(newItem)
            //adds what we typed in the text field into an array
            
            self.saveItems()
            

            
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
    
    func saveItems() {
        ////THIS IS THE CODE THAT ALLOWS US TO ENCODE THE DATA AND THEN SAVE IT IN Items.plist!!!
        let encoder = PropertyListEncoder()

        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        self.tableView.reloadData()
        //line is necessary to actually getting what we typed in the textfield into the cells
        //MUST HAVE THIS LINE
        
    }
    
    func loadItems() {
        if let data =  try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print ("Error decoding item array, \(error)")
            }
        }
    }
    




}

