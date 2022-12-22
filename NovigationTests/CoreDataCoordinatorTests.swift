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



    func testInitPersistentContainer() throws {

        //

        let pc = sut.fetchedResultsControllerPostCoreData

        XCTAssertNotNil(pc, "PersistentContainer == nil")

    }


    func testSaveFolder() throws {

        // given

        sut.appendFolder(name: "TestPosts")


        // when

        let folder = sut.getFolderByName(nameFolder: "TestPosts") as AnyObject

        //then

        XCTAssertNotNil(folder, "папка не сохранилась")


    }



        func testIWantToSaveThePostInCoreData() {

            sut.appendPost(author: "Tom", image: "", likes: "2", text: "", views: "", folderName: "TestFolder") { string in
            }

            
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
