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
3. **Run the following command to automate the process of generating boilerplate code.**:
   ```bash
   dart run build_runner build --delete-conflicting-outputs 
   ```
4. **Add the config.json file to the lib directory and specify the necessary values as follows.**:
     ```bash
   {
     "project_id" : "Your value here",
     "bearer_token" : "Your value here"
   }
   ```~~~~
5. **Run the project **:
   ```bash
   flutter run --dart-define-from-file="lib/config.json"
   ```
6. **Run the following command to generate the release build **:
       ```bash
         flutter build apk --release --dart-define-from-file="lib/config.json"
       ```

# File size : 
    approximately - 22MB



# Few screenshots : 
<img width="328" alt="Screenshot 2024-08-16 at 7 06 54 PM" src="https://github.com/user-attachments/assets/c97097ee-a78b-4b88-abd5-b5b035a3a32e">
<img width="330" alt="Screenshot 2024-08-16 at 7 11 06 PM" src="https://github.com/user-attachments/assets/db7c5ff5-2c5b-44e9-9beb-bb4e094f29c5">
<img width="339" alt="Screenshot 2024-08-16 at 7 10 52 PM" src="https://github.com/user-attachments/assets/5c20e94a-4333-4643-a5f2-d6c8648f1786">
<img width="341" alt="Screenshot 2024-08-16 at 7 10 18 PM" src="https://github.com/user-attachments/assets/c75acbe5-97bf-41a4-a9d5-75fcef0587f1">
<img width="338" alt="Screenshot 2024-08-16 at 7 10 05 PM" src="https://github.com/user-attachments/assets/d94b2d06-8e00-4e86-bb3f-245b4f427704">
<img width="332" alt="Screenshot 2024-08-16 at 7 09 55 PM" src="https://github.com/user-attachments/assets/d6c8ecb4-ef34-484f-bc4f-4b227b871042">
<img width="329" alt="Screenshot 2024-08-16 at 7 07 43 PM" src="https://github.com/user-attachments/assets/d803dafc-5daf-4957-9a52-586e643f4e9a">
<img width="331" alt="Screenshot 2024-08-16 at 7 07 28 PM" src="https://github.com/user-attachments/assets/6adae76e-452b-405a-a7fb-82a725e97c2b">
<img width="334" alt="Screenshot 2024-08-16 at 7 07 19 PM" src="https://github.com/user-attachments/assets/6045c5a5-c4ad-4d29-99bb-b956e5c1fb36">
