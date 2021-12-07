//
//  CitiesData.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 05/12/2021.
//

import Foundation

struct ResultsData: Codable {
    var result: Records?
}

struct Records: Codable {
    var limit: Int
    var records: [CityData]?
}

struct CityData: Codable {
    var cityName: String
    
    enum CodingKeys: String, CodingKey {
        case cityName = "שם_ישוב"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cityName = try container.decode(String.self, forKey: .cityName)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cityName, forKey: .cityName)
    }
}
