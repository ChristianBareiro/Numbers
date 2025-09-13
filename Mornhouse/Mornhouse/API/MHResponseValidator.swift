//
//  MHResponseValidator.swift
//  Mornhouse
//
//  Created by Александр Колесник on 13.09.2025.
//

import UIKit

final class MHResponse: NSObject {

    var data: Data? = nil
    var statusCode: Int? = nil
    var error: NetworkError? = nil

}

public enum NetworkError: Error, LocalizedError {
    
    case missingRequiredFields(String)
    case invalidParameters(operation: String, parameters: [Any])
    case badRequest
    case unauthorized
    case paymentRequired
    case forbidden
    case notFound
    case requestEntityTooLarge
    case unprocessableEntity
    case http(httpResponse: HTTPURLResponse, data: Data)
    case invalidResponse(Data)
    case deleteOperationFailed(String)
    case network(URLError)
    case unknown(Error?)

}

class MHResponseValidator: NSObject {
    
    func mapResponse(response: (data: Data, response: URLResponse)) -> MHResponse {
        let mhResponse = MHResponse()
        guard
            let httpResponse = response.response as? HTTPURLResponse
        else {
            mhResponse.data = response.data
            return mhResponse
        }
        mhResponse.statusCode = httpResponse.statusCode
        switch httpResponse.statusCode {
        case 200..<300: mhResponse.data = response.data
        case 400: mhResponse.error = NetworkError.badRequest
        case 401: mhResponse.error = NetworkError.unauthorized
        case 402: mhResponse.error = NetworkError.paymentRequired
        case 403: mhResponse.error = NetworkError.forbidden
        case 404: mhResponse.error = NetworkError.notFound
        case 413: mhResponse.error = NetworkError.requestEntityTooLarge
        case 422: mhResponse.error = NetworkError.unprocessableEntity
        default:
            mhResponse.error = NetworkError.http(httpResponse: httpResponse, data: response.data)
        }
        return mhResponse
    }
    
}
