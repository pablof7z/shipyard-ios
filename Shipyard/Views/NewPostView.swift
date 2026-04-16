import SwiftUI

struct NewPostView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(AppState.self) var appState

    @State private var content = ""
    @State private var scheduledDate = Date().addingTimeInterval(3600) // Default: 1 hour from now
    @State private var selectedRelays: Set<String> = Set(["wss://relay.damus.io", "wss://nos.lol"])

    private let availableRelays = [
        "wss://relay.damus.io",
        "wss://relay.nostr.band",
        "wss://nos.lol",
        "wss://nostr.wine",
        "wss://relay.snort.social"
    ]

    var body: some View {
        NavigationStack {
            Form {
                // Content Section
                Section {
                    TextEditor(text: $content)
                        .frame(minHeight: 120)
                } header: {
                    Label("Content", systemImage: "text.alignleft")
                } footer: {
                    Text("\(content.count) characters")
                }

                // Schedule Section
                Section {
                    DatePicker(
                        "Publish at",
                        selection: $scheduledDate,
                        in: Date()...,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                } header: {
                    Label("Schedule", systemImage: "calendar.badge.clock")
                }

                // Relays Section
                Section {
                    ForEach(availableRelays, id: \.self) { relay in
                        Button {
                            toggleRelay(relay)
                        } label: {
                            HStack {
                                Image(systemName: selectedRelays.contains(relay) ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(selectedRelays.contains(relay) ? .green : .secondary)

                                Text(relay)
                                    .font(.system(.body, design: .monospaced))
                                    .foregroundStyle(.primary)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                } header: {
                    Label("Target Relays", systemImage: "antenna.radiowaves.left.and.right")
                } footer: {
                    Text("\(selectedRelays.count) relays selected")
                }
            }
            .navigationTitle("New Post")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Schedule") {
                        createPost()
                    }
                    .disabled(content.isEmpty || selectedRelays.isEmpty)
                }
            }
        }
        #if os(macOS)
        .frame(minWidth: 450, minHeight: 500)
        #endif
    }

    private func toggleRelay(_ relay: String) {
        if selectedRelays.contains(relay) {
            selectedRelays.remove(relay)
        } else {
            selectedRelays.insert(relay)
        }
    }

    private func createPost() {
        let newPost = ScheduledPost(
            content: content,
            scheduledAt: scheduledDate,
            targetRelays: Array(selectedRelays)
        )
        appState.scheduledPosts.insert(newPost, at: 0)
        dismiss()
    }
}

#Preview {
    NewPostView()
        .environment(AppState())
}
