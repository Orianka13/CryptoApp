//
//  NetworkManager.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 22.12.2021.
//

import Foundation

protocol INetworkManager {
   
    func loadData<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void)
    
}

final class NetworkManager: INetworkManager {
    
    private enum Literal {
        static let apiKey = "1438444b-c2f3-4d34-97cd-b0becbe7bcf9" //coincap.io
    }
    
    private let session: URLSession

    
    init(configuration: URLSessionConfiguration? = nil) {
        if let configuration = configuration {
            self.session = URLSession(configuration: configuration)
        }
        else {
            self.session = URLSession(configuration: URLSessionConfiguration.default)
        }
    }

    func loadData<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: "https://api.coincap.io/v2/assets?apikey=\(Literal.apiKey)") else { return }

        let request = URLRequest(url: url)
        self.session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    //print("[NETWORK] \(response)")
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

}
