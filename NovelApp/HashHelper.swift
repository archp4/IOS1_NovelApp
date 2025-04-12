//
//  HashHelper.swift
//  NovelApp
//
//  Created by Arch Umeshbhai Patel on 2025-04-11.
//

import Foundation


class HashHelper: Hashable {
    var name: String = ""
    static func == (lhs: HashHelper, rhs: HashHelper) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    init(name:String) {
        self.name = name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
}
