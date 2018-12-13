//
//  ViewController.swift
//  CodableTest
//
//  Created by Nick on 2018/12/13.
//  Copyright © 2018 kciN.niL.App. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var models: [FloorModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func setupData() {
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
        do {
            let model = try JSONDecoder().decode(FloorContentModel.self, from: json)
            let cleanModels = model.data.filter {
                if case .none = $0 {
                    return false
                } else {
                    return true
                }
            }
            self.models = cleanModels
        } catch {
            print(msg: error)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model {
        default:
            break
        }
        return UITableViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.row]
        switch model {
        default:
            break
        }
        return UICollectionViewCell()
    }
}

