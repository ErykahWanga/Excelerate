
# Excelerate 🚀

**Excelerate** is a modern, production-ready Flutter application designed to streamline the internship discovery, application, and management process. Built with a warm, professional aesthetic and modern UI/UX principles, it provides a seamless experience for students and interns to browse opportunities, apply for programs, and communicate with administrators.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Material 3](https://img.shields.io/badge/Material_3-0061FF?style=for-the-badge&logo=materialdesign&logoColor=white)

---

# Excelerate 🚀

**Excelerate** is a modern, production-ready Flutter application designed to streamline the internship discovery, application, and management process. Built with a warm, professional aesthetic and modern UI/UX principles, it provides a seamless experience for students and interns to browse opportunities, apply for programs, and communicate with administrators.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Material 3](https://img.shields.io/badge/Material_3-0061FF?style=for-the-badge&logo=materialdesign&logoColor=white)

---

## ✨ Features

### 🔐 Authentication
- Clean, validated login screen with secure password visibility toggles.
- Smooth loading states and seamless navigation to the dashboard.

### 🏠 Interactive Dashboard
- Personalized greeting and user profile summary.
- Horizontally scrolling announcement cards with color-coded accents.
- Quick-access featured programs and feedback submission.
- **Modern Animations:** Smooth slide-up and fade-in entrance animations for a premium feel.

### 🔍 Program Discovery
- Real-time search functionality (filter by role or company).
- Dynamic filter chips (Remote, On-site, Hybrid, Part-time).
- Beautifully designed program cards with company branding and metadata tags.

###  Program Details & Application
- Immersive gradient hero headers for each program.
- Detailed breakdown of roles, requirements, and perks.
- Sticky "Apply Now" call-to-action with a success confirmation dialog.

### 💬 Feedback System
- Comprehensive feedback form with strict validation.
- Category selection, email validation, and minimum character requirements.
- Safe navigation with a dedicated "Close" escape hatch.

###  Profile Management
- Clean profile view with user details.
- Secure sign-out functionality that clears the navigation stack.

---

## 🎨 Design System & UI/UX

Excelerate utilizes **Material 3** with a custom, warm, and inviting color palette designed to feel energetic yet professional.

### Color Palette
| Role | Color Name | Hex Code | Usage |
| :--- | :--- | :--- | :--- |
| **Primary** | Vibrant Marigold | `#FFB300` | Main buttons, active states, highlights |
| **Secondary** | Rich Terracotta | `#E65100` | Accents, icons, secondary text, tags |
| **Background** | Warm Cream | `#FFF8E1` | Global app background (replaces stark white) |
| **Surface** | Pure White | `#FFFFFF` | Cards, inputs, app bars |
| **Text** | Deep Charcoal | `#212121` | High-legibility primary text |

### Typography & Styling
- **Font:** Inter (via Google Fonts) for a clean, modern sans-serif look.
- **Components:** 12px rounded corners on all inputs, buttons, and cards.
- **Layout:** Constrained, centered layout (max-width 800px) optimized for Web and Desktop, with soft shadows (`blurRadius: 10`) for depth.
- **Interactions:** Hover effects, smooth transitions, and custom bottom navigation with animated active states.

---

## 📂 Project Structure

The codebase follows a clean, feature-first architecture:

```text
lib/
── main.dart                 # App entry point, theme configuration, routing
├── models/
│   ── program.dart          # Shared data model for internship programs
└── screens/
    ├── login_screen.dart     # Gateway authentication screen
    ├── home_screen.dart      # Main dashboard with bottom navigation
    ├── program_listing_screen.dart # Searchable, filterable program list
    ├── program_details_screen.dart # In-depth program view & application
    └── feedback_screen.dart  # Form submission screen
```

---

## ️ Getting Started

### Prerequisites
- Flutter SDK (3.3.0 or higher)
- Dart SDK
- An IDE (VS Code, Android Studio, etc.)

### Installation & Running

1. **Clone the repository and navigate to the project folder:**
   ```bash
   cd excelerate
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the application:**
   ```bash
   # To run on Chrome (Web)
   flutter run -d chrome

   # To run on Linux Desktop
   flutter run -d linux
   
   # To run on a connected mobile device or emulator
   flutter run
   ```

---

## 📱 App Flow (Happy Path)

To experience the full functionality of the app, follow this testing flow:

1. **Login:** Enter any valid email (e.g., `test@test.com`) and a password with 6+ characters (e.g., `password123`).
2. **Dashboard:** Scroll through announcements and featured programs. Notice the smooth fade-in animation.
3. **Programs Tab:** Tap "Programs" on the bottom nav. Use the search bar or filter chips to find a specific role.
4. **Details:** Tap a program card to view its details. Tap "Apply Now" to simulate an application and see the success dialog.
5. **Feedback:** Tap "Submit Feedback" on the Home dashboard to test the validated form.
6. **Profile:** Tap "Profile" on the bottom nav, then tap "Sign Out" to securely return to the login screen.

---

## 🚀 Future Enhancements

- [ ] **Backend Integration:** Connect to Firebase or a REST API for real authentication and data fetching.
- [ ] **State Management:** Fully implement `Provider` or `Riverpod` for global state management.
- [ ] **User Registration:** Build out the "Sign Up" flow currently marked as coming soon.
- [ ] **Dark Mode:** Implement a dynamic dark theme utilizing the warm color palette.
- [ ] **Notifications:** Add push notifications for new internship alerts.

---

**Built with ❤️ using Flutter.**