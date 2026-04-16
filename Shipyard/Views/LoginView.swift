import SwiftUI

struct LoginView: View {
    @Environment(AppState.self) var appState
    @State private var isLoggingIn = false

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            // App Icon & Title
            VStack(spacing: 16) {
                Image(systemName: "ferry.fill")
                    .font(.system(size: 80))
                    .foregroundStyle(.tint)

                Text("Shipyard")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Schedule your Nostr content")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            // Login Section
            VStack(spacing: 16) {
                Text("Sign in to manage your scheduled posts")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                Button {
                    login()
                } label: {
                    HStack {
                        if isLoggingIn {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Image(systemName: "key.fill")
                        }
                        Text(isLoggingIn ? "Connecting..." : "Login with Nostr")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .buttonStyle(.borderedProminent)
                .disabled(isLoggingIn)

                Text("Uses NIP-07 browser extension or nsec")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
            .padding(.horizontal, 32)

            Spacer()
        }
        .padding()
    }

    private func login() {
        isLoggingIn = true

        // Mock login - simulate network delay
        Task {
            try? await Task.sleep(for: .seconds(1.5))
            await appState.mockLogin()
            isLoggingIn = false
        }
    }
}

#Preview {
    LoginView()
        .environment(AppState())
}
