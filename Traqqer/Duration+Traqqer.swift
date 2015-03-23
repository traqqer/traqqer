//
//  Duration+Traqqer.swift
//  Traqqer
//
//  Created by Nathan Shayefar on 3/22/15.
//  Copyright (c) 2015 Nathan Shayefar. All rights reserved.
//

import UIKit

public func * (lhs: Int, rhs: Duration) -> Duration {
    return Duration(value: lhs * rhs.value, unit: rhs.unit)
}

public func * (lhs: Duration, rhs: Int) -> Duration {
    return Duration(value: rhs * lhs.value, unit: lhs.unit)
}


