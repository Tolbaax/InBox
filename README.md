# InBox Application

<div align="center">
  <img src="assets/images/logo.png" alt="InBox Logo" width="200"/>
  <br><br>

[![Flutter Version](https://img.shields.io/badge/Flutter-3.24.5-blue.svg)](https://flutter.dev/)
[![Dart Version](https://img.shields.io/badge/Dart-3.5.4-blue.svg)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Active%20Development-yellow.svg)]()

  <p><b>Feature-rich open-source social media and messaging platform built with Flutter and Firebase</b></p>
</div>

---

## 📋 Overview

**InBox** is an open-source Flutter application that blends social networking and real-time messaging into a smooth, modern user experience. Whether it's posting content, chatting with friends, or following users, InBox provides an engaging and performant platform with Firebase-backed infrastructure.

> ⚠️ **Note**: This project is open-source and under active development. Contributions are welcome!

---

## ✨ Key Features

<table>
  <tr>
    <td>
      <h3>🔐 Authentication</h3>
      <ul>
        <li>Email & password login</li>
        <li>Secure Firebase Authentication</li>
        <li>Profile with picture, name, and status</li>
        <li>Account deletion support</li>
      </ul>
    </td>
    <td>
      <h3>📱 Social Networking</h3>
      <ul>
        <li>Create image, video, or text posts</li>
        <li>Like, comment, and reply to posts</li>
        <li>Follow/unfollow users</li>
        <li>Save posts for later</li>
        <li>User discovery with search</li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>
      <h3>💬 Messaging</h3>
      <ul>
        <li>Real-time chat</li>
        <li>Seen receipts</li>
        <li>Message reactions with emoji picker</li>
        <li>Threaded replies</li>
        <li>Delete for self or all</li>
        <li>Online/offline indicators</li>
      </ul>
    </td>
    <td>
      <h3>🔔 Notifications & UX</h3>
      <ul>
        <li>Push notifications via FCM</li>
        <li>Auto-scroll to new messages</li>
        <li>Profile and media caching</li>
        <li>Lottie & Rive animations</li>
        <li>Optimized initial loading</li>
        <li>Image cropper</li>
      </ul>
    </td>
  </tr>
</table>

---

## 🧠 Tech Stack

<div align="center">
  <table>
    <tr>
      <td align="center"><img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/flutter/flutter-original.svg" width="40"/><br>Flutter</td>
      <td align="center"><img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/firebase/firebase-plain.svg" width="40"/><br>Firebase</td>
      <td align="center"><img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/dart/dart-original.svg" width="40"/><br>Dart</td>
    </tr>
  </table>
</div>

- **Frontend**: Flutter SDK (v3.24.5)
- **State Management**: BLoC pattern (Cubit)
- **Backend Services**: Firebase
  - Authentication, Firestore, Cloud Storage, Messaging, Crashlytics
  - Firestore batch writes for optimized performance
- **Notifications**: Firebase Cloud Messaging (FCM)
- **Animations**: Lottie & Rive
- **Storage**: Local caching using native Flutter solutions

---

## 🧪 Upcoming Features

- [ ] Notifications for likes, comments, follows
- [ ] Audio/video calling (1-on-1 & group)
- [ ] Group chat support
- [ ] Share posts inside chat
- [x] Profile sharing (internal & external)
- [x] Media dimension control
- [ ] Dark mode
- [ ] Infinite scrolling for feed
- [ ] Custom gallery grid view
- [x] Post sharing functionality
- [ ] Comment management: like/reply/delete
- [ ] GIF, music, location in posts
- [ ] 24-hour disappearing stories
- [ ] Typing indicators in chat
- [ ] Deep linking support
- [ ] Web platform support
- [ ] Codebase cleanup & optimization

---

## 🏗️ Architecture

The application implements a clean architecture pattern with clear separation of concerns:

<div align="center">
  <img src="https://raw.githubusercontent.com/ResoCoder/flutter-tdd-clean-architecture-course/master/architecture-proposal.png" alt="Clean Architecture" width="500"/>
</div>

### Layers

- **Presentation Layer**: User interfaces and state management
  - Screens, widgets, and Cubit/BLoC controllers
  - Responsive layouts and UI animations

- **Domain Layer**: Business logic and use cases
  - Entities, use cases, and repository interfaces
  - Decouples UI from data sources

- **Data Layer**: Firebase-backed data operations
  - Firestore, Auth, Storage, Messaging integrations
  - Repository implementations, DTOs, and data mappers

- **Core**: Cross-cutting concerns and shared utilities
  - Constants, error handlers, extensions, logging, helpers
  - Dependency injection setup

- **Configuration**: Application-wide settings
  - Routing (GoRouter), theming, localization, Firebase init
  - Environment configs and app-level bootstrap

---

## 📊 Project Status

<table>
  <tr>
    <td><b>Current Phase:</b></td>
    <td>Alpha Development</td>
  </tr>
  <tr>
    <td><b>Stability:</b></td>
    <td>Experimental</td>
  </tr>
  <tr>
    <td><b>Availability:</b></td>
    <td>Open Source (Public Repository)</td>
  </tr>
</table>

This application is currently in active development. Contributions are welcome as we work toward a stable, production-ready release.

---

## 📄 License

This project, **InBox**, is open source and available under the [MIT License](LICENSE).

Feel free to use, modify, and share it in compliance with the license terms.

---

<div align="center">
  <p>Built with ❤️ by the <strong>InBox</strong> Team</p>
</div>