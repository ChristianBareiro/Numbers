//
//  BaseViewModel.swift
//  Mornhouse
//
//  Created by Александр Колесник on 13.09.2025.
//

import UIKit

class BaseViewModel: NSObject {
    
    private var interactor: MHServerInteractor = MHServerInteractor()
    
    func addLoader() { MHLoader.configure() }
    func removeLoader() { MHLoader.remove() }

    func requestCodable<R: Codable>(request: APIRequest, typeOf: R.Type, data: Data? = nil) async throws -> R? {
        let task = Task { () -> R? in
            let response = try await interactor.sendRequest(request: request.request)
            guard
                let data = response.data,
                let newObject = try? JSONDecoder().decode(typeOf.self, from: data)
            else {
                if let exData = response.data {
                    do {
                        let _ = try JSONDecoder().decode(typeOf.self, from: exData)
                    } catch {
                        Logger.log(error)
                        // Back end developer should be punished for such url response
                        let lastTry = String(data: exData, encoding: .utf8)
                        return lastTry as? R
                    }
                }
                return nil
            }
            return newObject
        }
        return try await task.value
    }
    
    func requestDictionary(request: APIRequest) async throws -> [String: Any] {
        let task = Task { () -> [String: Any] in
            let response = try await interactor.sendRequest(request: request.request)
            guard
                let data = response.data,
                let parsedData = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any]
            else {
                return [:]
            }
            return parsedData
        }
        return try await task.value
    }
    
}
