//
//  ToastModifierDefaultInnerTextContentView.swift
//  
//
//  Created by Maor Atlas on 25/05/2022.
//

import SwiftUI

struct ToastModifierDefaultInnerTextContentView: View {
    var text: String
    var textColor: Color = Color.white
    var textFont: Font = Font.system(size: 14.0)
    var backgroundColor: Color = Color.black.opacity(0.8)
    
    var body: some View {
        HStack {
            HStack {
                Text(text)
                    .multilineTextAlignment(.center)
                    .foregroundColor(self.textColor)
                    .font(self.textFont)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .background(
                GeometryReader { geometry in
                    backgroundColor
                        .cornerRadius(geometry.size.height / 2.0)
                }
            )
            .padding(.horizontal, 8)
        }
        .background(Color.clear)
        .frame(idealHeight: 48)
        .frame(maxWidth: .infinity)
    }
}
