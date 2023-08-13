//
//  CountriesAPI.swift
//  MedBook
//
//  Created by Ritik Raj on 12/08/23.
//

import Foundation

struct CountriesAPI: API {
    var path: String {
        return "/data/v1/countries"
    }
    
    var queryParam: [String : String]? {
        return nil
    }
}

struct CountriesData: Codable {
    let status: String?
    let statusCode: Int?
    let version: String?
    let access: String?
    let data: [String: CountryData]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status-code"
        case version
        case access
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        
        self.status = try? container?.decodeIfPresent(String.self, forKey: .status)
        self.statusCode = try? container?.decodeIfPresent(Int.self, forKey: .statusCode)
        self.version = try? container?.decodeIfPresent(String.self, forKey: .version)
        self.access = try? container?.decodeIfPresent(String.self, forKey: .access)
        self.data = try? container?.decodeIfPresent([String : CountryData].self, forKey: .data)
        
    }
}

struct CountryData: Codable {
    let country: String?
    let region: String?
}
