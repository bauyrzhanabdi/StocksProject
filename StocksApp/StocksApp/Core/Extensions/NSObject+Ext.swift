//
//  NSObject+Ext.swift
//  StocksApp
//
//  Created by Bauyrzhan Abdi on 30.05.2022.
//

import Foundation

extension NSObject {
    static var typeName : String {
        String(describing: self)
    }
}
