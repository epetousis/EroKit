//
//  Psychoactive.swift
//  EroKit
//
//  Created by Evangelos Petousis on 16/6/19.
//  Copyright © 2019 Evangelos Petousis. All rights reserved.
//

import Foundation
import SwiftSoup

struct Psychoactive: Codable, Equatable {
    let name: String
    let detailURL: String
    let common: String? // This is sometimes referred to as OTHER NAMES, GENUS / SPECIES or COMMON NAME.
    let description: String? // AKA: EFFECTS, USES, CONSTITUENTS, NATIVE TO
}

extension ErowidParser {
    static func parsePsychoactives(type: PsychoactiveType, html: String) throws -> Array<Psychoactive> {
        let doc: Document = try SwiftSoup.parse(html)
        
        // Select the main psychedelic table on the psychedelic type page.
        let table = try doc.select("#content-body-frame > .content-section > table.topic-chart-surround")
        
        // Grab header row
        // let headerRow = try table.select("tbody > tr").first()!
        
        // Grab everything BUT the header row
        let psychoactiveRows = try table.select("tbody > tr").dropFirst()
        var psychs: Array<Psychoactive> = []
        
        for row in psychoactiveRows {
            // Grab data rows
            // Each data row in the psychoactive table has a class - topic-name, topic-common and topic-desc. Easily extractable.
            let name = try row.select("td.topic-name > a").text()
            let url = try row.select("td.topic-name > a").attr("href")
            let commonNames: String? = try row.select("td.topic-common")
                .text()
                .trimmingCharacters(in: .punctuationCharacters)
            let description: String? = try row.select("td.topic-desc")
                .text()
                .trimmingCharacters(in: .punctuationCharacters)
            let psych = Psychoactive(name: name.capitalized,
                                     detailURL: type.path + url,
                                     common: commonNames.nilIfEmpty,
                                     description: description.nilIfEmpty)
            psychs.append(psych)
        }
        
        // TODO: Return general information index links (from bottom of page) as well
        return psychs
    }
}
