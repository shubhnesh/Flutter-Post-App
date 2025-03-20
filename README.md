# Flutter-Post-App

A Flutter app that fetches and displays posts from the JSONPlaceholder API, implementing infinite scrolling with pagination, loading indicators, and an enhanced UI.

# Project Setup Instructions

## Prerequisites
- Install Flutter
- Install VS Code or Android Studio
- Enable Developer Mode on your physical device if using wireless debugging

## Clone the Repository
- ```bash
  git clone https://github.com/shubhnesh/Flutter-Post-App

## Install Dependencies
- ```bash
  pub get

## Run the App
- ```bash
  flutter run

## Check if the device is recognized:
- ```bash
  flutter devices

## Features Implemented
- **API Integration:** Fetches posts from JSONPlaceholder API.
- **Infinite Scrolling with Pagination:** Loads 35 posts at a time, displaying a loading indicator at the bottom.
- **ListView for Displaying Data:** Shows post titles in separate cards.
- **Detailed Post View:** Clicking a title opens a page with id, userId, and body.
- **Loading Indicators:**
  - Shows a CircularProgressIndicator when fetching posts.
  - Bottom scrolling loader for seamless infinite scrolling.
 
## Additional Enhancements
- **Data Pagination:** The API does not support server-side pagination, so we manually fetch posts in chunks of 35.
- **Error Handling:** Displays an error message if the API request fails.

- **Enhanced UI:**
  - AppBar Title Centered
  - Professional Card Styling
 
 ## Screenshots

- **Data successfully retrieved from the API**

<p align="center">
  <img src="https://github.com/shubhnesh/Flutter-Post-App/blob/main/Screenshots/loading.jpg" width="250">
  <img src="https://github.com/shubhnesh/Flutter-Post-App/blob/main/Screenshots/home.jpg" width="250">
  <img src="https://github.com/shubhnesh/Flutter-Post-App/blob/main/Screenshots/detail.jpg" width="250">
</p>


- **When an error occurs**
<p align="center">
  <img src=" https://github.com/shubhnesh/Flutter-Post-App/blob/main/Screenshots/error.jpg" width="250">
</p>
