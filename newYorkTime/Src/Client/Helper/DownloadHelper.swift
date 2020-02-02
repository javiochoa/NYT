//
//  DownloadHelper.swift
//  newYorkTime
//
//  Created by javi on 31/01/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation

class DownloadHelper: NSObject, Downloader {
    
    var session: URLSession
    
    override init() {
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 60.0
        sessionConfig.timeoutIntervalForResource = 60.0
        self.session = URLSession(configuration: sessionConfig)
    }

    func send<T,E: Codable>(requestData: Request, adapter:RequestAdapter? = nil, onSuccess: @escaping (_ response: Response<T>) -> Void, onError: @escaping ( _ error: ServerError<E> ) -> Void) -> Void {
        var url:URLRequest = requestData.urlRequest
        adapter?.adapt(&url)
        self.session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                onError(ServerError.ErrorUnknown(message: "Error - \(error?.localizedDescription ?? "")"))
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...299:
                        do {
                            let response = try Response<T>(data: data, httpUrlResponse: httpResponse)
                            onSuccess(response)
                        } catch (let error) {
                            print("error: \(error.localizedDescription)")
                            onError(ServerError.ErrorSerialization)
                        }
                    case 400...499:
                        do {
                            onError(ServerError.Error400(message: try ServerErrorObject<E>(data: data, httpUrlResponse: httpResponse)))
                        } catch (_) {
                            onError(ServerError.Error400(message: nil))
                        }
                    case 500...599:
                        do {
                            onError(ServerError.Error500(message: try ServerErrorObject<E>(data: data, httpUrlResponse: httpResponse)))
                        } catch (_) {
                            onError(ServerError.ErrorUnknown(message: "Error \(httpResponse.statusCode)"))
                        }
                    default:
                        onError(ServerError.ErrorUnknown(message:nil))
                    }
                }
            }
            }.resume()
    }
}

extension DownloadHelper: URLSessionTaskDelegate {

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(Foundation.URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }

    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        print()
    }
}
