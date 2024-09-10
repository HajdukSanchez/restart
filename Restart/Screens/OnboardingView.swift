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
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Onboarding")
                .font(.largeTitle)
            Button {
                isOnboardingViewActive = false
            } label: {
                Text("Start")
            }
        }
    }
}

#Preview {
    OnboardingView()
}
