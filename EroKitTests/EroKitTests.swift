//
//  EroKitTests.swift
//  EroKitTests
//
//  Created by Evangelos Petousis on 16/6/19.
//  Copyright © 2019 Evangelos Petousis. All rights reserved.
//

import XCTest
@testable import EroKit

class RetrieveTest {
    static func retrieve(sender: AnyClass, resource: String, type: String) -> String? {
        let bundle = Bundle(for: sender)
        let path = bundle.path(forResource: resource, ofType: type)
        let string = try? String(contentsOfFile: path!, encoding: .utf8)
        return string
    }
}

class EroKitTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPsychoactiveTypes() {
        guard let testHTML = RetrieveTest.retrieve(sender: self.classForCoder,
                                             resource: "big_chart",
                                             type: "shtml") else {
                                                XCTFail("Unable to retrieve")
                                                return
        }
        do {
            let parsedTypes = try ErowidParser.parsePsychoactiveTypes(html: testHTML)

            let correctTypes = [EroKit.PsychoactiveType(name: "Chemicals", path: "/chemicals/"), EroKit.PsychoactiveType(name: "Plants", path: "/plants/"), EroKit.PsychoactiveType(name: "Herbs", path: "/herbs/"), EroKit.PsychoactiveType(name: "Pharms", path: "/pharms/"), EroKit.PsychoactiveType(name: "Smarts", path: "/smarts/"), EroKit.PsychoactiveType(name: "Animals", path: "/animals/")]

            XCTAssertEqual(parsedTypes, correctTypes, "Parsed types were not correct")
        } catch {
            XCTFail("Unknown error occurred whilst parsing PsychoactiveTypes.")
        }
    }
    
    func testLimitedPsychoactive() {
        guard let testHTML = RetrieveTest.retrieve(sender: self.classForCoder,
                                                   resource: "chemicals",
                                                   type: "shtml") else {
                                                    XCTFail("Unable to retrieve")
                                                    return
        }
        do {
            let parsedPsychoactives = try ErowidParser
                .parsePsychoactives(type: PsychoactiveType(name: "Chemicals",
                                                           path: "/chemicals/"),
                                    html: testHTML)
            
            let correctPsychoactive = EroKit.Psychoactive(name: "Alcohol", detailURL: "/chemicals/alcohol/alcohol.shtml", common: "Beer, Wine, Liquor", description: "Depressant")
            
            let parsedPsychoactive = parsedPsychoactives.first(where: { $0.name == "Alcohol" })

            XCTAssertGreaterThan(parsedPsychoactives.count, 0, "No psychoactives were parsed")
            XCTAssertNotNil(parsedPsychoactive, "No psychoactive matched name Alcohol")
            XCTAssertEqual(parsedPsychoactive, correctPsychoactive, "Parsed types were not correct")
        } catch {
            XCTFail("Unknown error occurred whilst parsing Psychoactives.")
        }
    }

}
