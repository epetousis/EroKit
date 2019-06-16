//
//  PsychoactiveType.swift
//  EroKit
//
//  Created by Evangelos Petousis on 16/6/19.
//  Copyright © 2019 Evangelos Petousis. All rights reserved.
//

import Foundation

// PsychoactiveTypes are found from https://erowid.org/general/big_chart.shtml
// The Big Chart is very straightforward to scrape.
struct PsychoactiveType: Codable, Equatable {
    let name: String
    let path: String
}
