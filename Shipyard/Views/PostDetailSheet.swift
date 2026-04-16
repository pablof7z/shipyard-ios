import SwiftUI

struct PostDetailSheet: View {
    @Environment(\.dismiss) var dismiss
    let post: ScheduledPost

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Content Preview Section
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Content", systemImage: "text.alignleft")
                            .font(.headline)
                            .foregroundStyle(.secondary)

                        Text(post.content)
                            .font(.body)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    // Publish Time Section
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Scheduled For", systemImage: "calendar.badge.clock")
                            .font(.headline)
                            .foregroundStyle(.secondary)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(post.scheduledAt, style: .date)
                                .font(.title3)
                                .fontWeight(.medium)

                            Text(post.scheduledAt, style: .time)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(.tint)

                            Text(post.scheduledAt, style: .relative)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    // Target Relays Section
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Target Relays", systemImage: "antenna.radiowaves.left.and.right")
                            .font(.headline)
                            .foregroundStyle(.secondary)

                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(post.targetRelays, id: \.self) { relay in
                                HStack {
                                    Image(systemName: "circle.fill")
                                        .font(.system(size: 6))
                                        .foregroundStyle(.green)

                                    Text(relay)
                                        .font(.system(.body, design: .monospaced))
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    // Created timestamp
                    HStack {
                        Text("Created")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(post.createdAt, style: .date)
                        Text("at")
                            .foregroundStyle(.secondary)
                        Text(post.createdAt, style: .time)
                    }
                    .font(.caption)
                    .padding(.top, 8)
                }
                .padding()
            }
            .navigationTitle("Post Details")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        #if os(macOS)
        .frame(minWidth: 400, minHeight: 500)
        #endif
    }
}

#Preview {
    PostDetailSheet(post: ScheduledPost.mockPosts[0])
}
