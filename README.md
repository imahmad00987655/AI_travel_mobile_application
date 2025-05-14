# Travel Advisor

A modern Flutter application for managing travel-related services, including ticketing, accommodation, transportation, and embassy appointments.

GitHub Repository: [https://github.com/imahmad00987655/AI_travel_mobile_application](https://github.com/imahmad00987655/AI_travel_mobile_application)

## Features

- **Authentication**
  - Secure login and signup
  - Social login integration (Google, Facebook)
  - Password recovery
  - OTP verification

- **Profile Management**
  - User profile with photo
  - Personal information management
  - Settings and preferences
  - Account security

- **Travel Services**
  - Flight and train ticket booking
  - Hotel and accommodation booking
  - Transportation services
  - Embassy appointment scheduling

- **Document Management**
  - Travel document creation and storage
  - Document expiry tracking
  - Required document checklist
  - File organization

- **User Interface**
  - Modern and responsive design
  - Smooth animations and transitions
  - Dark/Light theme support
  - Intuitive navigation

## Screenshots

[Add screenshots here]

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Dart SDK (latest version)
- Android Studio / VS Code
- Android SDK / iOS development tools

### Installation

1. Clone the repository:
```bash
git clone https://github.com/imahmad00987655/AI_travel_mobile_application.git
```

2. Navigate to the project directory:
```bash
cd travel-advisor
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the application:
```bash
flutter run
```

## Project Structure

```
lib/
├── screens/           # Application screens
├── widgets/           # Reusable widgets
├── models/            # Data models
├── services/          # API and business logic
├── utils/             # Utility functions
├── theme/             # Theme configuration
└── main.dart          # Application entry point
```

## Dependencies

- `flutter_launcher_icons`: For app icon generation
- `provider`: For state management
- `shared_preferences`: For local storage
- `http`: For API calls
- `intl`: For date formatting
- `image_picker`: For image selection
- `google_sign_in`: For Google authentication
- `firebase_auth`: For Firebase authentication
- `firebase_storage`: For file storage
- `firebase_core`: For Firebase initialization

## Configuration

1. Create a Firebase project and add the configuration files:
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`

2. Update the app icon:
   - Place your icon in `assets/icons/app_icon.png`
   - Run `flutter pub run flutter_launcher_icons`

3. Configure social login:
   - Add Google OAuth credentials
   - Add Facebook App ID

## Development

### Code Style

- Follow Flutter's official style guide
- Use meaningful variable and function names
- Add comments for complex logic
- Keep widget trees shallow

### Git Workflow

1. Create a new branch for features:
```bash
git checkout -b feature/your-feature-name
```

2. Commit changes:
```bash
git commit -m "Description of changes"
```

3. Push to remote:
```bash
git push origin feature/your-feature-name
```

4. Create a pull request

## Testing

Run tests:
```bash
flutter test
```

## Building for Release

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- All contributors and maintainers

## Contact

For any queries or suggestions, please contact:
- Email: imahmadkhan1029@gmail.com
- GitHub: [@imahmad00987655](https://github.com/imahmad00987655)
