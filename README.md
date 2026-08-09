# Task Manager 📋

A cross-platform Flutter task management application built during the App Development Internship.

The application allows users to create, view, update, delete, search, filter, and complete tasks while storing all data locally using Hive.

## Features

* Create new tasks
* View all saved tasks
* Edit existing tasks
* Delete tasks with confirmation
* Mark tasks as completed
* Search tasks by title or description
* Filter tasks by:

    * All
    * Pending
    * Completed
* Set a due date for each task
* Local data persistence using Hive
* Light and Dark Mode
* Persistent theme preference
* Responsive UI for different screen sizes
* State management using BLoC/Cubit

## Technologies Used

* Flutter
* Dart
* Hive
* SharedPreferences
* Flutter BLoC / Cubit
* Material 3

## Project Structure

```text
lib/
├── core/
│   └── theme/
│       └── app_theme.dart
│
├── cubit/
│   └── task_cubit.dart
│
├── data/
│   ├── local/
│   │   └── task_adapter.dart
│   └── repositories/
│       └── task_repository.dart
│
├── models/
│   └── task_model.dart
│
├── screens/
│   ├── add_task_screen.dart
│   └── home_screen.dart
│
└── main.dart
```

## Local Storage

The application uses **Hive** as a local NoSQL database.

Each task contains:

* Task ID
* Title
* Description
* Creation date
* Due date
* Completion status

The data remains available after closing and reopening the application.

## CRUD Operations

### Create

Users can create a new task by entering:

* Title
* Description
* Due date

### Read

All saved tasks are displayed on the home screen.

### Update

Users can:

* Edit task information
* Change the due date
* Mark a task as completed or pending

### Delete

Users can delete a task after confirming the deletion.

## Search & Filtering

The application provides a search field that allows users to search by:

* Task title
* Task description

Tasks can also be filtered using:

* All
* Pending
* Completed

## Theme

The application supports:

* Light Mode
* Dark Mode

The selected theme is saved using **SharedPreferences**, so the user's preference remains after restarting the application.

## Responsive Design

The UI adapts to different screen sizes using Flutter's responsive layout tools, allowing the application to work properly on mobile and larger screens.

## How to Run

Clone the repository:

```bash
git clone YOUR_REPOSITORY_URL
```

Navigate to the project:

```bash
cd task_manager
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

## Screenshots

Add screenshots of the following screens to this section:

1. Home Screen - Light Mode
2. Home Screen - Dark Mode
3. Add Task Screen
4. Edit Task Screen
5. Search
6. Pending Tasks
7. Completed Tasks
8. Delete Confirmation

## Internship Task

This project was developed as part of **Task 2: Cross-Platform Utility Application with Encrypted Local Storage** during the App Development Internship.

## Author

**Nora Nagy**

Flutter Developer

