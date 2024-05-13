//
//  ContentView.swift
//  CardSwiper
//
//  Created by Simon Deutsch on 13.05.24.
//

import SwiftUI

struct SwiperStackView: View {
    @State var offset1 = CGSize.zero
    @State var offset2 = CGSize.zero
    @State var zIndex: Double = 1

    var body: some View {
        ZStack {
            // Q1
            SwiperView(offset: $offset2, swipe: swipe) {
                Text("Question 1")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                    .bold()
            }
            .zIndex(zIndex)
            // Q2
            SwiperView(offset: $offset1, swipe: swipe) {
                Text("Question 2")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
            }
            .id("Q2")
        }
    }

    private func swipe(direction: SwipeDirection) {
        print(direction)
        switchAndReset()
    }

    /// inverts the displayed order and resets the cards to offset zero
    private func switchAndReset() {
        zIndex = zIndex * -1
        if offset1 != .zero {
            offset1 = .zero
        }
        if offset2 != .zero {
            offset2 = .zero
        }
    }
}

#Preview {
    SwiperStackView()
}
