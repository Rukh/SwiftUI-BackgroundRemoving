//
//  ContentView.swift
//  Test
//
//  Created by Dmitry Gulyagin on 23/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var treshhold: Double = 0.05
    let range = 0 ... 0.2
    
    var body: some View {
        VStack {
            VStack {
                image
                mask
                image.mask(mask)
            }
            .padding()
            .background(Color.green.opacity(0.5))
            Slider(value: $treshhold, in: range) {
                Text("Treshhold")
            } minimumValueLabel: {
                Text(String(format: "%.1f", range.lowerBound))
            } maximumValueLabel: {
                Text(String(format: "%.1f", range.upperBound))
            }
            .foregroundColor(.black)
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(Color.white)
    }
    
    @ViewBuilder
    private var image: some View {
        Image("test")
            .resizable()
            .scaledToFit()
    }
    
    @ViewBuilder
    private var mask: some View {
        ZStack {
            Color(white: 1 - treshhold)
            image
                .saturation(0)
                .blendMode(.darken)
                .layoutPriority(1)
            Color(white: 1 - treshhold)
                .blendMode(.difference)
        }
        .compositingGroup()
        .colorMultiply(Color(
            hue: 0,
            saturation: 0,
            brightness: .infinity // all non zero pixels made white
        ))
        .luminanceToAlpha()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 500, height: 500))
    }
}
