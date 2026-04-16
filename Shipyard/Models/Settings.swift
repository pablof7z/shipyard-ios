import Foundation

/// App settings including backend provider configuration
@MainActor
@Observable
class Settings {
    /// The pubkey of the DVM backend provider for scheduling
    var backendProviderPubkey: String = Settings.defaultProviderPubkey

    /// Default DVM provider pubkey (placeholder)
    static let defaultProviderPubkey = "npub1shipyard0000000000000000000000000000000000000000000mock"

    /// Known DVM providers for scheduling
    static let knownProviders: [(name: String, pubkey: String)] = [
        ("Shipyard Official", "npub1shipyard0000000000000000000000000000000000000000000mock"),
        ("DVM Scheduler Alpha", "npub1dvm00000000000000000000000000000000000000000000000alpha"),
        ("Community Scheduler", "npub1community000000000000000000000000000000000000000sched")
    ]
}
