//
//  NSObject + Ext.swift
//  Image Generator
//
//  Created by Evgeniy Goncharov on 20.05.2023.
//

import Foundation

extension NSObjectProtocol {
    @discardableResult
    func apply(_ closure: (Self) -> () ) -> Self {
        { closure(self) }()
        return self
    }
}
