//
//  ErowidParser.swift
//  EroKit
//
//  Created by Evangelos Petousis on 16/6/19.
//  Copyright © 2019 Evangelos Petousis. All rights reserved.
//

import Foundation
import SwiftSoup

class ErowidParser {
    static func parsePsychoactiveTypes(html: String) throws -> Array<PsychoactiveType> {
        var types: Array<PsychoactiveType> = []
        let doc: Document = try SwiftSoup.parse(html)
        
        // Select all tables in big_chart: these indicate every type of
        // psychoactive type that Erowid documents.
        let tables = try doc.select("#content-body-frame > .content-section > table")
            .array()
        
        types = try tables.map({ (el: Element) throws -> PsychoactiveType in
            // First (header) row of each table indicates a type of psychoactive.
            let headerRow = try el.select("tbody > tr").first()!
            let name = try headerRow.select("td > .h8").text()
            return PsychoactiveType(name: name.capitalized,
                                    path: "/\(name.lowercased())/")
        })
        return types
    }
}
