//
//  ViewController.swift
//  Challenge1
//
//  Created by Daniel Ziper on 6/28/20.
//  Copyright © 2020 Daniel Ziper. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var flagNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flag Viewer"
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        for i in items{
            if i.hasSuffix(".png"){
                flagNames.append(String(i.prefix(i.count - 4)))
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flagNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        cell.textLabel?.text = flagNames[indexPath.row]
        
        let imageName = flagNames[indexPath.row] + ".png"
        cell.imageView?.image = UIImage(named: imageName)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController{
            vc.selectedImage = flagNames[indexPath.row] + ".png"
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

