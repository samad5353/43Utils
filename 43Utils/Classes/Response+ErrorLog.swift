//
//  Response+ErrorLog.swift
//  BaseServiceCall
//
//  Created by Abdul Samad on 4/29/18.
//  Copyright © 2018 Abdul Samad. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

public extension Alamofire.DataRequest {
    
    @discardableResult
    func validateErrors() -> Self {
        return validate { [weak self] (request, response, data) -> Alamofire.Request.ValidationResult in
            
            // get status code from server
            let code = response.statusCode
            
            // check the request url
            let requestURL = String(describing: request?.url?.absoluteString ?? "NO URL")
            
            // check if response is empty
            guard let data = data, let jsonData = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any], let json = jsonData else {
                self?.log(code: code, url: requestURL, message: "Empty response" as AnyObject, isError: false, request: request)
                return .success
            }
            
            var result: Alamofire.Request.ValidationResult = .success
            
            // check if response is html
            if (response.allHeaderFields["Content-Type"] as? String)?.contains("text/html") == true {
                self?.log(code: code, url: requestURL, message: json as AnyObject, isError: true, request: request)
                let error = NSError(domain: "html", code: -999, userInfo: ["html": data, NSLocalizedDescriptionKey: ""])
                result = .failure(error)
            }
            else if let message = (json["error_description"] as? String ?? json["error"] as? String) {
                
                //create the error object
                //                let info = [NSLocalizedDescriptionKey: message]
                //                let error = NSError(domain: domain, code: code, userInfo: info)
                
                let domain = json["code"] as? String ?? "error"
                let error = AFError(code: domain, message: message)
                
                //log error
                self?.log(code: code, url: requestURL, message: json as AnyObject, isError: true, request: request)
                //return failure
                result = .failure(error)
            }
            else {
                self?.log(code: code, url: requestURL, message: json as AnyObject, isError: false, request: request)
                result = .success
            }
            
            return result
            }
            // validate for request errors
            .validate()
            
            // log request
            .debug()
    }
    
    private func log(code: Int, url: String, message: AnyObject, isError: Bool, request: URLRequest?) {
        
        if isError {
            Log.error("FAILED")
        }
        Log.info("Status Code >> \(code) \n URL >> \(url) \n Request >> \(String(describing: request?.allHTTPHeaderFields)) \n Response >> \(message)")
    }
}
