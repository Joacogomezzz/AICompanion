import SwiftUI

@main
struct AICompanionApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            AssistantScreen()
                .environmentObject(appState)
                .preferredColorScheme(.dark)
        }
    }
}
