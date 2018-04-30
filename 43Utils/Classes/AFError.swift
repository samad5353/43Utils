//
//  AFError.swift
//  BaseServiceCall
//
//  Created by Abdul Samad on 4/29/18.
//  Copyright © 2018 Abdul Samad. All rights reserved.
//

import Foundation

class AFError: Error {
    
    /**
     EFError code
     */
    var code: String?
    
    /**
     EFError message
     */
    var message: String?
    
    /**
     EFError initialization
     */
    init(code: String?, message: String?) {
        self.code = code
        self.message = message
    }
}

extension Error {
    
    /**
     Error code
     */
    var code: String {
        return (self as? AFError)?.code ?? ""
    }
    
    /**
     Error message
     */
    var message: String {
        return (self as? AFError)?.message ?? localizedDescription
    }
}
