//
//  JsonHelper.swift
//  Offline
//
//  Created by Blain Ellis on 16/09/2021.
//  Copyright © 2021 Voxpopme Ltd. All rights reserved.
//

import Foundation

class JsonHelper {
    
    static func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}
 
