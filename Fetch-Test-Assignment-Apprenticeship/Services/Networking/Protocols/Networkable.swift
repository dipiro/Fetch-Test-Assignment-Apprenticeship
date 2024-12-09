//
//  Networkable.swift
//  Fetch-Test-Assignment-Apprenticeship
//
//  Created by piro2 on 12/6/24.
//

protocol Networkable {
    func fetch<T>(by userEndpoint: UserEndpoints, for type: T.Type) async throws -> T where T: Decodable
}
