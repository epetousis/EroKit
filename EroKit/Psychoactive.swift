//
//  Psychoactive.swift
//  EroKit
//
//  Created by Evangelos Petousis on 16/6/19.
//  Copyright © 2019 Evangelos Petousis. All rights reserved.
//

import Foundation

struct Psychoactive: Codable {
    let name: String
    let type: PsychoactiveType
    let vaultURL: URL?
    let basicsURL: URL?
    let imagesURL: URL?
    let lawsURL: URL?
    let doseURL: URL?
    let experiencesURL: URL?
    let faqURL: URL?
    let effectsURL: URL?
    let chemistryURL: URL?
    let drugTestingURL: URL?
    let healthURL: URL?
    let historyURL: URL?
    let spiritualRitualURL: URL?
    let cultivationURL: URL?
    let booksURL: URL?
    let journalArticlesURL: URL?
    let writingsURL: URL?
    let mediaURL: URL?
}
