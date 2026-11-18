
import SwiftUI

struct HomeView: View {

    @Environment(CourseStore.self) private var store

    private func favoriteBinding(for course: Course) -> Binding<Bool> {
        Binding(
            get: {
                store.isFavorite(course)
            },
            set: {
                store.setFavorite($0, for: course)
            }
        )
    }

    var body: some View {

        NavigationStack {

            List(store.courses) { course in

                NavigationLink(value: course) {
                    CourseCardView(
                        course: course,
                        isFavorite: favoriteBinding(for: course)
                    )
                }
                .listRowSeparator(.visible)
            }
            .navigationTitle("Course Explorer")
            .navigationDestination(for: Course.self) { course in
                CourseDetailView(course: course)
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {

                    NavigationLink {
                        SearchView()
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }

                    NavigationLink {
                        FavoritesView()
                    } label: {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(CourseStore())
}
