//
//  EventWrapper.swift
//  PatKit
//
//  Created by Patrick O'Leary on 9/20/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation

class EventHandlerWrapper<T: AnyObject, U>: Invocable, Disposable {
    weak var target: T?
    let handler: (T) -> (U) -> ()
    let event: Event<U>
    
    init(target: T?, handler: @escaping (T) -> (U) -> (), event: Event<U>) {
        self.target = target
        self.handler = handler
        self.event = event;
    }
    
    func invoke(_ data: Any) -> () {
        if let t = target {
            handler(t)(data as! U)
        }
    }
    
    func dispose() {
        event.eventHandlers =
            event.eventHandlers.filter { $0 !== self }
    }
}

public protocol Disposable {
    func dispose()
}
