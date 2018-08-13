//
//  Observable.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 14..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import Foundation
import UIKit

internal class Observable<Value>: NSObject {
    internal var observer: ((Value) -> Void)?
}

internal class KVObservable<Value>: Observable<Value> {
    private let keyPath: String
    private weak var object: AnyObject?
    private var observingContext = NSUUID().uuidString
    
    internal init(keyPath: String, object: AnyObject) {
        self.keyPath = keyPath
        self.object = object
        super.init()
        
        object.addObserver(self, forKeyPath: keyPath, options: [.new], context: &observingContext)
    }
    
    deinit {
        object?.removeObserver(self, forKeyPath: keyPath, context: &observingContext)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard
            context == &observingContext,
            let newValue = change?[NSKeyValueChangeKey.newKey] as? Value
            else {
                return
        }
        
        observer?(newValue)
    }
}

internal class GestureStateObservable: Observable<UIGestureRecognizerState> {
    private weak var gestureRecognizer: UIGestureRecognizer?
    
    internal init(gestureRecognizer: UIGestureRecognizer) {
        self.gestureRecognizer = gestureRecognizer
        super.init()
        
        gestureRecognizer.addTarget(self, action: #selector(self.handleEvent(_:)))
    }
    
    deinit {
        gestureRecognizer?.removeTarget(self, action: #selector(self.handleEvent(_:)))
    }
    
    @objc private func handleEvent(_ recognizer: UIGestureRecognizer) {
        observer?(recognizer.state)
    }
}
