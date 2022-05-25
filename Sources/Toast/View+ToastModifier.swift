//
//  View+ToastModifier.swift
//  
//
//  Created by Maor Atlas on 25/05/2022.
//

import SwiftUI

// MARK: - ToastModifier
extension View {
    public func toast<InnerContent>(
    isPresented: Binding<Bool>,
    configuration: ToastConfiguration = ToastConfiguration.defaultBottomConfiguration,
    @ViewBuilder _ innerContent: @escaping () -> InnerContent
    ) -> some View where InnerContent: View {
        let modifier = ToastModifier(
            isPresented: isPresented,
            toastConfiguration: configuration) {
                innerContent()
            }
        
        return self.modifier(modifier)
    }
    
    public func bottomTextToast(isPresented: Binding<Bool>, text: String) -> some View {
        let configuration = ToastConfiguration.defaultBottomConfiguration
        
        return textToast(isPresented: isPresented, configuration: configuration, text: text)
    }
    
    public func topTextToast(isPresented: Binding<Bool>, text: String) -> some View {
        let configuration = ToastConfiguration.defaultTopConfiguration
        
        return textToast(isPresented: isPresented, configuration: configuration, text: text)
    }
    
    public func textToast(isPresented: Binding<Bool>, configuration: ToastConfiguration, text: String) -> some View {
        let modifier = ToastModifier(isPresented: isPresented,
                                     toastConfiguration: configuration) {
            ToastModifierDefaultInnerTextContentView(text: text)
        }
        
        return self.modifier(modifier)
    }
}

