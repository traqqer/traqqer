//
//  API.swift
//  Traqqer
//
//  Created by John Boggs on 3/14/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import Foundation


class API {
    class var instance : API {
        struct Static {
            static let instance = API()
        }
        return Static.instance
    }
    
    class func doSomething() {
        
    }

}