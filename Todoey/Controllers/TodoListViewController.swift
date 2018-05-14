//
//  ViewController.swift
//  Todoey
//
//  Created by Chris on 5/7/18.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    
   
    var itemArray = [Item]()
    
    //let defaults = UserDefaults.standard
    
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
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
        //print(itemArray[indexPath.row])
       // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
       
        /*
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
 */
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        savedItems()
        
       // tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert  = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when clicked
            
            let newItem = Item()
            newItem.title = textField.text!
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
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error")
        }
        
        self.tableView.reloadData()
    }
    
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
          let decoder = PropertyListDecoder()
            do{
            itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("errors reading file")
            }
        }
    
    }
   
   
}

