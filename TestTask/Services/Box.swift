//
//  Box.swift
//  TestTask
//
//  Created by Artem Astapov on 23.06.2022.
//

import Foundation


class Box<T> {
    
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
        
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
}
