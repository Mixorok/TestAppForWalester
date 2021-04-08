//
//  Beer.swift
//  WallesterApp
//
//  Created by Максим on 31.03.2021.
//

import Foundation

struct Beer: Decodable {
    var name: String
    var abv: Double
    var ebc: Double?
    var ibu: Double?
    var favorite: Bool?
}
