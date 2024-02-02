//
//  Service.swift
//  DesafioFractal
//
//  Created by Joan Wilson Oliveira on 26/01/24.
//

import Foundation

final class PunkApiClient: BeerRemoteRepository {
    private let apiURL: String 
    private let session: URLSession
    
    init(apiURL: String, session: URLSession) {
        self.apiURL = apiURL
        self.session = session
    }
    
    func getBeers(page: Int, amount: Int, completion: @escaping (Result<[Beer], Error>) -> Void) {
        guard let url = URL(string: self.apiURL) else {
            return completion(.failure(ErrorClient.invalidBaseURL))
        }
        
        var request = URLRequest(url: url)
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        let task = session.dataTask(with: request) { data, _, error in
            if error != nil {
                completion(.failure(ErrorClient.errorRequest))
            }
            
            if let data = data {
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
