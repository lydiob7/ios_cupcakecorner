//
//  Order.swift
//  CupcakeCorner
//
//  Created by Tomi Scattini on 08/08/2024.
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chcolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = "" {
        didSet {
            if let encoded = try? JSONEncoder().encode(name) {
                UserDefaults.standard.set(encoded, forKey: "userName")
            }
        }
    }
    var streetAddress = "" {
        didSet {
            if let encoded = try? JSONEncoder().encode(streetAddress) {
                UserDefaults.standard.set(encoded, forKey: "userStreetAddress")
            }
        }
    }
    var city = "" {
        didSet {
            if let encoded = try? JSONEncoder().encode(city) {
                UserDefaults.standard.set(encoded, forKey: "userCity")
            }
        }
    }
    var zip = "" {
        didSet {
            if let encoded = try? JSONEncoder().encode(zip) {
                UserDefaults.standard.set(encoded, forKey: "userZip")
            }
        }
    }
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        
        cost += Decimal(type) / 2
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
    
    init() {
        if let savedName = UserDefaults.standard.data(forKey: "userName") {
           if let decodedName = try? JSONDecoder().decode(String.self, from: savedName) {
               self.name = decodedName
           }
       }
        if let savedStreetAddress = UserDefaults.standard.data(forKey: "userStreetAddress") {
           if let decodedStreetAddress = try? JSONDecoder().decode(String.self, from: savedStreetAddress) {
               self.streetAddress = decodedStreetAddress
           }
       }
        if let savedCity = UserDefaults.standard.data(forKey: "userCity") {
           if let decodedCity = try? JSONDecoder().decode(String.self, from: savedCity) {
               self.city = decodedCity
           }
       }
        if let savedZip = UserDefaults.standard.data(forKey: "userZip") {
           if let decodedZip = try? JSONDecoder().decode(String.self, from: savedZip) {
               self.zip = decodedZip
           }
       }
    }
}
