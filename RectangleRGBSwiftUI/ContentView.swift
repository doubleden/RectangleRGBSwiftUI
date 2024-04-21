//
//  ContentView.swift
//  RectangleRGBSwiftUI
//
//  Created by Denis Denisov on 20/4/24.
//

import SwiftUI

enum FocusTextField: Hashable {
    case red, green, blue
}

struct ContentView: View {
    @FocusState var focusedField: FocusTextField?
    @State private var isPresented = false
    
    @State private var redValue = Double.random(in: 0...255)
    @State private var greenValue = Double.random(in: 0...255)
    @State private var blueValue = Double.random(in: 0...255)
    
    @State private var redTextFieldInput = 0.0
    @State private var greenTextFieldInput = 0.0
    @State private var blueTextFieldInput = 0.0
    
    var body: some View {
        VStack(spacing: 50) {
            ColorRectangleView(
                redValue: redValue,
                greenValue: greenValue,
                blueValue: blueValue
            )
            
            VStack(spacing: 20) {
                ColorSliderView(
                    colorValue: $redValue,
                    colorTextFieldInput: $redTextFieldInput,
                    isPresentet: $isPresented,
                    tint: .red
                )
                    .focused($focusedField, equals: .red)
                
                ColorSliderView(
                    colorValue: $greenValue,
                    colorTextFieldInput: $greenTextFieldInput,
                    isPresentet: $isPresented,
                    tint: .green
                )
                    .focused($focusedField, equals: .green)
                
                ColorSliderView(
                    colorValue: $blueValue,
                    colorTextFieldInput: $blueTextFieldInput,
                    isPresentet: $isPresented,
                    tint: .blue
                )
                    .focused($focusedField, equals: .blue)
            }
            
            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button("Done") {
                    switch focusedField {
                    case .red:
                        checkTextFieldInput(.red)
                        redValue = redTextFieldInput
                    case .green:
                        checkTextFieldInput(.green)
                        greenValue = greenTextFieldInput
                    case .blue:
                        checkTextFieldInput(.blue)
                        blueValue = blueTextFieldInput
                    case nil:
                        break
                    }
                    focusedField = nil
                }
                
            }
        }
        .onAppear {
            redTextFieldInput = redValue
            greenTextFieldInput = greenValue
            blueTextFieldInput = blueValue
        }
    }
    
    private func checkTextFieldInput(_ textField: FocusTextField) {
        
        switch textField {
        case .red:
            guard redTextFieldInput > 0, redTextFieldInput < 255 else {
                isPresented = true
                return
            }
            redValue = redTextFieldInput
        case .green:
            guard greenTextFieldInput > 0, greenTextFieldInput < 255 else {
                isPresented = true
                return
            }
            greenValue = greenTextFieldInput
        case .blue:
            guard blueTextFieldInput > 0, blueTextFieldInput < 255 else {
                isPresented = true
                return
            }
            blueValue = blueTextFieldInput
        }
        focusedField = nil
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
    @Binding var colorTextFieldInput: Double
    @Binding var isPresentet: Bool
    
    let tint: Color

    var body: some View {
        HStack(spacing: 25) {
            Text(lround(colorValue).formatted())
                .frame(width: 40)
            
            Slider(value: $colorValue, in: 0...255, step: 1)
                .tint(tint)
            
            TextField(
                "",
                value: $colorTextFieldInput,
                formatter: makeFormatter()
            )
            .frame(width: 50)
            .padding(
                EdgeInsets(
                    top: 5,
                    leading: 10,
                    bottom: 5,
                    trailing: 10
                )
            )
            .multilineTextAlignment(.center)
            .textFieldStyle(.roundedBorder)
            .keyboardType(.numberPad)
            .onChange(of: colorValue) {
                colorTextFieldInput = colorValue
            }
            .alert("Wrong format", isPresented: $isPresentet, actions: {})
        }
    }
    
    private func makeFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.maximum = 255
        return formatter
    }
}


