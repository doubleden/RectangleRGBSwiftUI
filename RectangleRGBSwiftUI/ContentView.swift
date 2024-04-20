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
            ColorRectangle(
                redValue: redValue,
                greenValue: greenValue,
                blueValue: blueValue
            )
            
            VStack {
                ColorSlider(tint: .red, colorValue: $redValue)
                ColorSlider(tint: .green, colorValue: $greenValue)
                ColorSlider(tint: .blue, colorValue: $blueValue)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

private struct ColorRectangle: View {
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

private struct ColorSlider: View {
    let tint: Color
    @Binding var colorValue: Double
    
    var body: some View {
        HStack(spacing: 10) {
            Text(lround(colorValue).formatted())
                .frame(width: 40)
            Slider(value: $colorValue, in: 0...255, step: 1)
                .tint(tint)
        }
    }
}
