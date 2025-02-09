[![Flutter Version](https://img.shields.io/badge/Flutter-v3.24.5-blue)](https://flutter.dev/)
[![Dart Version](https://img.shields.io/badge/Dart-v3.5.4-blue)](https://dart.dev/)

## Overview

**InBox Project** is a feature-rich social media and messaging platform built using Flutter and Firebase. The app enables users to engage with each other through posts, likes, comments, and real-time messaging, offering a seamless and interactive experience.

## Features

### Authentication & User Management
- Secure email/password registration and login
- Firebase Authentication integration
- User profile with display name, profile picture, and status
- Account deletion feature for user privacy

### Social Networking
- Create posts with images, videos, and text updates
- Like, comment, and reply to posts
- Follow/unfollow users
- Save posts for later viewing
- Search and discover other users

### Messaging & Notifications
- Real-time messaging powered by Firebase Cloud Messaging
- Display user online/offline status
- Message reactions and emoji picker
- Reply to specific messages for threaded conversations
- "Seen" status for chat messages
- Auto-scroll on new messages
- Push notifications for messages and other interactions

### Enhancements & UX
- Caching profiles, images, and other resources
- Animations with Rive and Lottie for a polished experience
- Improved loading performance when opening the app
- Image cropping before selection

## Technologies Used

- **Flutter**: Cross-platform UI development
- **Firebase**:
  - Authentication (User management)
  - Firestore (Database storage)
  - Storage (Media storage & retrieval)
  - Cloud Messaging (Real-time messaging & notifications)
  - Crashlytics (Error handling & logging)
  - Firestore batch transactions for optimized updates
- **State Management**: Bloc pattern


### Upcoming Features
- [ ] Notifications for likes, comments, follows, etc.
- [ ] Video and voice calling in chat
- [ ] Group chat functionality
- [ ] Video and voice calling in group chat
- [ ] Send posts in chat
- [ ] Share profiles via chat and external apps
- [ ] Control dimensions of selected images & videos
- [ ] Dark mode for a comfortable viewing experience
- [ ] Infinite scroll pagination for posts
- [ ] Custom gallery display
- [ ] Post sharing
- [ ] Reply, like, and delete comments
- [ ] Support for GIFs, music, and location in posts
- [ ] 24-hour stories
- [ ] Web platform optimization
- [ ] Typing indicators in chat
- [ ] Codebase cleanup and optimization

## Getting Started

### Prerequisites
Ensure you have the following installed:
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Firebase CLI](https://firebase.google.com/docs/cli)

### Installation Steps
1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-repo/inbox_project.git
   cd inbox_project
