//
//  NetworkManager.swift
//  CryptoApp
//
//  Created by Олеся Егорова on 22.12.2021.
//

import Foundation

protocol INetworkManager {
    
    func loadData<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void)
    func getListUrl() -> String
    func getApiKey() -> String
    func getConvertUrl() -> String
    
}

final class NetworkManager {
    
    private enum Literal {
        static let apiKey = "1438444b-c2f3-4d34-97cd-b0becbe7bcf9"
        static let listUrl = "https://api.coincap.io/v2/assets?apikey=\(Literal.apiKey)"
        static let convertUrl = "https://api.coincap.io/v2/rates?apikey=\(Literal.apiKey)"
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
}

//MARK: INetworkManager
extension NetworkManager: INetworkManager {
    
    func loadData<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        let request = URLRequest(url: url)
        self.session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getListUrl() -> String {
        return Literal.listUrl
    }
    
    func getApiKey() -> String {
        return Literal.apiKey
    }
    
    func getConvertUrl() -> String {
        return Literal.convertUrl
    }
}
