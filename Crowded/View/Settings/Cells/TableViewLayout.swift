//
//  TableViewLayout.swift
//  Memoriam
//
//  Created by Blain Ellis on 13/08/2020.
//  Copyright © 2020 EllisAppDev. All rights reserved.
//

import UIKit

enum CellType {
    case Header
     case Details
    case TextField
    case TextView
    case Space
    case Spacer

}

class TableViewLayout {
    
    var cellType: CellType!
    var value: String?
    var placeholder: String?
    var object: Any!
    var isEditable = true
    
    init(cellType: CellType = .Header, value: String? = nil, placeholder: String? = nil, object: Any? = nil, isEditable: Bool = true) {
        self.cellType = cellType
        self.value = value
        self.placeholder = placeholder
        self.object = object
        self.isEditable = isEditable
    }
    
    static func getHeightForType(_ cellType: CellType, frame: CGRect? = nil) -> CGFloat {
        
        var height: CGFloat = 0.0
        switch cellType {
        case .Header:
            height = 40
        case .Details:
            height = 40
        case .TextField:
            height = 58
        case .TextView:
            height = 108
        case .Space:
            height = 80
        case .Spacer:
            height = 80
        }
        return height
    }
}
