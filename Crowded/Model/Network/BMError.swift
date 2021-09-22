//
//  BMError.swift
//  Crowded
//
//  Created by Blain Ellis on 20/11/2020.
//

import Foundation

class BMError {
    
    var errorId: Int
    var errorMessage: String
    
    init(_ errorId: Int,_ errorMessage: String) {
        self.errorId = errorId;
        self.errorMessage = errorMessage;
    }
}
