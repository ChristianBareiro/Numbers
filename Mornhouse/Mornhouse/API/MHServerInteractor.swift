//
//  MHServerInteractor.swift
//  Mornhouse
//
//  Created by Александр Колесник on 13.09.2025.
//

import UIKit

final class ServerCommunicator {

    private var requester = MHAsyncRequester()
    
    func cancelAllRequests() { requester.cancelAll() }

    func objectRequest(object: ObjectAPIRequest) async throws -> MHResponse {
        let request = object.current
        return try await sendRequest(request: request.request, method: request.method, parameters: request.parameters, headers: request.headers)
    }
    
    private func sendRequest(request: String, method: HTTPMethod, parameters: [String: Any]? = nil, headers: [String: String]? = nil) async throws -> MHResponse {
        return try await requester.sendRequest(request: request, method: method, parameters: parameters, headers: headers)
    }

    
}


final class MHServerInteractor {
    
    private var communicator = ServerCommunicator()

    func sendRequest(request: ObjectAPIRequest) async throws -> MHResponse { try await communicator.objectRequest(object: request) }
    
}
