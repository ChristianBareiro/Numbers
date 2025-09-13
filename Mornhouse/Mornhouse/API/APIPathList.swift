//
//  APIPathList.swift
//  Mornhouse
//
//  Created by Александр Колесник on 13.09.2025.
//

import Foundation

fileprivate enum APIHost: String {
    
    case numbersAPI = "http://numbersapi.com/"
    case testHostNumberAPI = "http://testnumbersapi.com/"
    
}

enum Server {
    
    case prod, test
    
    var rawValue: String {
        switch self {
        case .prod: ProdServer.main.rawValue
        case .test: TestServer.main.rawValue
        }
    }
    
}

fileprivate enum ProdServer {
    
    case main
    
    var rawValue: String {
        switch self {
        case .main: APIHost.numbersAPI.rawValue
        }
    }

}

fileprivate enum TestServer {
    
    case main
    
    var rawValue: String {
        switch self {
        case .main: APIHost.testHostNumberAPI.rawValue
        }
    }
    
}

enum APIPathList {
    
    case main(Server)
    
    var rawValue: String {
        switch self {
        case .main(let server): server.rawValue
        }
    }
    
}


enum APIRestPath: String {
    
    case number = ""
    case randomNumber = "random/math"
    

}
