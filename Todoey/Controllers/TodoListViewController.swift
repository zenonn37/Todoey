//
//  ViewController.swift
//  Todoey
//
//  Created by Chris on 5/7/18.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit
import CoreData


class TodoListViewController: UITableViewController {

    
   
    var itemArray = [Item]()
    
    //let defaults = UserDefaults.standard
      let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         print(FileManager.default.urls(for: .documentDirectory, in:.userDomainMask)
        )
        
       
        //print(dataFilePath)
        //print(defaults.object(forKey: "AppLastUsed") as! )
      
       
        /*
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
           itemArray = items
       }
 */
        
        loadItems()
      
    }

   
//MARK - Tableview Datasource Meth
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    
    //MARK - TableviewDelegates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        itemArray[indexPath.row].setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        savedItems()
        
    
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert  = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when clicked
            
          
            
            let newItem = Item(context: self.context)
                newItem.title = textField.text!
                newItem.done = false
                self.itemArray.append(newItem)
            
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
           
            self.savedItems()
           
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
           textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
    
    
    //MARK - Model Manupulation Methos
    
    func savedItems(){
      
        
        do{
          try context.save()
        }catch{
            print("Error saving\(error)")
        }
        
        self.tableView.reloadData()
    }
    
    
    func loadItems(){
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do{
             itemArray = try context.fetch(request)
        }catch{
            print(error)
        }
       
    
    }
 
   
   
}

