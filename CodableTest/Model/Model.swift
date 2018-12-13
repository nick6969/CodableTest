//
//  Model.swift
//  CodableTest
//
//  Created by Nick on 2018/12/13.
//  Copyright © 2018 kciN.niL.App. All rights reserved.
//

import Foundation

struct DataContentModel<Data>: Codable where Data: Codable {
    let type: Int
    let title: String
    let subTitle: String
    let data: [Data]
}

struct Floor01Model: Codable {
    let imageUrl: String
    let url: String
}

struct Floor02Model: Codable {
    let title: String
    let desc: String
    let imageUrl: String
    let url: String
}

struct Floor03Model: Codable {
    let title: String
    let desc: String
    let imageUrl: String
    let url: String
    let price: String
    let originalPrice: String
}

struct FloorContentModel: Codable {
    let data: [FloorModel]
}

enum FloorModel: Codable {
    case title(String)
    case floor01([Floor01Model])
    case floor02(DataContentModel<Floor02Model>)
    case floor03(DataContentModel<Floor03Model>)
    
    case none
    
    private enum CodingKeys: String, CodingKey {
        case type
        case data
        case title
    }
    
    init(from decoder: Decoder) throws {
        let vals = try decoder.container(keyedBy: CodingKeys.self)
        guard let type = try? vals.decode(Int.self, forKey: .type) else {
            self = .none
            return
        }
        
        switch type {
        case 0:
            if let str = try? vals.decode(String.self, forKey: .title) {
                self = .title(str)
                return
            }
        case 1:
            if let models = try? vals.decode([Floor01Model].self, forKey: .data) {
                self = .floor01(models)
                return
            }
        case 2:
            let container = try decoder.singleValueContainer()
            if let model = try? container.decode(DataContentModel<Floor02Model>.self) {
                self = .floor02(model)
                return
            }

        case 3:
            let container = try decoder.singleValueContainer()
            if let model = try? container.decode(DataContentModel<Floor03Model>.self) {
                self = .floor03(model)
                return
            }
            
        default:
            break
        }
        self = .none
    }
    
    func encode(to encoder: Encoder) throws {
        switch self {
        case let .title(title):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(0, forKey: .type)
            try container.encode(title, forKey: .title)
            
        case let .floor01(models):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(1, forKey: .type)
            try container.encode(models, forKey: .data)
            
        case let .floor02(model):
            var container = encoder.singleValueContainer()
            try container.encode(model)
            
        case let .floor03(model):
            var container = encoder.singleValueContainer()
            try container.encode(model)
            
        default:
            break
        }
    }
}
