//
//  ViewController.swift
//  Todoey
//
//  Created by Daniil Grodskiy on 2/4/18.
//  Copyright © 2018 Daniil Grodskiy. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    //by simply inheriting a UITableViewController and adding a TableView to the storyboard instead of a UIViewController, all of the IBOutlets and being the delegate/datasource is all taken care of
    
    var itemArray = [Item]()
    //an array of Item() objects
    var selectedCategory : Category? {
        didSet {
            //all of this will happen when the optional selectedCategory is given a value
            loadItems()
            
        }
        
    }
    
//////CoreData Step 1 (declare context):
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //tapping into UIApplication class and getting the shared singleton object, which corresponds to the current app as an object, then tapping into its delegate, which has the datatype of an optional UIDelegate object, meaning that we need to cast it as our class, AppDelegate (both UIApplicationDelegate and AppDelegate inherit from the same class so it all works)


    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        //create a new plist in the path that represents the NSUserDefaults
        
        //searchBar.delegate = self
        
        
        
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
        //"make an object of the cell identifier "ToDoItemCell" called cell" [THIS IS NOT WHAT YOU'RE DOING BUT IT HELPS UNDERSTAND THIS ALL]
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
        
        //itemArray[indexPath.row].setValue("Completed", forKey: "title")
        //example of code that can also be used; i.e. you wanted to change the title to be "Completed" when a cell is clicked on
        
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        SAME AS
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        saveItems()
        ///saveItems() IS SO IMPORTANT OMG!! IT'S THE THING THAT SAVES THE ACTUAL ITEMS FROM THE CONTEXT INTO Core Data!! MUST HAVE IT TO TRANSFER ITEMS Context -> Core Data
        
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
            
////////////CoreData Step 2 (define the context for Item class) (first line):
            let newItem = Item(context: self.context)
            //newItem is of type NSModelObject; think of this as being the ROW of a table
            
            newItem.title = textField.text!
            //we fill each ROW with a title
            
            newItem.done = false
            //AND THEN well fill each ROW with a done state
            
            newItem.parentCategory = self.selectedCategory
            //then we have to specify what the parentCategory would be
            
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
    
////CoreData Step 3 (saveItems()):
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        //can create error so you need a do-catch block
        
        self.tableView.reloadData()
        //line is necessary to actually getting what we typed in the textfield into the cells
        //MUST HAVE THIS LINE
        
    }
    
////CoreData Step 4 (loadItems(with: )):
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        //'with' is the external parameter; it's what you'd use in other functions when calling loadItems(with: )
        //'request' is what's referenced and used inside this function
        //default value when called with just parenthesis is just Item.fetchRequest()
        
        //MUST specify data type as well the type of the entity that you're trying to request
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        
        do {
            itemArray = try context.fetch(request)
            //general request that just gets everything we have in our persistent container
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
    

    




}

//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate {
    //people make extensions like this instead of writing the code in the class itself so that all the code is neatly separated
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //what happens when user clicks on searchBar
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        //when we click searchBar, whatever is in the searchBar at that time point is going to be passed into this method and replacing the '%@'
        //[cd] makes it case-insensitive and diacritical-insensitive
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        //sorts code based on title
    
        loadItems(with: request, predicate: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            //delegate method will trigger whenever text is changed and has gone down to 0 (when click the cross/'x' button)
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



