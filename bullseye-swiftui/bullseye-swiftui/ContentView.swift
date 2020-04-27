//
//  ContentView.swift
//  bullseye-swiftui
//
//  Created by Dillon Nys on 4/26/20.
//  Copyright © 2020 Dillon Nys. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderVal = 50.0
    @State var targetVal = Int.random(in: 1...100)
    @State var totalScore = 0
    @State var roundScore = 0
    
    let midnightBlue = Color(red: 0 / 255, green: 51 / 255, blue: 102 / 255)
    
    struct ShadowStyle: ViewModifier {
        func body(content: Content) -> some View {
            content.shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
            .modifier(ShadowStyle())
            .foregroundColor(Color.white)
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .modifier(ShadowStyle())
                .foregroundColor(Color.yellow)
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    
    struct ButtonLargeStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonSmallStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            // Target row
            HStack {
                Text("Put the bullseye as close as you can to:")
                    .modifier(LabelStyle())
                Text("\(targetVal)")
                .modifier(ValueStyle())
            }
            
            Spacer()
            
            // Slider row
            HStack {
                Text(String(1)).modifier(LabelStyle())
                Slider(value: $sliderVal, in: 1...100).accentColor(Color.green)
                Text(String(100)).modifier(LabelStyle())
            }
            
            Spacer()
            
            // Button row
            Button(action: {
                self.roundScore = self.calculateScore()
                self.totalScore += self.roundScore
                self.alertIsVisible = true
            }) {
                Text("Hit Me!").modifier(ButtonLargeStyle())
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                return Alert(title: Text(alertTitle),
                             message: Text("The slider's value is \(roundedSliderVal).\n" +
                                "You scored \(roundScore) points this round."),
                             dismissButton: .default(Text("Awesome!")) {
                                self.targetVal = Int.random(in: 1...100)
                             })
            }
            .background(Image("Button")).modifier(ShadowStyle())
            
            Spacer()
            
            // Score row
            HStack {
                Button(action: {
                    self.startNewGame()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start over").modifier(ButtonSmallStyle())
                    }
                }
                .background(Image("Button")).modifier(ShadowStyle())
                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text(String(totalScore)).modifier(ValueStyle())
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text(String(roundScore)).modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()) {
                    HStack {
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallStyle())
                    }
                }
                .background(Image("Button")).modifier(ShadowStyle())
            }
            .padding(.bottom, 20)
        }
        .background(Image("Background"))
        .accentColor(midnightBlue)
        .navigationBarTitle("Bullseye")
        .padding(.horizontal, 50)
    }
    
    func startNewGame() {
        self.sliderVal = 50.0
        self.targetVal = Int.random(in: 1...100)
        self.roundScore = 0
        self.totalScore = 0
    }
    
    var roundedSliderVal: Int {
        Int(sliderVal.rounded())
    }
    
    var targetDiff: Int {
        abs(targetVal - roundedSliderVal)
    }
    
    var alertTitle: String {
        if targetDiff == 0 {
            return "Perfect!"
        } else if targetDiff <= 5 {
            return "You almost had it!"
        } else if targetDiff <= 10 {
            return "Not bad."
        } else {
            return "Are you even trying?"
        }
    }
    
    func calculateScore() -> Int {
        let maximumScore = 100
        var bonus: Int = 0
        if targetDiff == 0 {
            bonus = 100
        } else if targetDiff == 1 {
            bonus = 50
        }
        return maximumScore - targetDiff + bonus
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
