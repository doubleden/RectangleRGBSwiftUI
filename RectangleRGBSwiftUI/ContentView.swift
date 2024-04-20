//
//  ContentView.swift
//  RectangleRGBSwiftUI
//
//  Created by Denis Denisov on 20/4/24.
//

import SwiftUI

enum ColorTextField {
    case red, green, blue
}

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
            
            VStack(spacing: 20) {
                ColorSlider(colorValue: $redValue, tint: .red)
                ColorSlider(colorValue: $greenValue, tint: .green)
                ColorSlider(colorValue: $blueValue, tint: .blue)
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
    @FocusState var focus: ColorTextField?
    @Binding var colorValue: Double
    let tint: Color
    
    var body: some View {
        HStack(spacing: 25) {
            Text(lround(colorValue).formatted())
                .frame(width: 40)
            
            Slider(value: $colorValue, in: 0...255, step: 1)
                .tint(tint)
            
            ColorTextField()
        }
    }
}

struct ColorTextField: View {
    var body: some View {
        TextField(
            "",
            value: $colorValue,
            formatter: NumberFormatter()
        )
        .frame(width: 40)
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        .multilineTextAlignment(.center)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke()
                .foregroundStyle(.gray)
        )
    }
}
