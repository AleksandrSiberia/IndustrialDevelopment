//
//  ManagerDataModelDataTests.swift
//  NovigationTests
//
//  Created by Александр Хмыров on 19.12.2022.
//

import XCTest




final class ManagerDataModelDataTests: XCTestCase {

    var cut: URLSession!
    var networkMonitor = NetworkMonitor.shared



    override func setUpWithError() throws {
        try super.setUpWithError()
        self.cut = URLSession(configuration: .default)

    }


    override func tearDownWithError() throws {

        self.cut = nil
        try super.tearDownWithError()
    }



    func  testCheckingStatusCode() throws {


       try XCTSkipUnless(
            networkMonitor.isReachable,
            "Network connectivity needed for this test."
        )


        // given

        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/")

        let promise = expectation(description: "Status code: 200")



        // when

        let dataTask = cut.dataTask(with: url!) { _, response, error in


            // then

            if let error {

                XCTFail("Error " + error.localizedDescription)
                return
            }

            else if let response = (response as? HTTPURLResponse)?.statusCode {

                if response == 200 {
                    promise.fulfill()
                }
                else {
                    XCTFail("Error status code != 200")
                }
            }
        }

        dataTask.resume()

        wait(for: [promise], timeout: 5)

    }




    func testApiCallCompletes() throws{

        try XCTSkipUnless(

            networkMonitor.isReachable,
            "Network connectivity needed for this test."
        )



        // given

        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/")

        let expectation = expectation(description: "Completion invoked")

        var errorLocalized: String?

        var statusCode: Int?


        
        // when

        let dataTask = cut.dataTask(with: url!) { _, responder, error in

            errorLocalized = error?.localizedDescription

            statusCode = (responder as? HTTPURLResponse)?.statusCode
            expectation.fulfill()
        }

        dataTask.resume()
        wait(for: [expectation], timeout: 5)



        // then

        XCTAssertNil(errorLocalized, "ошибка при загрузке данных")
        XCTAssertEqual(statusCode, 200, "статус код")

    }
}
