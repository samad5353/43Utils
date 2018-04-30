//
//  Request+Log.swift
//  
//
//  Created by Abdul Samad on 4/29/18.
//

import Foundation
import Alamofire
import SwiftyBeaver

typealias Log = SwiftyBeaver

public extension Alamofire.Request {
    
    /// Prints the log for the request
    @discardableResult
    func debug() -> Self {
        Log.info(self.debugDescription)
        return self
    }
}
