//
//  ReusableViewEnum.swift
//  Crowded
//
//  Created by Blain Ellis on 19/11/2020.
//

import Foundation

protocol TableViewEnum {}

extension TableViewEnum where Self: RawRepresentable, Self.RawValue == Int {
    static var all: [Self] {
        var index = 0
        var allItems = [Self]()
        while let item = Self(rawValue: index) {
            allItems.append(item)
            index += 1
        }
        return allItems
    }
    
    static func build(with value: Int) -> Self {
        guard let row = Self(rawValue: value) else {
            fatalError("Unimplemented value: \(value)")
        }
        return row
    }
}
