
import SwiftUI

struct FavoritesView: View {

    @Environment(CourseStore.self) private var store

    var body: some View {

        List {

            if store.favoriteCourses.isEmpty {
                ContentUnavailableView(
                    "No Favourites",
                    systemImage: "heart",
                    description: Text("Add courses to your favourites to see them here.")
                )
            } else {
                ForEach(store.favoriteCourses) { course in

                    NavigationLink(value: course) {
                        CourseCardView(
                            course: course,
                            isFavorite: Binding(
                                get: {
                                    store.isFavorite(course)
                                },
                                set: {
                                    store.setFavorite($0, for: course)
                                }
                            )
                        )
                    }
                }
            }
        }
        .navigationTitle("My Favourites")
        .navigationDestination(for: Course.self) { course in
            CourseDetailView(course: course)
        }
    }
}

#Preview {
    NavigationStack {
        FavoritesView()
            .environment(CourseStore())
    }
}
