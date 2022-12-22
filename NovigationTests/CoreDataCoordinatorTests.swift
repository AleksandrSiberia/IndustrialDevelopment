//
//  CoreDataCoordinatorTests.swift
//  NovigationTests
//
//  Created by Александр Хмыров on 21.12.2022.
//

import XCTest
import CoreData

@testable import Novigation



final class CoreDataCoordinatorTests: XCTestCase {

    var sut: CoreDataCoordinator!
 //   var reportService: ReportService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = CoreDataCoordinator()
    }


    override func tearDownWithError() throws {
        self.sut = nil

        try super.tearDownWithError()
      
    }



    func testPersistentContainer() throws {

        // given

        let pc = sut.fetchedResultsControllerPostCoreData

        XCTAssertNotNil(pc, "PersistentContainer == nil")

    }

    
    func testIWantToSaveTheFolderInCoreData() throws {

        sut.appendFolder(name: "TestPosts")



        let folder = sut.getFolderByName(nameFolder: "TestPosts")


        XCTAssertNotNil(folder, "Error folder TestPosts == nil")

    }

//    func testIWantToSaveThePostInCoreData() {
//
//        sut.appendPost(author: "Tom", image: "", likes: "2", text: "", views: "", folderName: "TestFolder") { string in
//
//            print("✨", string ?? "nil")
//        }
//    }


    



}
