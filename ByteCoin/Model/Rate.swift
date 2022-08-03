//
//  Rate.swift
//  ByteCoin
//
//  Created by Eugeniu Garaz on 8/3/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct Rate: Decodable {
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
