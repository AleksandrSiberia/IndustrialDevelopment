//
//  ProfileCoordinatorTests.swift
//  NovigationTests
//
//  Created by Александр Хмыров on 20.12.2022.
//

import XCTest




final class ProfileCoordinatorTests: XCTestCase {

    var sut: ProfileCoordinator!



    override func setUpWithError() throws {

        self.sut = ProfileCoordinator(transitionHandler: UINavigationController(), coreDataCoordinator: CoreDataCoordinatorDummy(), profileViewController: ProfileViewControllerDummy())
    }


    override func tearDownWithError() throws {

        self.sut = nil
    }




    func testMustBeOpenedProfileViewController() {

        // given

      

        //when


        let bool = sut.start(user: User("1", userStatus: "1", userImage: UIImage(systemName: "circle")!) )

        //then

        XCTAssertTrue(bool)

    }
}
