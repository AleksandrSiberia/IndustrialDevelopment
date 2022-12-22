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




    func testInitFetchedResultsControllerPostCoreData() throws {

        // when

        let fetchedResultsControllerPostCoreData = sut.fetchedResultsControllerPostCoreData

        // then

        XCTAssertNotNil(fetchedResultsControllerPostCoreData, "PersistentContainer == nil")
    }



    
    func testInitBackgroundContext() throws {

        // when
        let backgroundContext = sut.backgroundContext

        //then

        XCTAssertNotNil(backgroundContext)

    }



    func testSaveFolder() throws {

        // when

        sut.appendFolder(name: "TestPosts")

        let folder = sut.getFolderByName(nameFolder: "TestPosts") as AnyObject


        //then

        XCTAssertNotNil(folder, "папка не сохранилась")

    }



    func testDeleteAllTestPostsFoldersInCoreData() throws {

        // given

        let foldersSwiftArray = sut.getAllFolders()! as NSArray


        // when

        for _ in foldersSwiftArray {

            if let folder = sut.getFolderByName(nameFolder: "TestPosts") {

                sut.deleteFolder(folder: folder )
            }
            
        }

        let foldersNSArray = sut.getFolderByName(nameFolder: "TestPosts")


        // then

        XCTAssertNil(foldersNSArray, "папка не удалилась")
    }

}
