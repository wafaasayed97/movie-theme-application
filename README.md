# 🎬 Movie Theming App

A Flutter mobile application that displays popular movies from The Movie Database (TMDB) API with support for light and dark themes.

## ✨ Features

### 🎥 Movie List
- Display popular movies from TMDB
- Infinite scroll pagination (loads more movies automatically)
- Movie posters with title, rating, and release date
- Clean card-based UI design
- Pull-to-refresh functionality

### 💾 Smart Caching System
- **24-hour cache validity** - Movies cached for offline access
- **Instant loading** - Cached data loads immediately
- **Offline mode** - Browse movies without internet connection
- **Smart refresh** - Auto-updates after cache expires
- **Manual refresh** - Pull down to force refresh and clear cache
- **Hive database** - Fast and efficient local storage

### 🎭 Movie Details
- Detailed movie information page
- Full movie poster display
- Movie overview/description
- Additional information:
  - Original title
  - Original language
  - Popularity score
  - Vote count
  - Release date

### 🌓 Theme Support
- Light and Dark theme toggle
- Theme preference persistence (saves your choice)
- Smooth theme transitions
- Custom color schemes for both themes

### 📱 Responsive Design
- Optimized for different screen sizes
- Flutter ScreenUtil for responsive UI
- Smooth animations and transitions

### 🔄 Pagination
- Automatic loading on scroll
- Loading indicators for better UX
- Handles multiple pages seamlessly
- Error handling with retry option

### 🌐 Network Features
- Robust error handling
- Internet connectivity check
- Loading states
- Retry functionality on failure
- Offline support with cached data

## 🏗️ Architecture

### Clean Architecture with BLoC Pattern
```
lib/
├── core/
│   ├── app_cubit/          # Global app state (theme)
│   ├── cache/              # Local storage
│   │   ├── hive/           # Hive caching (movies)
│   │   ├── preferences/    # Shared preferences
│   │   └── secure/         # Secure storage
│   ├── constants/          # App constants
│   ├── di/                 # Dependency injection
│   ├── error/              # Error handling
│   ├── extensions/         # Dart extensions
│   ├── network/            # Network layer
│   ├── routes/             # Navigation
│   └── theme/              # Theme configuration
├── features/
│   ├── movies/
│   │   ├── data/
│   │   │   ├── data_source/    # API calls + caching
│   │   │   ├── models/         # Data models
│   │   │   └── repo/           # Repository
│   │   └── presentation/
│   │       ├── cubit/          # State management
│   │       ├── page/           # UI screens
│   │       └── widgets/        # Reusable widgets
│   └── movie_details/
│       └── presentation/
│           └── page/           # Details screen
└── main.dart
```

## 🛠️ Technologies Used

- **Flutter** - UI framework
- **Dart** - Programming language
- **BLoC/Cubit** - State management
- **Dio** - HTTP client
- **go_router** - Navigation
- **Dartz** - Functional programming (Either type)
- **flutter_screenutil** - Responsive design
- **shared_preferences** - Local storage
- **flutter_secure_storage** - Secure storage
- **Hive** - Fast NoSQL database for caching
- **get_it** - Dependency injection
- **TMDB API** - Movie data source



## 📱 Screens

### Movies List Screen
- Displays popular movies in a scrollable list
- Auto-loads more movies on scroll
- Theme toggle button in app bar
- **Pull down to refresh and clear cache**
- Instant loading from cache (offline mode)

### Movie Details Screen
- Full movie information
- Large poster image
- Complete movie description
- Additional metadata

## 🎨 Theme Configuration

### Light Theme
- Background: `#F5F5F5`
- Cards: `#FFFFFF`
- Text: `#212121`
- Primary: `#4A39D9`

### Dark Theme
- Background: `#121212`
- Cards: `#1E1E1E`
- Text: `#FFFFFF`
- Primary: `#4A39D9`

## 🔄 State Management

### MoviesCubit States
- `MoviesInitial` - Initial state
- `MoviesLoading` - Loading first page
- `MoviesPaginationLoading` - Loading more pages
- `MoviesSuccess` - Data loaded successfully
- `MoviesFailure` - Error occurred

### Caching Flow
1. **First Load**: API → Cache → Display
2. **Cached Load**: Cache → Display (instant)
3. **Expired Cache**: API → Update Cache → Display
4. **Pull to Refresh**: Clear Cache → API → New Cache → Display

### Cache Configuration
- **Storage**: Hive NoSQL database
- **Duration**: 24 hours
- **Strategy**: Cache-first for page 1, Network-first for other pages
- **Size**: Optimized JSON storage

### AppCubit
- Manages global app state
- Theme switching
- Language preferences
- Internet connectivity

## 🐛 Error Handling

- Network error handling
- API error messages
- Retry functionality
- Loading indicators
- Empty state handling
- Cache fallback on network errors
- Offline mode with cached data

## 📈 Future Enhancements

- [ ] Search functionality
- [ ] Movie filters (genre, year, rating)
- [ ] Favorites list with local storage
- [ ] Movie trailers
- [ ] User reviews
- [ ] Enhanced offline mode
- [ ] Share movies
- [ ] Multiple languages support
- [ ] Cache management settings
- [ ] Download movies for offline viewing



---

Made with ❤️ using Flutter