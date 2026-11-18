
# Lab 8A - Component Tree

CourseExplorerApp
│
└── HomeView
    │
    ├── NavigationStack
    │
    ├── ScrollView
    │   │
    │   └── VStack
    │       │
    │       ├── WelcomeSection
    │       │   └── ZStack
    │       │
    │       ├── CategorySection
    │       │   ├── SectionHeaderView
    │       │   └── CategoryChipView
    │       │
    │       └── CoursesSection
    │           ├── SectionHeaderView
    │           ├── CourseCardView
    │           └── EmptyStateView
    │
    ├── CourseListView
    │   └── List
    │       └── CourseDetailView
    │
    └── CourseDetailView
        ├── ScrollView
        ├── VStack
        ├── ZStack
        └── Course Information
