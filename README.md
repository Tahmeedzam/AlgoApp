# AlgoApp 🚀 - Your Personal Algorithm Learning Companion

Welcome to **AlgoApp**! 👋

Flutter Version : 3.32.1 stable
This project is a labor of love for anyone looking to conquer the world of algorithms and data structures. Whether you're a student, a coding enthusiast, or preparing for technical interviews, AlgoApp is designed to be your interactive guide, making complex concepts easy to understand.

We've packed it with features to help you visualize, learn, and even chat with an AI expert about various algorithms. No more dry textbooks – let's make learning algorithms fun and engaging!

## ✨ Features You'll Love

* **Interactive Algorithm Explanations:** Dive deep into popular algorithms like Quick Sort, Bubble Sort, Dijkstra's, and many more. We aim to provide clear, concise explanations.

* **AI-Powered Chatbot:** Got a burning question about Big O notation or how a specific algorithm works? Our integrated AI chatbot, powered by the Gemini API, is here to provide instant, algorithm-specific answers! 🤖

* **User Authentication:** Securely log in or register to track your progress and personalize your learning journey (powered by Firebase Authentication).

* **Seamless Data Management:** Your learning progress and preferences are safely stored and managed using Firestore, ensuring a smooth experience across sessions.

* **Clean & Intuitive UI:** Built with Flutter, AlgoApp offers a beautiful, responsive, and easy-to-navigate user interface.

## 🛠️ Technologies Under the Hood

AlgoApp is built on a robust and modern tech stack:

* **Flutter:** The amazing UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.

* **Dart:** The client-optimized language for fast apps on any platform.

* **Gemini API (Google AI):** Powers our intelligent chatbot, providing real-time answers to your algorithm queries.

* **Firebase:**

  * **Firebase Authentication:** For secure user registration and login.

  * **Cloud Firestore:** A flexible, scalable NoSQL cloud database for storing user data and application state.

* **`http` package:** For making network requests to the Gemini API.

* **`flutter_dotenv`:** Securely manages environment variables (like your API keys) outside of your source code.

* **`provider`:** A simple yet powerful state management solution for Flutter.

* **`google_fonts`:** For beautiful and consistent typography.

## 🚀 Getting Started

Ready to get AlgoApp up and running on your local machine? Follow these steps!

### 1. Clone the Repository

First things first, grab the code:

```
git clone https://github.com/Tahmeedzam/AlgoApp.git
cd AlgoApp
```

### 2. Install Dependencies

Once inside the project directory, fetch all the necessary Flutter packages:

```
flutter pub get
```

### 3. Firebase Project Setup (Crucial!)

AlgoApp uses Firebase for authentication and data storage. You'll need to set up your own Firebase project:

1. **Create a Firebase Project:**

   * Go to the [Firebase Console](https://console.firebase.google.com/).

   * Click "Add project" and follow the prompts.

2. **Enable Authentication:**

   * In your Firebase project, navigate to "Build" > "Authentication".

   * Click "Get started" and enable the "Email/Password" provider (and any others you wish to support).

3. **Enable Cloud Firestore:**

   * In your Firebase project, navigate to "Build" > "Firestore Database".

   * Click "Create database" and choose "Start in production mode" (you can adjust security rules later). Select a location close to your users.

4. **Add Firebase to your Flutter App:**

   * **For Android:**

     * In the Firebase Console, add an Android app to your project.

     * Follow the instructions to register your app and download the `google-services.json` file.

     * Place this file in your `android/app/` directory.

   * **For iOS:**

     * In the Firebase Console, add an iOS app to your project.

     * Follow the instructions to register your app and download the `GoogleService-Info.plist` file.

     * Place this file in your `ios/Runner/` directory.

   * **Run FlutterFire CLI (Optional but Recommended):**

     ```
     dart pub global activate flutterfire_cli
     flutterfire configure
     
     ```

     This command helps configure your Firebase project files automatically.

### 4. Gemini API Key Setup

Our AI chatbot needs a key to talk to the Gemini API. We use `flutter_dotenv` for secure management:

1. **Get Your Gemini API Key:**

   * Go to [Google AI Studio](https://aistudio.google.com/app/apikey).

   * Generate a new API key if you don't have one.

   * **Important:** Ensure the "Generative Language API" is enabled for the Google Cloud Project associated with your API key. You can check this in the [Google Cloud Console](https://console.cloud.google.com/apis/library/generativelanguage.googleapis.com).

2. **Create `.env` File:**

   * In the **root directory** of your AlgoApp project (the same level as `pubspec.yaml`), create a new file named `.env`.

   * Add your API key to this file like so:

     ```
     GEMINI_API_KEY=YOUR_ACTUAL_GEMINI_API_KEY_HERE
     
     ```

     **Remember to replace `YOUR_ACTUAL_GEMINI_API_KEY_HERE` with your real key!**

   * *(For production, you'd typically add `.env` to your `.gitignore` file to prevent it from being committed to version control.)*

### 5. Run the App!

With all the setup done, you can now run AlgoApp:

```
flutter run
```

This will launch the app on your connected device or emulator.

## 💡 How to Use

* **Explore Algorithms:** Navigate through the app to find various algorithms.

* **Chat with AI:** Head over to the AI Chat section and start asking questions about algorithms. The AI is specifically trained to help you with these topics!

* **Login/Register:** Create an account to personalize your experience.

## 🤝 Contributing

We'd love for you to contribute to AlgoApp! Whether it's bug fixes, new features, improved explanations, or better visualizations, every contribution helps.

1. Fork the repository.

2. Create your feature branch (`git checkout -b feature/AmazingFeature`).

3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).

4. Push to the branch (`git push origin feature/AmazingFeature`).

5. Open a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](https://www.google.com/search?q=LICENSE) file for details.

Enjoy learning and exploring algorithms with AlgoApp! If you have any questions or feedback, feel free to open an issue or reach out. Happy coding

