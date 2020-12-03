//
//  ViewController.swift
//  Challenge5
//
//  Created by Daniel Ziper on 7/17/20.
//  Copyright © 2020 Daniel Ziper. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UITableViewController {
    
    var countries: CountryList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let countriesUrl = Bundle.main.url(forResource: "countries", withExtension: "json"){
            if let countriesData = try? Data(contentsOf: countriesUrl){
                let jsonDecoder = JSONDecoder()
                do {
                    countries = try jsonDecoder.decode(CountryList.self, from: countriesData)
                    //taht toook a long time
                    print("ladies and gentlemen")
                }catch{
                    print("failed")
                }
            }
        }
        
        title = "Country Browser"
        
        
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = countries.countries[indexPath.row].name
//        cell.textLabel?.text = testCountry.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countries.countries[indexPath.row]
        
        if let tvc = storyboard?.instantiateViewController(identifier: "CountryViewer") as? CountryViewer{
            tvc.country = country
            navigationController?.pushViewController(tvc, animated: true)
            
        }
    }
    
    
}

