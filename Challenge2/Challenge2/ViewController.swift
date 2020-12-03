//
//  ViewController.swift
//  Challenge2
//
//  Created by Daniel Ziper on 7/4/20.
//  Copyright © 2020 Daniel Ziper. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadItems))
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    @objc func reloadItems(){
        items.removeAll()
        tableView.reloadData()
    }
    
    @objc func addItem(){
        let ac = UIAlertController(title: "Add an item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
                guard let answer = ac?.textFields?[0].text else { return }
            self?.items.insert(answer, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
                
            }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
   
    
    

}

