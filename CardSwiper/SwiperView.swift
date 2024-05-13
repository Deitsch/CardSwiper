//
//  SwiperView.swift
//  CardSwiper
//
//  Created by Simon Deutsch on 13.05.24.
//

import SwiftUI

enum SwipeDirection {
    case left, right
}

private extension SwipeDirection {
    static func fromWidth(width: CGFloat) -> SwipeDirection? {
        switch width {
        case -500...(-150): .left
        case 150...500: .right
        default: .none
        }
    }
}

struct SwiperView<Content>: View where Content: View {
    @State private var color = Color.black

    @Binding var offset: CGSize
    var swipe: (SwipeDirection) -> ()
    @ViewBuilder let content: () -> Content

    private var direction: SwipeDirection? {
        SwipeDirection.fromWidth(width: offset.width)
    }

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 320, height: 420)
                .border(.white, width: 6.0)
                .cornerRadius(4)
            content()
        }
        .offset(x: offset.width, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture (
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    withAnimation {
                        changeColor(direction: direction)
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        swipeCard(direction: direction)
                    } completion: {
                        guard let direction else { return }
                        changeColor(direction: .none)
                        swipe(direction)
                    }
                }
        )
    }

    private func swipeCard(direction: SwipeDirection?) {
        offset = switch direction {
        case .left: CGSize(width: -500, height: 0)
        case .right: CGSize(width: 500, height: 0)
        case .none: .zero
        }
    }

    private func changeColor(direction: SwipeDirection?) {
        color = switch direction {
        case .left: .red
        case .right: .green
        case .none: .black
        }
    }
}

#Preview {
    StatefulPreviewWrapper(CGSize.zero) {
        SwiperView(offset: $0, swipe: { _ in }) {
            Text("Some Question")
                .font(.largeTitle)
                .foregroundColor(.white)
                .bold()
        }
        .onTapGesture {
            print("okok")
        }
    }
}
