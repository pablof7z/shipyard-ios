import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(AppState.self) var appState

    var body: some View {
        NavigationStack {
            Form {
                // Backend Provider Section
                Section {
                    ForEach(Settings.knownProviders, id: \.pubkey) { provider in
                        Button {
                            appState.settings.backendProviderPubkey = provider.pubkey
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(provider.name)
                                        .foregroundStyle(.primary)

                                    Text(truncatedPubkey(provider.pubkey))
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                        .fontDesign(.monospaced)
                                }

                                Spacer()

                                if appState.settings.backendProviderPubkey == provider.pubkey {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.green)
                                }
                            }
                        }
                        .buttonStyle(.plain)
                    }
                } header: {
                    Label("DVM Provider", systemImage: "server.rack")
                } footer: {
                    Text("Select the scheduling service that will publish your posts. This DVM will receive encrypted scheduling requests.")
                }

                // Account Section
                Section {
                    HStack {
                        Text("Logged in as")
                        Spacer()
                        Text(truncatedPubkey(appState.currentUserPubkey ?? "unknown"))
                            .foregroundStyle(.secondary)
                            .fontDesign(.monospaced)
                    }

                    Button(role: .destructive) {
                        Task {
                            await appState.logout()
                        }
                        dismiss()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Log Out")
                            Spacer()
                        }
                    }
                } header: {
                    Label("Account", systemImage: "person.circle")
                }

                // About Section
                Section {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0 (Mock)")
                            .foregroundStyle(.secondary)
                    }

                    Link(destination: URL(string: "https://github.com/nostr-protocol/data-vending-machines/blob/master/kinds/5905.md")!) {
                        HStack {
                            Text("DVM Spec (Kind 5905)")
                            Spacer()
                            Image(systemName: "arrow.up.right.square")
                                .foregroundStyle(.secondary)
                        }
                    }
                } header: {
                    Label("About", systemImage: "info.circle")
                }
            }
            .navigationTitle("Settings")
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
        .frame(minWidth: 400, minHeight: 400)
        #endif
    }

    private func truncatedPubkey(_ pubkey: String) -> String {
        guard pubkey.count > 16 else { return pubkey }
        let prefix = pubkey.prefix(8)
        let suffix = pubkey.suffix(4)
        return "\(prefix)...\(suffix)"
    }
}

#Preview {
    let appState = AppState()
    appState.isLoggedIn = true
    appState.currentUserPubkey = "npub1mockuser00000000000000000000000000000000000000000000test"

    return SettingsView()
        .environment(appState)
}
