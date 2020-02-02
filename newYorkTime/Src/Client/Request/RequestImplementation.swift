//
//  RequestImplementation.swift
//  newYorkTime
//
//  Created by javi on 31/01/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation

extension Request {
    
    var urlRequest: URLRequest {
        
        let url: URL! = URL(string: self.endpoint)
        var urlRequest = URLRequest(url: url)
        for header in self.headers {
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        urlRequest.httpMethod = self.method.rawValue
        switch self.method {
        case .get:
            self.addParams(toRequest: &urlRequest)
        case .post:
            self.addBody(toRequest: &urlRequest)
        case .put:
            self.addBody(toRequest: &urlRequest)
        default:
            break
        }
        return urlRequest
    }
    
    var headers: [String: String] {
        
        let localHeaders:[String:String] = ["Content-Type": "application/json; charset=UTF-8"]
        return localHeaders
    }
    
    var parameters: [String: Any]? {
        
        return nil
    }
    
    public func addParams(toRequest: inout URLRequest) {
        
        var components = URLComponents(string: self.endpoint)!
        if let paramsUnwrapped:[String:Any] = self.parameters {
            components.query = query(paramsUnwrapped)
            toRequest.url = components.url
        }
    }
    
    public func addBody(toRequest: inout URLRequest) {
        
       toRequest.httpBody = try? self.paramsAsJSONBody()
    }
    
    public func add(headers:[String:String], toRequest: inout URLRequest) {
        
        for header in headers {
            toRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
    }
    
    private func paramsAsJSONBody() throws -> Data? {
        
        if let paramsUnwrapped:[String:Any] = self.parameters {
            return try JSONSerialization.data(withJSONObject: paramsUnwrapped)
        }
        return nil
    }
    
    private func escape(_ string: String) -> String {
        
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
    }
    
    private func query(_ parameters: [String: Any]) -> String {
        
        var components: [(String, String)] = []
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
    
    private func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        
        var components: [(String, String)] = []
        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        } else {
            components.append((escape(key), escape("\(value)")))
        }
        return components
    }
}
