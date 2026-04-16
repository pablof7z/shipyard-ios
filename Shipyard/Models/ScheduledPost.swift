import Foundation

/// Represents a scheduled post to be published on Nostr
struct ScheduledPost: Identifiable {
    let id: UUID
    let content: String
    let scheduledAt: Date
    let targetRelays: [String]
    let createdAt: Date

    init(
        id: UUID = UUID(),
        content: String,
        scheduledAt: Date,
        targetRelays: [String],
        createdAt: Date = Date()
    ) {
        self.id = id
        self.content = content
        self.scheduledAt = scheduledAt
        self.targetRelays = targetRelays
        self.createdAt = createdAt
    }
}

// MARK: - Mock Data

extension ScheduledPost {
    static let mockPosts: [ScheduledPost] = [
        ScheduledPost(
            content: "GM Nostr! ☀️ Starting the day with some protocol development. The future of social media is decentralized!",
            scheduledAt: Date().addingTimeInterval(3600), // 1 hour from now
            targetRelays: ["wss://relay.damus.io", "wss://nos.lol", "wss://relay.nostr.band"]
        ),
        ScheduledPost(
            content: "Just shipped a new feature for Shipyard - now you can schedule posts with precision timing. No more manual posting! 🚀",
            scheduledAt: Date().addingTimeInterval(7200), // 2 hours from now
            targetRelays: ["wss://relay.damus.io", "wss://relay.nostr.band"]
        ),
        ScheduledPost(
            content: "Reminder: The best time to post on Nostr is when your audience is active. Use scheduling to hit those peak hours! 📊",
            scheduledAt: Date().addingTimeInterval(86400), // Tomorrow
            targetRelays: ["wss://relay.damus.io", "wss://nos.lol"]
        ),
        ScheduledPost(
            content: "Weekend thoughts: Decentralization isn't just about technology, it's about giving people control over their digital lives. #nostr #freedom",
            scheduledAt: Date().addingTimeInterval(172800), // 2 days from now
            targetRelays: ["wss://relay.damus.io", "wss://nos.lol", "wss://relay.nostr.band", "wss://nostr.wine"]
        ),
        ScheduledPost(
            content: "New blog post coming soon: 'Why Nostr Will Change Everything' - stay tuned! 📝",
            scheduledAt: Date().addingTimeInterval(259200), // 3 days from now
            targetRelays: ["wss://relay.damus.io"]
        )
    ]
}
