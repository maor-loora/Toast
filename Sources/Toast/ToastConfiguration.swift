//
//  ToastConfiguration.swift
//  
//
//  Created by Maor Atlas on 24/05/2022.
//

import SwiftUI

public struct ToastConfiguration {
    /// duration- how long will the toast appear from the time is starts entrance transitions, until it starts disapearring.
    /// As we cannot know when animation ends on transition and we cannot know the duration of animation (both are not possible in SwiftUI), do the calcularion yourself.
    /// Default is 3.4 seconds
    /// set nil to keep it sticky (can use dragToDismss)
    private(set) var duration: TimeInterval?
    /// dragToDismiss - dismiss the toast even if duration didn't pass. default is true
    private(set) var dragToDismiss: Bool
    
    /// direction - the direction from where the toast will appear. from bottom or from top. optional adding padding from the bottom of the view. default is .fromBottom(padding: 12)
    private(set) var direction: ToastConfiguration.Direction
    
    /// animationIn, animationOut - animation when sliding in and out, default is easeIn(duration: 0.8) for animationIn, easeOut(duration: 0.8).speed(0.5) for animationOut
    private(set) var animationIn: Animation
    private(set) var animationOut: Animation
    
    /// transition - animationTransition. when nil - it is set according to the direction:.move(edge: .bottom) for botton toast, .move(edge. top) for top toast
    private(set) var transition: AnyTransition?
    
    public init(
        duration: TimeInterval? = 3.4,
        dragToDismiss: Bool = true,
        direction: ToastConfiguration.Direction = .fromBottom(padding: 12),
        animationIn: Animation = Animation.easeIn(duration: 0.8),
        animationOut: Animation = Animation.easeOut(duration: 0.8).speed(0.5),
        transition: AnyTransition? = nil) {
        self.duration = duration
        self.dragToDismiss = dragToDismiss
        self.direction = direction
        self.animationIn = animationIn
        self.animationOut = animationOut
        self.transition = transition
    }
    
    internal var animationTransition: AnyTransition {
        if let transition = transition {
            return transition
        }
        
        switch direction {
        case .fromBottom:
            return .move(edge: .bottom)
        case .fromTop:
            return .move(edge: .top)
        }
    }
    
    /// default bottom toast configuration
    public static var defaultBottomConfiguration: ToastConfiguration {
        ToastConfiguration(direction: .fromBottom(padding: 12))
    }

    /// default top toast configuration
    public static var defaultTopConfiguration: ToastConfiguration {
        ToastConfiguration(direction: .fromTop(padding: 12))
    }
}

extension ToastConfiguration {
    public enum Direction {
        case fromBottom(padding: CGFloat)
        case fromTop(padding: CGFloat)
    }
}
