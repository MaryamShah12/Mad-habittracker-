Habit-Tracker-Flutter 🏃📔⏳

**Introduction**:
The Habit Tracker App is a mobile application built using the Flutter framework. It allows users to track and manage their daily habits, providing features such as habit tracking, goal setting, and progress visualization. Designed to help users build consistency in their routines, the app enables them to monitor their progress toward achieving their goals effectively.

**Functionality**:
**Home Page**: The app's main screen displays a list of habits that users want to track. Each habit tile includes the habit name, time goal, time spent, and options to edit or delete the habit.
**Tracking Habits**: Users can manage their habits by adding new ones through a dialog, editing existing habits, and deleting those that are no longer relevant.
**Progress Tracking**: Users can visualize their progress through real-time updates. While the app currently does not include a timer functionality, it provides the framework for future integration of time tracking.
**User-Friendly Interface**: The app is designed with a responsive interface that ensures usability across different devices. The colors and layout adjust to provide a seamless experience.

**Architecture and Code Structure**:
**main.dart**: The main entry point of the app initializes the Flutter app and sets up the MaterialApp with the HomePage as the initial screen.
**home_page.dart**: This file contains the HomePage class, a StatefulWidget responsible for displaying the list of habit tiles and managing user interactions.
**database_helper.dart**: This file handles data operations using the Hive database, including adding, updating, and deleting habits.
**habit_model.dart**: This file defines the Habit model, which structures the habit data for storage and retrieval.
**habit_tile.dart**: The HabitTile class defines the UI for each habit tile and provides options for editing and deleting habits.

**Key Features and Contributions**:
Implemented a dynamic interface for tracking multiple habits with real-time updates.
Utilized the Hive database for efficient data storage, ensuring cross-platform compatibility.
Established a system to add, edit, and delete habits easily.
Designed the architecture to facilitate easy addition of new habits and features.

**Future Enhancements**:
Implement timer functionality to track the duration of each habit actively.
Develop a settings page for users to customize their tracking preferences.
Incorporate data visualization and historical tracking of habit progress.
Enhance the user interface with themes and additional customization options.

**Conclusion**:
The Habit Tracker App in Flutter is a promising project that lays the foundation for an effective habit-tracking tool. With its current features and well-structured codebase, the app has the potential to help users build and maintain positive habits while offering opportunities for future expansion and improvement.