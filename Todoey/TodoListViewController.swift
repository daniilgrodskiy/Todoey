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
    
    let itemArray = ["Find Mike", "Buy Eggos", "Destory Demogorgon"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    




}

