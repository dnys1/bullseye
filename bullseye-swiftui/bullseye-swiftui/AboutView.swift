//
//  AboutView.swift
//  bullseye-swiftui
//
//  Created by Dillon Nys on 4/26/20.
//  Copyright © 2020 Dillon Nys. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    let beige = Color(red: 0xff / 0xff, green: 0xd6 / 0xff, blue: 0xb3 / 0xff)
    
    struct HeadingStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
                .foregroundColor(Color.black)
                .padding(.vertical, 20)
        }
    }
    
    struct BodyStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .foregroundColor(Color.black)
                .padding(.horizontal, 60)
                .padding(.bottom, 20)
        }
    }
    
    var body: some View {
        Group {
            VStack {
                Text("🎯 Bullseye 🎯").modifier(HeadingStyle())
                Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider.")
                    .modifier(BodyStyle())
                Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.")
                    .modifier(BodyStyle())
                Text("Enjoy!")
                .modifier(BodyStyle())
            }
            .navigationBarTitle("About Bullseye")
            .background(beige)
        }
        .padding(.horizontal, 20)
        .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
