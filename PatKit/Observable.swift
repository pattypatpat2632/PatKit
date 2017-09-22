//
//  Observable.swift
//  PatKit
//
//  Created by Patrick O'Leary on 9/20/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation

class Observable<T> {
    
    let didChange = Event<(T, T)>()
    private var value: T
    
    init(_ initialValue: T) {
        value = initialValue
    }
    
    func set(newValue: T) {
        let oldValue = value
        value = newValue
        didChange.raise(data: (oldValue, newValue))
    }
    
    func get() -> T {
        return value
    }
}
