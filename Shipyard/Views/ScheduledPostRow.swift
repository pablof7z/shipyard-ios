import SwiftUI

struct ScheduledPostRow: View {
    let post: ScheduledPost

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Content preview
            Text(post.content)
                .font(.body)
                .lineLimit(2)
                .foregroundStyle(.primary)

            // Metadata row
            HStack(spacing: 12) {
                // Scheduled time
                Label {
                    Text(post.scheduledAt, style: .relative)
                } icon: {
                    Image(systemName: "clock")
                }
                .font(.caption)
                .foregroundStyle(.secondary)

                Spacer()

                // Relay count
                Label {
                    Text("\(post.targetRelays.count) relays")
                } icon: {
                    Image(systemName: "antenna.radiowaves.left.and.right")
                }
                .font(.caption)
                .foregroundStyle(.tertiary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    List {
        ScheduledPostRow(post: ScheduledPost.mockPosts[0])
        ScheduledPostRow(post: ScheduledPost.mockPosts[1])
    }
}
