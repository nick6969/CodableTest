//
//  CodableTestTests.swift
//  CodableTestTests
//
//  Created by Nick on 2018/12/13.
//  Copyright © 2018 kciN.niL.App. All rights reserved.
//

import XCTest
@testable import CodableTest

class CodableTestTests: XCTestCase {

    let json = """
{
    "data": [
        {
            "type": 0,
            "title": "hello world"
        },
        {
            "type": 1,
            "data": [
                {
                    "imageUrl": "....",
                    "url": "......"
                },
                {
                    "imageUrl": "....",
                    "url": "......"
                },
                {
                    "imageUrl": "....",
                    "url": "......"
                }
            ]
        },
        {
            "type": 2,
            "title": "first floor",
            "subTitle": "wellcome",
            "data": [
                {
                    "title": "201",
                    "desc": "201-1",
                    "imageUrl": "....",
                    "url": "......"
                },
                {
                    "title": "202",
                    "desc": "202-1",
                    "imageUrl": "....",
                    "url": "......"
                }
            ]
        },
        {
            "type": 3,
            "title": "second",
            "subTitle": "nice meet you",
            "data": [
                {
                    "title": "301",
                    "desc": "301-1",
                    "price": "123",
                    "originalPrice": "150",
                    "imageUrl": "....",
                    "url": "......"
                },
                {
                    "title": "301",
                    "desc": "301-1",
                    "price": "199",
                    "originalPrice": "250",
                    "imageUrl": "....",
                    "url": "......"
                }
            ]
        }
    ]
}
""".data(using: .utf8)!
    
    func testDecodeEncode() {
        let model = decode(data: json)
        do {
            let data = try JSONEncoder().encode(model)
            _ = decode(data: data)
        } catch {
            assertionFailure("encode fail")
        }
    }
    
    func decode(data: Data) -> FloorContentModel {
        var contentModel: FloorContentModel!
        do {
            contentModel = try JSONDecoder().decode(FloorContentModel.self, from: data)
            
            let models = contentModel.data
            assert(models.count == 4, "decode count wrong")
            
            let cleanModels = models.filter {
                if case .none = $0 {
                    return false
                } else {
                    return true
                }
            }
            assert(cleanModels.count == 4, "decode count wrong")

            if case let .title(title) = cleanModels[0] {
                assert(title == "hello world", "content wrong")
            } else {
                assertionFailure("content wrong")
            }
            
            if case let .floor01(models) = cleanModels[1] {
                assert(models.count == 3, "content wrong")
            } else {
                assertionFailure("content wrong")
            }

            if case let .floor02(model) = cleanModels[2] {
                assert(model.title == "first floor", "content wrong")
                assert(model.subTitle == "wellcome", "content wrong")
                assert(model.data.count == 2, "content wrong")
            } else {
                assertionFailure("content wrong")
            }

            if case let .floor03(model) = cleanModels[3] {
                assert(model.title == "second", "content wrong")
                assert(model.subTitle == "nice meet you", "content wrong")
                assert(model.data.count == 2, "content wrong")
            } else {
                assertionFailure("content wrong")
            }
        } catch {
            assertionFailure("\(error.localizedDescription)")
        }
        return contentModel
    }
}
