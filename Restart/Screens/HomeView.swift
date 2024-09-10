//
//  HomeView.swift
//  Restart
//
//  Created by Jozek Andrzej Hajduk Sanchez on 10/09/24.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Properties
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Home")
                .font(.largeTitle)
            Button {
                isOnboardingViewActive = true
            } label: {
                Text("Restart")
            }
        }
    }
}

#Preview {
    HomeView()
}
