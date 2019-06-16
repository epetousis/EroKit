//
//  Psychoactive.swift
//  EroKit
//
//  Created by Evangelos Petousis on 16/6/19.
//  Copyright © 2019 Evangelos Petousis. All rights reserved.
//

import Foundation

struct Psychoactive: Codable, Equatable {
    let name: String
    let detailURL: String
    let common: String? // This is sometimes referred to as OTHER NAMES, GENUS / SPECIES or COMMON NAME.
    let description: String? // AKA: EFFECTS, USES, CONSTITUENTS, NATIVE TO
}
