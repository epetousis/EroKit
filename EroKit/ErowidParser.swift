//
//  ErowidParser.swift
//  EroKit
//
//  Created by Evangelos Petousis on 16/6/19.
//  Copyright © 2019 Evangelos Petousis. All rights reserved.
//

import Foundation
import SwiftSoup

extension Optional where Wrapped == String {
    var nilIfEmpty: String? {
        guard let strongSelf = self else {
            return nil
        }
        return strongSelf.isEmpty ? nil : strongSelf
    }
}

class ErowidParser {
    static func parsePsychoactiveTypes(html: String) throws -> Array<PsychoactiveType> {
        var types: Array<PsychoactiveType> = []
        let doc: Document = try SwiftSoup.parse(html)
        
        // Select all tables in big_chart: these indicate every type of
        // psychoactive type that Erowid documents.
        let tables = try doc.select("#content-body-frame > .content-section > table")
            .array()
        
        types = try tables.map({ (el: Element) throws -> PsychoactiveType in
            // First (header) row of each table (and without a class) indicates a type of psychoactive.
            let headerRow = try el.select("tbody > tr").first()!
            let name = try headerRow.select("td > .h8").text()
            return PsychoactiveType(name: name.capitalized,
                                    path: "/\(name.lowercased())/")
        })
        return types
    }
    
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
