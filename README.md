# Little-Fish Technical Assesment

This repository contains four Flutter applications demonstrating different state management approaches and architectural patterns.

## Project Structure

The project is organized into four main directories:

- `question_1/` - Counter App with BLoC Pattern
- `question_2/` - Counter App with Redux
- `question_3/` - Rick and Morty Character Browser
- `question_4/` - Internet Connectivity Plugin

## Question 1: Counter App with BLoC

### Overview
A simple counter application implementing the BLoC (Business Logic Component) pattern for state management.

### Features
- Increment and decrement counter value
- Clean architecture with BLoC pattern implementation
- Immutable state management
- Private variables for encapsulation

### Technical Details
- State Management: Flutter BLoC
- Architecture: Clean Architecture
- Key Components:
  - CounterBloc: Manages counter state and logic
  - CounterState: Immutable state representation
  - CounterEvent: Defined events for state changes

### Running the App
```bash
cd question_1
flutter pub get
flutter run
```

## Question 2: Counter App with Redux

### Overview
A counter application using Redux for state management, demonstrating an alternative approach to state handling.

### Features
- Increment and decrement functionality
- Redux state management implementation
- Immutable state handling
- Action-based state updates

### Technical Details
- State Management: Redux
- Key Components:
  - CounterReducer: Handles state transitions
  - CounterActions: Defined actions for state modification
  - CounterState: Immutable state container

### Running the App
```bash
cd question_2
flutter pub get
flutter run
```

## Question 3: Rick and Morty Character Browser

### Overview
An application that fetches and displays character information from the Rick and Morty API with pagination support. Features a modern architecture using BLoC pattern and supports both light and dark themes.

### Features
- Paginated character list
- Character detail modal
- Image loading and caching
- Repository pattern implementation
- Dependency injection
- Dark and Light theme support
- Auto-generated routes
- Auto-generated models

### Technical Details
- State Management: BLoC Pattern
- Architecture: Repository Pattern
- Navigation: Auto Route
- Model Generation: Build Runner
- Key Dependencies:
  - `flutter_bloc`: For state management
  - `equatable`: For value comparison
  - `auto_route`: For route management
  - `auto_route_generator`: For route code generation
  - `build_runner`: For code generation
- Key Components:
  - CharacterRepository: Handles API interactions
  - CharacterBloc: Manages character data state
  - CharacterState: Immutable states with Equatable
  - ThemeBloc: Manages theme switching
  - Auto-generated routes for navigation
  - Generated model classes for type safety

### Code Generation
To generate the required code for models and routes:
```bash
flutter pub run build_runner build
# or for continuous generation during development
flutter pub run build_runner watch
```

### Theme Implementation
The app implements a theme switching mechanism using BLoC:
```dart
// Example theme switching
BlocBuilder<ThemeBloc, ThemeState>(
  builder: (context, state) {
    return MaterialApp.router(
      theme: state.themeData,
      // ... other configurations
    );
  },
)

### Running the App
```bash
cd question_3
flutter pub get
flutter run
```

## Question 4: Internet Connectivity Plugin

### Overview
A federated Flutter plugin for monitoring internet connectivity across different platforms.

### Features
- Current connectivity status check
- Real-time connectivity status updates
- Cross-platform support
- Event stream implementation

### Technical Details
- Plugin Type: Federated Flutter Plugin
- Platforms Supported:
  - Android
  - iOS
- Key Components:
  - Connectivity checker
  - Status stream handler
  - Platform-specific implementations

### Usage
```dart
// Check current connectivity
bool hasInternet = await ConnectivityPlugin.checkConnectivity();

// Listen to connectivity changes
ConnectivityPlugin.connectivityStream.listen((bool isConnected) {
  print('Internet connection available: $isConnected');
});
```

### Installation
```yaml
dependencies:
  connectivity_plugin:
    path: question_4/
```

## Development Setup

1. Ensure you have Flutter installed and set up properly
2. Clone the repository
3. Navigate to the specific question directory
4. Run `flutter pub get` to install dependencies
5. Run `flutter run` to start the application

## Architecture Decisions

- **Question 1 & 2**: Demonstrate different state management approaches while maintaining clean architecture principles
- **Question 3**: Implements repository pattern and dependency inversion for better testability and maintenance
- **Question 4**: Uses federated plugin approach for better platform-specific code organization

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details
