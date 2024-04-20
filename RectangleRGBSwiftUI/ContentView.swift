//
//  ContentView.swift
//  RectangleRGBSwiftUI
//
//  Created by Denis Denisov on 20/4/24.
//

import SwiftUI

struct ContentView: View {
    @State private var redValue = Double.random(in: 0...255)
    @State private var greenValue = Double.random(in: 0...255)
    @State private var blueValue = Double.random(in: 0...255)
    
    var body: some View {
        VStack(spacing: 50) {
            ColorRectangleView(
                redValue: redValue,
                greenValue: greenValue,
                blueValue: blueValue
            )
            
            VStack(spacing: 20) {
                ColorSliderView(colorValue: $redValue, tint: .red)
                ColorSliderView(colorValue: $greenValue, tint: .green)
                ColorSliderView(colorValue: $blueValue, tint: .blue)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

private struct ColorRectangleView: View {
    let redValue: Double
    let greenValue: Double
    let blueValue: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 300, height: 150)
            .foregroundStyle(
                Color(
                    red: redValue / 255,
                    green: greenValue / 255,
                    blue: blueValue / 255
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius:20)
                    .stroke(lineWidth: 4)
            )
    }
}

private struct ColorSliderView: View {
    @Binding var colorValue: Double
    let tint: Color
    
    var body: some View {
        HStack(spacing: 10) {
            Text(lround(colorValue).formatted())
                .frame(width: 40)
            Slider(value: $colorValue, in: 0...255, step: 1)
                .tint(tint)
        }
    }
}
