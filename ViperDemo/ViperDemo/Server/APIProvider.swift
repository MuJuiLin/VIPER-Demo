//
//  CTApiProvider.swift
//  CookpadTest
//
//  Created by MuRay Lin on 2018/9/11.
//  Copyright © 2018年 None. All rights reserved.
//

import UIKit

protocol APIProviderProtocol {
    typealias providerCompleteClosure = ( _ result: [String: Any]?, _ response: URLResponse?, _ error: Error?) -> Void

    // Function
    func postLogin(withEmail email: String, password: String, callback: @escaping providerCompleteClosure)
}

enum RESTfulApi: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class APIProvider: APIProviderProtocol {
    var currentDomain: String

    init(withDomain domainString: String) {
        currentDomain = domainString
    }
        
    func dataTask(withPath path: String, method: RESTfulApi, parameters: [String: Any]?, headerValues: [String: String]?, callback: @escaping providerCompleteClosure) {
        
        guard let urlString = URL(string: currentDomain + path) else {
            fatalError("Error url")
        }
        
        var request = URLRequest(url: urlString)
        request.httpMethod = method.rawValue
        
        if let headers = headerValues {
            for header in headers {
                request.setValue(header.value, forHTTPHeaderField: header.key)
            }
        }

        request.httpBody = jsonToData(parameters)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                guard error == nil else {
                    return callback(nil, response, error)
                }
                guard let responseDict = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] else {
                    return callback(nil, response, error)
                }
                return callback(responseDict, response, error)
            } catch let parseError as NSError {
                return callback(nil, response, parseError)
            }
        }.resume()
    }
    
    // MARK: - POST
    func postLogin(withEmail email: String, password: String, callback: @escaping providerCompleteClosure) {
        let params = [
            "email": email,
            "password": password
        ]
        dataTask(withPath: "login", method: .post, parameters: params, headerValues: nil, callback: callback)
    }
}

extension APIProvider {
    private func jsonToData(_ jsonDict: [String: Any]?) -> Data? {
        guard let jsonDict = jsonDict else { return nil }
        if !JSONSerialization.isValidJSONObject(jsonDict) {
            return nil
        }
        let data = try? JSONSerialization.data(withJSONObject: jsonDict, options: [])
        return data
    }
}
