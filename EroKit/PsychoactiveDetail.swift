//
//  PsychoactiveDetail.swift
//  EroKit
//
//  Created by Evangelos Petousis on 16/6/19.
//  Copyright © 2019 Evangelos Petousis. All rights reserved.
//

import Foundation

public struct PsychoactiveDetail: Codable {
    public let commonNames: String
    public let effectClassification: String
    public let chemicalName: String
    public let description: String
    
    public let basicsURL: String
    public let effectsURL: String
    public let imagesURL: String
    public let healthURL: String
    public let lawURL: String
    public let doseURL: String
    public let chemistryURL: String
}
