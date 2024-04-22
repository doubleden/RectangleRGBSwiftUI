//
//  ContentView.swift
//  RectangleRGBSwiftUI
//
//  Created by Denis Denisov on 20/4/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var redValue = Double.random(in: 0...255).rounded()
    @State private var greenValue = Double.random(in: 0...255).rounded()
    @State private var blueValue = Double.random(in: 0...255).rounded()
    
    @FocusState private var isPresented: Bool
    
    var body: some View {
        ZStack {
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
                .focused($isPresented)
                
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                       isPresented = false
                    }
                    
                }
        }
        }
        .background(.brown)
        .onTapGesture {
            isPresented = false
        }
    }
}

#Preview {
    ContentView()
}

struct ColorRectangleView: View {
    let redValue: Double
    let greenValue: Double
    let blueValue: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(height: 150)
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

struct ColorSliderView: View {
    @Binding var colorValue: Double
    let tint: Color
    
    @State private var textInput = ""
    @State private var isShowAlert = false
    @State private var oldColorValue = ""
    

    var body: some View {
        HStack(spacing: 25) {
            Text(colorValue.formatted())
                .frame(width: 40)
            
            Slider(value: $colorValue, in: 0...255, step: 1)
                .tint(tint)
                .onChange(of: colorValue) { oldValue, newValue in
                    textInput = newValue.formatted()
                    oldColorValue = oldValue.formatted()
                }
            
            TextFieldView(text: $textInput, action: validateInput)
                .alert("Wrong format", isPresented: $isShowAlert, actions: {}) {
                    Text("Please enter value from 0 to 255")
                }
        }
        .onAppear {
            textInput = colorValue.formatted()
        }
    }
    
    private func validateInput() {
        if let value = Double(textInput), (0...255).contains(value) {
            self.colorValue = value
        } else {
            isShowAlert.toggle()
            colorValue = Double(oldColorValue) ?? 0
            textInput = oldColorValue
        }
    }
}

struct TextFieldView: View {
    @Binding var text: String
    
    let action: () -> Void
        
    var body: some View {
        TextField("0", text: $text) { _ in
            withAnimation {
                action()
            }
        }
        .frame(width: 55, alignment: .trailing)
        .multilineTextAlignment(.trailing)
        .textFieldStyle(.roundedBorder)
        .keyboardType(.numberPad)
    }
}


