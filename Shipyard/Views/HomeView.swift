import SwiftUI

struct HomeView: View {
    @Environment(AppState.self) var appState
    @State private var selectedPost: ScheduledPost?
    @State private var showingNewPost = false
    @State private var showingSettings = false

    var body: some View {
        NavigationStack {
            Group {
                if appState.scheduledPosts.isEmpty {
                    emptyStateView
                } else {
                    postListView
                }
            }
            .navigationTitle("Scheduled")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.large)
            #endif
            .toolbar {
                #if os(iOS)
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showingSettings = true
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingNewPost = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                #else
                ToolbarItem {
                    Button {
                        showingSettings = true
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
                ToolbarItem {
                    Button {
                        showingNewPost = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                #endif
            }
            .sheet(item: $selectedPost) { post in
                PostDetailSheet(post: post)
            }
            .sheet(isPresented: $showingNewPost) {
                NewPostView()
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
        }
    }

    private var emptyStateView: some View {
        ContentUnavailableView {
            Label("No Scheduled Posts", systemImage: "calendar.badge.clock")
        } description: {
            Text("Tap the + button to schedule your first post")
        } actions: {
            Button("Create Post") {
                showingNewPost = true
            }
            .buttonStyle(.borderedProminent)
        }
    }

    private var postListView: some View {
        List {
            ForEach(appState.scheduledPosts) { post in
                ScheduledPostRow(post: post)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedPost = post
                    }
            }
            .onDelete(perform: deletePosts)
        }
        .listStyle(.plain)
    }

    private func deletePosts(at offsets: IndexSet) {
        appState.scheduledPosts.remove(atOffsets: offsets)
    }
}

#Preview {
    let appState = AppState()
    appState.isLoggedIn = true
    appState.scheduledPosts = ScheduledPost.mockPosts

    return HomeView()
        .environment(appState)
}
