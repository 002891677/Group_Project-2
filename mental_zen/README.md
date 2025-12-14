# 🧘‍♀️ Mental Zen – A Mental Wellness Journal App

Mental Zen is a mobile application built with **Flutter** and **Firebase** that helps users:

- Track their **daily mood** in a simple, visual way  
- Write **journal entries** about their thoughts and experiences  
- View **insights and trends** over time  
- Practice short **mindfulness exercises**  
- Receive gentle **wellness reminders**  

This project was developed as part of a **Mobile Application Development** course.

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Architecture](#-architecture)
- [Screens & Flow](#-screens--flow)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
  - [Prerequisites](#prerequisites)
  - [Firebase Setup](#firebase-setup)
  - [Run the App](#run-the-app)
- [Implementation Highlights](#-implementation-highlights)
- [Future Enhancements](#-future-enhancements)
- [Team](#-team)

---

## 🧾 Overview

Mental Zen is designed to be a **calm, private space** for users to reflect on their emotions and daily experiences.

Instead of trying to diagnose or replace professional help, the app focuses on:

- **Self-awareness** – by tracking mood and journaling  
- **Reflection** – through a history of entries  
- **Small habits** – via reminders and mindfulness prompts  

All user data is stored **securely and per-user** in Firebase Firestore.

---

## ✨ Features

### 🔐 Authentication & Privacy
- Email/password signup & login using **Firebase Authentication**
- Auth state listener (`authStateChanges`) controls navigation
- Each user only sees **their own** data

### 😊 Daily Mood Tracking
- Emoji-based mood scale (from 😞 to 🤩)
- One-tap mood selection + “Save mood” button
- Mood entries stored as `MoodEntry` in Firestore with timestamp

### 📓 Journaling
- Rich journal entry screen with multiline text input
- Saves journals as `JournalEntry` with timestamp (and optional mood index)
- Journal history screen listing all entries, newest first
- Ability to view details / full content for a given entry

### 📊 Insights & Analytics
- Uses stored mood data to compute:
  - Recent mood trend
  - Average mood over a period
  - Journaling activity / streaks (depending on implementation)
- Displays insights in a clean, simple UI using cards and/or charts

### 🧠 Mindfulness Resources
- Built-in set of short wellness activities:
  - Breathing exercises
  - Body scan / relaxation prompts
  - Gratitude reflections
  - Positive affirmations
- Simple list → tap to see detailed instructions / affirmations

### ⏰ Wellness Reminders
- Toggle to enable/disable daily reminders
- Time picker to choose reminder time
- Settings stored in Firestore under user’s profile
- Local notifications scheduled using `flutter_local_notifications`

---

## 🛠 Tech Stack

- **Frontend:** Flutter (Dart)
- **Backend:** Firebase
  - Firebase Core
  - Firebase Authentication
  - Cloud Firestore
- **Notifications:** `flutter_local_notifications`
- **State / Logic:**
  - Service layer (`AuthService`, `MoodService`, `JournalService`, `ReminderService`)
  - Dart model classes (`MoodEntry`, `JournalEntry`)
- **Tools:**
  - VS Code / Android Studio
  - Android Emulator / Physical Android device
  - Git & GitHub (feature branches + PRs)

---

## 🏗 Architecture

At a high level:

- **UI Layer**  
  Flutter screens and widgets (e.g., `MoodTrackingScreen`, `JournalEntryScreen`, `InsightsScreen`).

- **Service Layer**  
  Encapsulates Firebase and notification logic:
  - `AuthService` – wraps `FirebaseAuth`
  - `MoodService` – reads/writes `moodEntries` in Firestore
  - `JournalService` – reads/writes `journalEntries` in Firestore
  - `ReminderService` – manages reminder settings + local notifications

- **Data Layer (Firestore)**  
  Firestore structure (per user):

  ```text
  users/{uid}
    moodEntries/{entryId}
      timestamp: string (ISO 8601)
      moodIndex: int
    journalEntries/{entryId}
      timestamp: string (ISO 8601)
      moodIndex: int (optional)
      text: string
    settings/reminder
      enabled: bool
      time: string (e.g. "20:00" or "8:00 PM")
🧭 Screens & Flow

Typical user journey:

Onboarding

App introduction and “Get Started” call to action.

Authentication

Signup with email & password or login if existing user.

Once authenticated, app navigates to Home via authStateChanges.

Home Dashboard

Entry point to:

Daily Mood

Journal Entry

Journal History

Insights

Mindfulness

Reminders

Daily Mood Screen

User selects an emoji that matches their mood and saves it.

Journal Entry & History

Write a new entry → save to Firestore.

View previous entries in a list, tap to see full content.

Insights Screen

Shows key metrics and patterns based on stored data.

Mindfulness Screen

List of exercises → details on tap.

Reminders Screen

Toggle reminders, pick time, and save; schedules local notification.

📂 Project Structure

Key folders (under lib/):

lib/
  main.dart

  core/
    app_theme.dart
    app_routes.dart
    widgets/
      primary_button.dart

  features/
    onboarding/
      onboarding_screen.dart
    auth/
      login_screen.dart
      signup_screen.dart
    home/
      home_screen.dart
    mood/
      mood_tracking_screen.dart
    journal/
      journal_entry_screen.dart
      journal_history_screen.dart
    analytics/
      insights_screen.dart
    mindfulness/
      mindfulness_screen.dart
    reminders/
      reminders_screen.dart

  models/
    mood_entry.dart
    journal_entry.dart

  services/
    auth_service.dart
    mood_service.dart
    journal_service.dart
    reminder_service.dart


This structure keeps the app modular and easier to maintain.

🚀 Getting Started
Prerequisites

Flutter SDK installed (flutter doctor returns no major issues)

Android Studio / VS Code with Flutter & Dart plugins

A configured Android emulator or a physical Android device

A Firebase project (for Auth + Firestore)

Firebase Setup

Go to Firebase Console
 and create a project (e.g., mental_zen).

Add an Android app:

Use your app’s package name (from android/app/src/main/AndroidManifest.xml).

Download the google-services.json file and place it in:

android/app/google-services.json


Enable:

Email/Password Authentication in Firebase Auth

Cloud Firestore in test or production mode (with proper rules)

Add the required Firebase plugins in pubspec.yaml and run:

flutter pub get

Run the App

From the project root:

flutter pub get
flutter run


Choose your target device (emulator or physical device).
Login, create an account, and start using the app.

🔍 Implementation Highlights

AuthGate & Streams

Uses FirebaseAuth.instance.authStateChanges() to reactively show login or home.

Service Layer

UI interacts with small, well-defined service classes instead of directly calling Firebase.

Model Classes

toMap / fromMap help keep Firestore code clean and type-safe.

Notifications

Reminder settings are stored in Firestore and mirrored in local notifications on the device.

🌱 Future Enhancements

Some potential ideas for future versions:

AI-based Sentiment Analysis

Analyze journal text to detect emotional trends.

Richer Analytics & Charts

More detailed visualizations of mood over time.

Offline Support

Cache entries locally and sync when back online.

Multi-language Support

Translate UI and content into multiple languages.

Data Export

Allow users to export or back up their journal entries.

👥 Team

Member 1: Murali Krishna Maddineni – UI/UX, app structure, screens, navigation

Member 2: Sai Kethan Bharadwaj Kanithi – Firebase integration, backend services, notifications

Project for: Mobile Application Development
“Mental health is a journey. Mental Zen aims to make that journey a little easier to track, understand, and support.”
