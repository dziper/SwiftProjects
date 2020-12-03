//
//  File.swift
//  Challenge5
//
//  Created by Daniel Ziper on 7/17/20.
//  Copyright © 2020 Daniel Ziper. All rights reserved.
//

import Foundation

class CountryList: NSObject, Codable{
    var countries: [Country]
    init(countries: [Country]) {
        self.countries = countries
    }
}

class Country: NSObject, Codable {
    var name: String
    var population: Int
    var facts: [String]
    var dateFounded: String
    
    init(name: String, population: Int, dateFounded: String, facts: [String]) {
        self.name = name
        self.population = population
        self.facts = facts
        self.dateFounded = dateFounded
    }
    
    func listInfo() -> [String]{
        return ["Population: \(population)", "Date Founded: \(dateFounded)"," ","Some facts about \(name): "] + facts
    }
}
