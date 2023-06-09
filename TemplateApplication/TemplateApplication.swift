//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import CardinalKit
import SwiftUI


@main
struct TemplateApplication: App {
    @UIApplicationDelegateAdaptor(TemplateAppDelegate.self) var appDelegate
    @AppStorage(StorageKeys.onboardingFlowComplete) var completedOnboardingFlow = false
    
    
    var body: some Scene {
        WindowGroup {
            OwnYourDataTabView()
                .sheet(isPresented: !$completedOnboardingFlow) {
                    OnboardingFlow()
                }
                .environmentObject(DocumentManager())
                .testingSetup()
                .cardinalKit(appDelegate)
        }
    }
}
