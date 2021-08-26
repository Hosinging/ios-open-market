//
//  MockURLSession.swift
//  OpenMarket
//
//  Created by Charlotte, Hosinging on 2021/08/19.
//

import Foundation

class MockURLSession: URLSessionProtocol {
    
    var isRequestSuccess: Bool
    init(isRequestSuccess: Bool) {
        self.isRequestSuccess = isRequestSuccess
    }
    var makedDataTask = MockURLSessionDataTask()
    
    func createSampleData() -> Data? {
        guard let sampleJsonURL = Bundle.main.url(forResource: "Items", withExtension: "json") else { return nil }
        let sampleData = try? Data(contentsOf: sampleJsonURL)
        return sampleData
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        guard let url = URL(string: "https://camp-open-market-2.herokuapp.com/items/1") else { fatalError()}
        let request = URLRequest(url: url)
        let successResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "2", headerFields: nil)
        let failureResponse = HTTPURLResponse(url: url, statusCode: 503, httpVersion: "2", headerFields: nil)
        let sampleData = createSampleData()
        if isRequestSuccess {
            makedDataTask.resumeDidcall = { completionHandler(sampleData, successResponse, nil) }
        } else {
            makedDataTask.resumeDidcall = { completionHandler(nil, failureResponse, APIError.emptyData) }
        }
        return makedDataTask
    }
    
}
