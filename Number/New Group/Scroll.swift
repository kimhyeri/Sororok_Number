//
//  Scroll.swift
//  Number
//
//  Created by hyerikim on 2018. 8. 14..
//  Copyright © 2018년 nexters.number. All rights reserved.
//

import Foundation
import UIKit

internal protocol Scrollable: class {
    var contentOffset: CGPoint { get }
    var contentInset: UIEdgeInsets { get set }
    var scrollIndicatorInsets: UIEdgeInsets { get set }
    var contentSize: CGSize { get }
    var frame: CGRect { get }
    var contentSizeObservable: Observable<CGSize> { get }
    var contentOffsetObservable: Observable<CGPoint> { get }
    var panGestureStateObservable: Observable<UIGestureRecognizerState> { get }
    func updateContentOffset(_ contentOffset: CGPoint, animated: Bool)
}

// MARK: - UIScrollView + Scrollable
extension UIScrollView: Scrollable {
    var contentSizeObservable: Observable<CGSize> {
        return KVObservable<CGSize>(keyPath: #keyPath(UIScrollView.contentSize), object: self)
    }
    
    var contentOffsetObservable: Observable<CGPoint> {
        return KVObservable<CGPoint>(keyPath: #keyPath(UIScrollView.contentOffset), object: self)
    }
    
    var panGestureStateObservable: Observable<UIGestureRecognizerState> {
        return GestureStateObservable(gestureRecognizer: panGestureRecognizer)
    }
    
    func updateContentOffset(_ contentOffset: CGPoint, animated: Bool) {
        // Stops native deceleration.
        setContentOffset(self.contentOffset, animated: false)
        
        let animate = {
            self.contentOffset = contentOffset
        }
        
        guard animated else {
            animate()
            return
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: [], animations: {
            animate()
        }, completion: nil)
    }
}

//MARK: State
public struct State {
    internal let offset: CGFloat
    internal let isExpandedStateAvailable: Bool
    internal let configuration: Configuration
    
    internal init(offset: CGFloat, isExpandedStateAvailable: Bool, configuration: Configuration) {
        self.offset = offset
        self.isExpandedStateAvailable = isExpandedStateAvailable
        self.configuration = configuration
    }
}

public struct Configuration {
    let compactStateHeight: CGFloat
    let normalStateHeight: CGFloat
    let expandedStateHeight: CGFloat
}

internal struct StateReducerParameters {
    let scrollable: Scrollable
    let configuration: Configuration
    let previousContentOffset: CGPoint
    let contentOffset: CGPoint
    let state: State
}

internal typealias StateReducer = (StateReducerParameters) -> State


internal struct ContentOffsetDeltaYTransformerParameters {
    let scrollable: Scrollable
    let configuration: Configuration
    let previousContentOffset: CGPoint
    let contentOffset: CGPoint
    let state: State
    let contentOffsetDeltaY: CGFloat
}

internal typealias ContentOffsetDeltaYTransformer = (ContentOffsetDeltaYTransformerParameters) -> CGFloat

internal func makeDefaultStateReducer(transformers: [ContentOffsetDeltaYTransformer]) -> StateReducer {
    return { (params: StateReducerParameters) -> State in
        var deltaY = params.contentOffset.y - params.previousContentOffset.y
        
        deltaY = transformers.reduce(deltaY) { (deltaY, transformer) -> CGFloat in
            let params = ContentOffsetDeltaYTransformerParameters(
                scrollable: params.scrollable,
                configuration: params.configuration,
                previousContentOffset: params.previousContentOffset,
                contentOffset: params.contentOffset,
                state: params.state,
                contentOffsetDeltaY: deltaY
            )
            return transformer(params)
        }
        
        return params.state.add(offset: deltaY)
    }
}

internal let ignoreTopDeltaYTransformer: ContentOffsetDeltaYTransformer = { params -> CGFloat in
    var deltaY = params.contentOffsetDeltaY
    
    // Minimum contentOffset.y without bounce.
    let start = params.scrollable.contentInset.top
    
    // Apply transform only when contentOffset is below starting point.
    if
        params.previousContentOffset.y < -start ||
            params.contentOffset.y < -start
    {
        // Adjust deltaY to ignore scroll view bounce below minimum contentOffset.y.
        deltaY += min(0, params.previousContentOffset.y + start)
    }
    
    return deltaY
}

internal let ignoreBottomDeltaYTransformer: ContentOffsetDeltaYTransformer = { params -> CGFloat in
    var deltaY = params.contentOffsetDeltaY
    
    // Maximum contentOffset.y without bounce.
    let end = params.scrollable.contentSize.height - params.scrollable.frame.height + params.scrollable.contentInset.bottom
    
    // Apply transform only when contentOffset.y is above ending.
    if params.previousContentOffset.y > end ||
        params.contentOffset.y > end
    {
        // Adjust deltaY to ignore scroll view bounce above maximum contentOffset.y.
        deltaY += max(0, params.previousContentOffset.y - end)
    }
    
    return deltaY
}

internal let cutOutStateRangeDeltaYTransformer: ContentOffsetDeltaYTransformer = { params -> CGFloat in
    var deltaY = params.contentOffsetDeltaY
    
    if deltaY > 0 {
        // Transform when scrolling down.
        // Cut out extra deltaY that will go out of compact state offset after apply.
        deltaY = min(-params.configuration.compactStateHeight, (params.state.offset + deltaY)) - params.state.offset
    } else {
        // Transform when scrolling up.
        // Expanded or normal state height.
        let maxStateHeight = params.state.isExpandedStateAvailable ? params.configuration.expandedStateHeight : params.configuration.normalStateHeight
        // Cut out extra deltaY that will go out of maximum state offset after apply.
        deltaY = max(-maxStateHeight, (params.state.offset + deltaY)) - params.state.offset
    }
    
    return deltaY
}
