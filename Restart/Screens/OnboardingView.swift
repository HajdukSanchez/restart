//
//  OnboardingView.swift
//  Restart
//
//  Created by Jozek Andrzej Hajduk Sanchez on 10/09/24.
//

import SwiftUI

struct OnboardingView: View {
    
    // MARK: - Properties
    
    // If the key dont exist, it will add the value as a default one (otherwise true value is not set)
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0 // Offset value in horizontal direction of button drag
    @State private var isAnimating: Bool = false // Indicator to trigger animation
    @State private var imageOffset: CGSize = .zero // Offset value for animation for image
    @State private var indicatorOpacity: Double = 1.0 // Opactity for the drag indicator we can handle with the image
    @State private var textTile: String = "Share." // Title is going to change when image moves
    private var buttonSize: CGFloat = 80.0
    private let hapticFeedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            Color.customBlue
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer()
                VStack(spacing: 0) {
                    Text(textTile)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundStyle(Color.white)
                        .transition(.opacity)
                    Text("""
                        It's now how much we give but
                        how much love we put into giving.
                        """)
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundStyle(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                ZStack {
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    // Left and Right drag limitation (using abs for both cases)
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        // If image moves, hide the indicator
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            textTile = "Give."
                                        }
                                    }
                                })
                                .onEnded({ _ in
                                    imageOffset = .zero
                                    // If image stop moves, show the indicator
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1
                                        textTile = "Share."
                                    }
                                })
                        )
                        .animation(.easeOut(duration: 1), value: imageOffset)
                }
                .overlay(alignment: .bottom, content: {
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundStyle(Color.white)
                        .offset(y: 20)
                        .opacity(isAnimating ? 1 : 0) // Show first time
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                        .opacity(indicatorOpacity) // Show or hide each time image moves
                })
                Spacer()
                ZStack {
                    Capsule()
                        .fill(.white.opacity(0.2))
                    Capsule()
                        .fill(.white.opacity(0.2))
                        .padding(8)
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .offset(x: 20)
                    HStack {
                        Capsule()
                            .fill(Color.customRed)
                            .frame(width: buttonOffset + buttonSize)
                        Spacer()
                    }
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color.customRed)
                            Circle()
                                .fill(Color.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundStyle(Color.white)
                        .frame(width: buttonSize, height: buttonSize, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - buttonSize - 15 {
                                        // Change the value based on the gesture
                                        // the value will change only when we drag to right direction
                                        // And when the drag is inside the button width
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    // Starts a transaction to create an animation while values are changing
                                    withAnimation(.easeOut(duration: 0.4)) {
                                        if buttonOffset > buttonWidth / 2 {
                                            // If the user stop drag after the half of the button width
                                            buttonOffset = buttonWidth - buttonSize
                                            isOnboardingViewActive = false
                                            // Play sound
                                            playSound(sound: "chimeup", type: "mp3")
                                            hapticFeedback.notificationOccurred(.success)
                                        } else {
                                            // If the user stop drag before the half of the button width
                                            buttonOffset = 0
                                            hapticFeedback.notificationOccurred(.warning)
                                        }
                                    }
                                }
                        )
                        Spacer()
                    }
                }
                .frame(width: buttonWidth, height: buttonSize, alignment: .center)
                .padding(.vertical)
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            }
        }
        .onAppear {
            isAnimating = true
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    OnboardingView()
}
