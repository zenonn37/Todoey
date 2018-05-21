//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Chris on 5/14/18.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit
import CoreData


class CategoryTableViewController: UITableViewController {
    
    var categoryArray = [Category]()
    //var categoryArray = ["Car","Work","Friends"]
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    //Mark: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        //let item =
        
        cell.textLabel?.text =  categoryArray[indexPath.row].name
        
        return cell
    }
    
    //Mark: - Datasource Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
          performSegue(withIdentifier: "goToItems", sender: self)
        
        func prepare(for segue: UIStoryboardSegue, sender: Any?){
            let destination = segue.destination as! TodoListViewController
            
            if let indexPath = tableView.indexPathForSelectedRow{
                destination.selectedCategory = categoryArray[indexPath.row]
            }
        }
        
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Mark:

    
    //MARK - Add Button
    @IBAction func addBtnPress(_ sender: UIBarButtonItem) {
        //setup text field for alert box
        var textField = UITextField()
        
        //setup UIAlert box
        let alert = UIAlertController(title: "Enter New Category", message: "", preferredStyle: .alert)
        
        //setup UIAction
        let action = UIAlertAction(title: "Save", style: .default) { (action) in
            //setup context for Category class
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            print(textField.text!)
            self.save()
        }
        
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            textField.placeholder = "Add Category"
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    func save(){
        do{
            try context.save()
        }catch{
        print(error)
     }
        tableView.reloadData()
    }
    
    func loadCategories(){
        let request :NSFetchRequest<Category> = Category.fetchRequest()
        do{
            
       
        categoryArray =  try context.fetch(request)
        }catch{
            print(error)
        }
        tableView.reloadData()
            
        
    }
    

}
