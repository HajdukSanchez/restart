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
    private var buttonSize: CGFloat = 80.0
    
    var body: some View {
        ZStack {
            Color.customBlue
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer()
                VStack(spacing: 0) {
                    Text("Share.")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundStyle(Color.white)
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
                ZStack {
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                }
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
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - buttonSize {
                                        // Change the value based on the gesture
                                        // the value will change only when we drag to right direction
                                        // And when the drag is inside the button width
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    if buttonOffset > buttonWidth / 2 {
                                        // If the user stop drag after the half of the button width
                                        buttonOffset = buttonWidth - buttonSize
                                        isOnboardingViewActive = false
                                    } else {
                                        // If the user stop drag before the half of the button width
                                        buttonOffset = 0
                                    }
                                }
                        )
                        Spacer()
                    }
                }
                .frame(width: buttonWidth, height: buttonSize, alignment: .center)
                .padding(.vertical)
            }
        }
    }
}

#Preview {
    OnboardingView()
}
