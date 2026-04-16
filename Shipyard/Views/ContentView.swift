import SwiftUI
import NDKSwiftCore

/// Root view that routes between login and main app based on auth state
struct ContentView: View {
    @Environment(AppState.self) var appState

    var body: some View {
        Group {
            if appState.isLoggedIn {
                HomeView()
            } else {
                LoginView()
            }
        }
        .animation(.easeInOut, value: appState.isLoggedIn)
    }
}

#Preview("Logged Out") {
    ContentView()
        .environment(AppState())
}

#Preview("Logged In") {
    let appState = AppState()
    appState.isLoggedIn = true
    appState.scheduledPosts = ScheduledPost.mockPosts

    return ContentView()
        .environment(appState)
}
