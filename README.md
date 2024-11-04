# MBL QA Task

This repository contains a UI built to interact with and test the API endpoints specified in the Postman documentation provided by MBL Limited. The application consumes endpoints for various tasks, ensuring accurate API responses and demonstrating functionality based on the assignment requirements. Built using Flutter (dart), this project provides a user-friendly interface to perform actions aligned with the QA process.

---

## Getting Started 🚀

- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed
- An IDE such as [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/)


## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/username/repo-name.git
   cd repo-name
   
2. **Install Dependencies**:
   ```bash
   flutter pub get

3. **Run on Emulator or Connected Device**:
   ```bash
   flutter run
   
4. **Specify Device (if multiple devices are connected)**:
   ```bash
   flutter run -d <device_id>

## Testing the API Integration
The UI allows you to interact with the endpoints by sending requests and viewing responses directly. Follow on-screen instructions to test each API.

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```
