//
//  Network.swift
//  Fetch-Test-Assignment-Apprenticeship
//
//  Created by piro2 on 12/6/24.
//

import Foundation

final class Network: Networkable {
    private let session: URLSession
    
    // MARK: - Init
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Func
    func fetch<T>(by userEndpoint: UserEndpoints, for type: T.Type) async throws -> T where T: Decodable {
        guard let url = URL(string: userEndpoint.endpoint) else {
            throw AppConstants.Errors.Network.invalidUrl
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
            throw AppConstants.Errors.Network.unexpectedStatusCode
        }
        
        guard let results = try? JSONDecoder().decode(T.self, from: data) else {
            throw AppConstants.Errors.Network.decode
        }
        
        return results
    }
}
