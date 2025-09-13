//
//  APIRequestObject.swift
//  Mornhouse
//
//  Created by Александр Колесник on 13.09.2025.
//

import UIKit

enum HTTPMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    
}

protocol ObjectRequest {

    var request: String { set get }
    var response: Codable.Type? { set get }
    var parameters: [String: Any] { set get }
    var method: HTTPMethod { set get }
    var headers: [String: String]? { set get }

}

enum ObjectAPIRequest {

    case getObject(ObjectRequest)

    var current: ObjectRequest {
        switch self {
        case .getObject(let req): return req
        }
    }

}

class SuperRequest: ObjectRequest {
    
    var request: String = ""
    var parameters: [String: Any] = [:]
    var method: HTTPMethod = .post
    var headers: [String: String]? = [:]
    var response: Codable.Type? = nil
    
}

private class APIRequestObject: SuperRequest {
    
    init(with params: [String: Any], req: String, httpMethod: HTTPMethod = .post) {
        super.init()
        parameters = params
        method = httpMethod
        request = req
    }
    
}

enum Endpoint {
    
    case number([String: Any])
    case randomNumber([String: Any])
    
    var requestClass: ObjectRequest {
        switch self {
        case .number(let parameters),
            .randomNumber(let parameters):
            APIRequestObject(with: parameters, req: request, httpMethod: httpMethod)
        }
    }
    
    private var request: String { mainPath + restPath }
    
    private var httpMethod: HTTPMethod {
        switch self {
        case .number, .randomNumber: .get
        }
    }
    
    private var mainPath: String {
        let server: Server = .prod
        return switch self {
        case .number, .randomNumber: APIPathList.main(server).rawValue
            
        }
    }
    
    private var restPath: String {
        switch self {
        case .number(let parameters):
            let value = parameters[kValue] as? String ?? "10"
            return APIRestPath.number.rawValue + value
        case .randomNumber: return APIRestPath.randomNumber.rawValue
        }
    }
    
}

final class APIRequest {
    
    private var value: Endpoint!
    
    init(with loginValue: Endpoint) {
        value = loginValue
    }
    
    var mRequest: ObjectRequest { value.requestClass }
    var request: ObjectAPIRequest { .getObject(mRequest) }
    
}
