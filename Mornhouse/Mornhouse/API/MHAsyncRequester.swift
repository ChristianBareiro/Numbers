//
//  MHAsyncRequester.swift
//  Mornhouse
//
//  Created by Александр Колесник on 13.09.2025.
//

import UIKit
import RxSwift

class MHAsyncRequester: NSObject {
    
    private var validator: MHResponseValidator = MHResponseValidator()

    func cancelAll() {}
    
    func sendRequest(request: String, method: HTTPMethod, parameters: [String: Any]? = nil, headers: [String: String]? = nil) async throws -> MHResponse {
        // use retrier if needed
        Logger.log("SENDING AT \(Date())")
        Logger.log("REQUEST \(request)")
        Logger.log("METHOD \(method)")
        Logger.log("PARAMETERS \(parameters ?? [:])")
        Logger.log("HEADERS \(headers ?? [:])")
        
        guard
            let encodedQuery = request.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodedQuery)
        else { return validator.mapResponse(response: (Data(), URLResponse())) }
        
        let request = URLRequest(url: url)
        let response: (data: Data, response: URLResponse) = try await URLSession.shared.data(for: request)
        return validator.mapResponse(response: response)
    }
    
}
