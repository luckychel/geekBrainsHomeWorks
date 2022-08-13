//
//  Weather.swift
//  weatherApp
//
//  Created by Александр Кукоба on 13.08.2022.
//

import Foundation

struct Weather : Decodable {
    
    let id: Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
    }
}
