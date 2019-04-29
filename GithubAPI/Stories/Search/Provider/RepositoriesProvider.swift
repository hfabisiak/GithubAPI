//
//  RepositoriesProvider.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import Foundation

class RepositoriesProvider: RepositoriesProviding {
    
    var repositories: [Repository] = []
    
    init(decoder: JSONDecoder = JSONDecoder(),
         session: URLSession = .shared,
         apiRoute: String = "https://api.github.com/search/repositories") {
        self.decoder = decoder
        self.session = session
        self.apiRoute = apiRoute
    }
    
    func search(_ query: String, with completion: @escaping RepositoriesSearchProviderCompletion) {
        guard let stringURL = buildURL(for: query), let url = URL(string: stringURL) else {
            fatalError("Could not build URL for query: \(query)")
        }
        session.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                if let searchResponse = try? self?.decoder.decode(RepositoriesSearchResponse.self, from: data) {
                    self?.repositories.removeAll()
                    self?.repositories.append(contentsOf: searchResponse.repos)
                    completion(.success(searchResponse.repos))
                } else if let errorData = try? self?.decoder.decode(SearchErrorsResponse.self, from: data) {
                    completion(.failure(RepoSearchError.searchError(errorData)))
                }
            }
        }.resume()
    }
    
    // MARK: - Private
    
    private let decoder: JSONDecoder
    private let session: URLSession
    private let apiRoute: String
    
    private func buildURL(for query: String) -> String? {
        var urlComponents = URLComponents(string: apiRoute)
        urlComponents?.queryItems = [
            URLQueryItem(name: "q", value: query)
        ]
        return urlComponents?.string
    }
}
