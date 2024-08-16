# time_tracking_app

This Flutter application offers a robust Kanban board for task management, enabling users to create, edit, and move tasks across different columns such as "To Do," "In Progress," and "Completed." It also integrates a timer feature that allows users to track the time spent on each task. Additionally, the app maintains a history of completed tasks and provides a commenting feature for each task to facilitate collaboration or personal notes.

Task management within the app is powered by the Todoist API, while local data storage is efficiently managed using Sqflite. The application is developed with a clean architecture approach, ensuring maintainability and scalability, and leverages the BLoC (Business Logic Component) state management technique to manage the app's state efficiently.

## Getting Started
Prerequisites
Flutter SDK: Ensure you have Flutter installed on your machine. Follow the instructions on the official Flutter website to set it up.


# Installation

This app is built using the flutter version 3.22.2

### Installation

1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd time_tracking_app
   ```
2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```   
3. **Run the following command for automating the process of generating boilerplate code**:
   ```bash
   dart run build_runner build --delete-conflicting-outputs 
   ```
4. **add config.json file into the lib directory, and specify the necessary values as following**:
   {
     "project_id" : "Your value here",
     "bearer_token" : "Your value here"
   }
5. **Run the project **:
   ```bash
   flutter run --dart-define-from-file="lib/config.json"
   ```

    **Run the following command to generate the release build **:
       ```bash
         flutter build apk --release --dart-define-from-file="lib/config.json"
       ```

# File size : 
    approximately - 22MB


