//
//  ToastModifier.swift
//  
//
//  Created by Maor Atlas on 24/05/2022.
//

import SwiftUI

public struct ToastModifier<ToastContent>: ViewModifier where ToastContent: View {
    @Binding private var isPresented: Bool
    private var configuration: ToastConfiguration
    private var toastContent: () -> ToastContent
    
    @State private var transitionState: TransitionState = .none
    @State private var hidingTimer: Timer?
    private let minDistanceToDismissOnDrag: CGFloat = 20.0
    
    public init(isPresented: Binding<Bool>,
                toastConfiguration: ToastConfiguration = ToastConfiguration.defaultBottomConfiguration,
                @ViewBuilder _ toastContent: @escaping () -> ToastContent) {
        self._isPresented = isPresented
        self.configuration = toastConfiguration
        self.toastContent = toastContent
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            
            VStack {
                if self.transitionState == .show {
                    self.toastContentView
                        .transition(self.configuration.animationTransition)
                }
            }
        }

        .onChange(of: self.isPresented) { newValue in
            self.animateInnerContent()
            if !newValue {
                stopTimer()
            }
        }
    }
    
    @ViewBuilder
    private var toastContentView: some View {
        VStack {
            switch self.configuration.direction {
            case .fromBottom(let padding):
                
                Spacer()
                self.toastContent()
                    .padding(.bottom, padding)
                
            case .fromTop(let padding):
                
                self.toastContent()
                    .padding(.top, padding)
                Spacer()
            }
        }
        .gesture(
            DragGesture(minimumDistance: self.minDistanceToDismissOnDrag)
                .onChanged { gesture in
                    guard self.isPresented else { return }
                    
                    let height = gesture.translation.height
                    if abs(height) > self.minDistanceToDismissOnDrag {
                        handleGesture(isDownDirection: height > 0)
                    }
                }
            )
    }
}

// MARK: - operations
extension ToastModifier {
    private func animateInnerContent() {
        if self.isPresented {
            withAnimation(self.configuration.animationIn) {
                self.transitionState = .show
                startHidingTimerIfNeeded()
            }
        } else {
            withAnimation(self.configuration.animationOut) {
                self.transitionState = .hide
            }
        }
    }
    
    private func startHidingTimerIfNeeded() { //TODO
        guard let duration = self.configuration.duration else {
            return
        }
        
        self.hidingTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false, block: { _ in
            self.isPresented = false
        })
    }
    
    private func stopTimer() {
        self.hidingTimer?.invalidate()
        self.hidingTimer = nil
    }
    
    private func handleGesture(isDownDirection: Bool) {
        guard self.configuration.dragToDismiss else {
            return
        }
        
        switch self.configuration.direction {
        case .fromBottom:
            
            if isDownDirection {
                self.isPresented = false
            }
        case .fromTop:
            if !isDownDirection {
                self.isPresented = false
            }
        }
    }
}


extension ToastModifier {
    private enum TransitionState {
        case none
        case show
        case hide
    }
}
