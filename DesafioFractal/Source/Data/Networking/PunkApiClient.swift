//
//  Service.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 26/01/24.
//

import Foundation

final class PunkApiClient: BeerRemoteRepository {
    private let apiURL: String = "https://api.punkapi.com/v2/beers?page=1"
    private let session: URLSession = .init(configuration: .default)
    
//    init(apiURL: String, session: URLSession) {
//        self.apiURL = apiURL
//        self.session = session
//    }
    
    func getBeers(page: Int, amount: Int, completion: @escaping (Result<[Beer], Error>) -> Void) {
        
        // Validate URL
        guard let url = URL(string: self.apiURL) else {
            return completion(.failure(ErrorClient.invalidBaseURL))
        }
        
        // Build Request
        var request = URLRequest(url: url)
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        // Send Request
        let task = session.dataTask(with: request) { data, _, error in
            
            if let data = data {
                
                // Decode
                do {
                    let beers = try JSONDecoder().decode([Beer].self, from: data)
                    completion(.success(beers))
                } catch {
                    completion(.failure(error))
                }
                
            }
        }
        
        task.resume()
    }
    
}
