//
//  Event.swift
//  PatKit
//
//  Created by Patrick O'Leary on 9/20/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation

public class Event<T> {
    
    public typealias EventHandler = (T) -> ()
    
    var eventHandlers = [Invocable]()
    
    public func raise(data: T) {
        for handler in self.eventHandlers {
            handler.invoke(data)
        }
    }
    
    public func addHandler<U: AnyObject>(target: U,
                           handler: @escaping (U) -> EventHandler) -> Disposable {
        let wrapper = EventHandlerWrapper(target: target,
                                          handler: handler, event: self)
        eventHandlers.append(wrapper)
        return wrapper
    }
}

protocol Invocable: class {
    func invoke(_ data: Any)
}
