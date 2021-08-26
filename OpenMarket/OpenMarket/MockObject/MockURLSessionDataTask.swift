//
//  MockURLSessionDataTask.swift
//  OpenMarket
//
//  Created by Charlotte, Hosinging on 2021/08/19.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {

    var resumeDidcall: () -> () = {}
    
    override func resume() {
        resumeDidcall()
    }

}
