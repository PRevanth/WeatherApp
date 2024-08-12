//
//  Optional+Extension.swift
//  WeatherApp
//
//  Created by Admin on 8/12/24.
//

import Foundation

protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}
