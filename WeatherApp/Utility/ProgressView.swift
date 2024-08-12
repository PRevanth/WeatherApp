//
//  ProgressView.swift
//  WeatherApp
//
//  Created by Admin on 8/12/24.
//

import SwiftUI

struct ProgressView: View {
    @State var isLoading = false
        var body: some View {
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(Color.orange, lineWidth: 5)
                .frame(width: 50, height: 50)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(.linear
                            .repeatForever(autoreverses: false), value: isLoading)
                .onAppear {
                    isLoading = true
                }
        }
}

#Preview {
    ProgressView()
}
