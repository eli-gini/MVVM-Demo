//
//  City.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 05/12/2021.
//

import Foundation

@objcMembers class City: NSObject {
    var name: String
    
    
    init(cityName: String) {
        self.name = cityName
    }
}
