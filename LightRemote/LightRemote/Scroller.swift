//
//  Scroller.swift
//  LightRemote
//
//  Created by SAMUEL on 07/12/2023.
//

import SwiftUI

struct Scroller: View {
    @State private var sliderValue: Double = 100
        @State private var currentValue: Int = 100

        var body: some View {
            VStack {
                Text("Brightness: \(currentValue)%")
                    .padding(.bottom ,-20)
                    .font(.system(size: 32))

                Slider(value: $sliderValue, in: 0...100, step: 1)
                    .padding()
                    .onChange(of: sliderValue) {oldValue, newValue in
                        currentValue = Int(newValue)
                        TheBrightness(brightness: currentValue)
                    }
            }.overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1) // Black border around the slider
            )
        }
}

#Preview {
    Scroller()
}
