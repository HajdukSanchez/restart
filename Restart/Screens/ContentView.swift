//
//  ContentView.swift
//  Restart
//
//  Created by Jozek Andrzej Hajduk Sanchez on 10/09/24.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    var body: some View {
        ZStack {
            if isOnboardingViewActive {
                OnboardingView()
            } else {
                HomeView()
            }
        }
    }
}

#Preview {
    ContentView()
}
