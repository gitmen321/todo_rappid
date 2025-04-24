✅ TODO App — Flutter Developer Machine Test
Developed for RappiddTechnology

🚀 Overview
This is a Flutter-based TODO application built as part of a machine test for the Flutter Developer position at RareCrew. The app offers a seamless task management experience—allowing users to create, edit, delete, and share tasks—with real-time sync via Firebase Firestore.

The application follows the MVVM architecture, leverages Provider for state management, and is responsive across mobile, tablet, and web platforms.

⏱️ Built in ~3–4 hours, including handling and resolving Firebase Authentication issues with a temporary hardcoded login system for testing.


✨ Features
🔐 User Authentication
Hardcoded login for testing:

user1@gmail.com / pass123

user2@gmail.com / pass123

Password visibility toggle for a user-friendly login experience.

Navigation Drawer showing the logged-in user's name and a Logout button for easy switching.

📋 Task Management
Add new tasks with a title and description.

Edit tasks using a modern gradient dialog.

Delete tasks with real-time UI updates and Firestore sync.

🔁 Real-Time Sync
All operations (add, edit, delete) reflect immediately using Firestore’s real-time capabilities.

📤 Task Sharing
Share tasks by entering the recipient's user ID (e.g., user2).

Generates custom URL: todoapp://task/<taskId>.

🖥️ Responsive UI
Adapts to mobile, tablet, and web with LayoutBuilder.

Dark theme with gradient background.

Beautiful card-based input and task layout with subtle animations.

📂 Navigation Drawer
Displays current user's email (e.g., user1).

Logout functionality built-in.

♾️ Infinite Scroll
Task list uses AnimatedList for smooth, endless scrolling.

🧩 Professional Edit Dialog
"Edit", "Delete", and "Share" buttons with polished UI/UX.

🛠 Tech Stack
Framework: Flutter

Architecture: MVVM

State Management: Provider

Backend: Firebase Firestore

🔌 Packages Used
firebase_core, cloud_firestore

provider

share_plus

uuid

🔧 Setup Instructions
Clone the Repository

bash
Copy
Edit
git clone [your-repo-url]
cd todo_rappid
Install Dependencies

bash
Copy
Edit
flutter pub get
Firebase Setup

Create a Firebase project at Firebase Console.

Register your app and download:

google-services.json (Android)

GoogleService-Info.plist (iOS)

Place them in:

android/app/

ios/Runner/

Configure Firebase CLI:

bash
Copy
Edit
dart pub global activate flutterfire_cli
flutterfire configure --project=<your-firebase-project-id>
Set Firestore Rules (For Testing Only)

javascript
Copy
Edit
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
Run the App

bash
Copy
Edit
flutter run
✅ Testing Guide
1. Login as User 1
Email: user1@gmail.com

Password: pass123

Test the eye icon to toggle password visibility.

Verify login redirects to HomeScreen.

Check username in the navigation drawer.

2. Add a Task
Add a new task (e.g., "Task 1").

Confirm it appears in the list and Firestore.

3. Edit a Task
Update "Task 1" to "Task 1 Updated".

Confirm updates in UI and Firestore.

4. Share the Task
Use the "Share" button.

Share with user ID: user2.

Verify share URL: todoapp://task/<taskId>.

5. Log in as User 2
Email: user2@gmail.com, Password: pass123

Verify shared task appears.

Edit and save the task.

6. Log Back in as User 1
Check updated task shows changes by User 2.

7. Delete Task
Open the edit dialog and delete.

Confirm deletion in UI and Firestore.

8. Test on Multiple Devices
Confirm responsive layout on mobile, tablet, and web.

Test task list and drawer behavior on all platforms.

📁 Project Structure
css
Copy
Edit
lib/
├── models/
│   └── task.dart
├── services/
│   └── firestore_service.dart
├── viewmodels/
│   └── task_view_model.dart
├── views/
│   ├── widgets/
│   │   ├── task_input_field.dart
│   │   └── task_list_item.dart
│   ├── home_screen.dart
│   └── login_screen.dart
└── main.dart


⚠️ Challenges Faced
Faced native setup issues with Firebase Authentication.

Implemented hardcoded login for demonstration.

Ensured Firestore is open for testing only (not production-safe).

🔮 Future Improvements
Integrate Firebase Authentication for secure logins.

Implement deep linking for task sharing (handle todoapp://task/<taskId>).

Add user list UI to simplify task sharing.

Include task deletion animations.

Create a sign-up screen for new users.

👨‍💻 Developer
Developed by [Your Name]
For the Flutter Developer Machine Test at Rappid technologies









