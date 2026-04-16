import SwiftUI
import NDKSwiftCore
import NDKSwiftSQLite

@MainActor
@Observable
class AppState {
    // MARK: - Connection State
    var isConnected = false
    var ndk: NDK?

    // MARK: - Auth State
    var isLoggedIn = false
    var currentUserPubkey: String?

    // MARK: - App Data
    var scheduledPosts: [ScheduledPost] = []
    var settings = Settings()

    private let defaultRelays: [RelayURL] = [
        "wss://relay.damus.io",
        "wss://relay.nostr.band",
        "wss://nos.lol"
    ]

    // MARK: - NDK Connection

    func connect() async {
        do {
            // Initialize NDK with SQLite cache for offline-first support
            let cache = try await NDKSQLiteCache()
            let ndk = NDK(
                relayURLs: defaultRelays,
                cache: cache
            )

            await ndk.connect()

            // Wait for at least one relay connection
            let connectedCount = await ndk.waitForRelayConnections(minimumRelays: 1, timeout: 10)

            self.ndk = ndk
            self.isConnected = connectedCount > 0
        } catch {
            print("Failed to connect to Nostr: \(error)")
        }
    }

    func disconnect() async {
        await ndk?.disconnect()
        ndk = nil
        isConnected = false
    }

    // MARK: - Mock Auth

    func mockLogin() async {
        // Simulate connecting to relays
        await connect()

        // Mock user authentication
        currentUserPubkey = "npub1mockuser00000000000000000000000000000000000000000000test"
        isLoggedIn = true

        // Load mock scheduled posts
        scheduledPosts = ScheduledPost.mockPosts
    }

    func logout() async {
        isLoggedIn = false
        currentUserPubkey = nil
        scheduledPosts = []
        await disconnect()
    }
}
