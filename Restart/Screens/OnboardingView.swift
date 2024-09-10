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
                    ZStack {
                        Circle()
                            .stroke(.white.opacity(0.2), lineWidth: 40)
                            .frame(width: 260, height: 260, alignment: .center)
                        Circle()
                            .stroke(.white.opacity(0.2), lineWidth: 80)
                            .frame(width: 260, height: 260, alignment: .center)
                    }
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                }
                Spacer()
                ZStack(alignment: .center) {
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
                            .frame(width: buttonSize)
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
                        .onTapGesture {
                            isOnboardingViewActive = false
                        }
                        Spacer()
                    }
                }
                .frame(height: buttonSize, alignment: .center)
                .padding()
            }
        }
    }
}

#Preview {
    OnboardingView()
}
