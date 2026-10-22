# CareerPrep AI

CareerPrep AI is a Flutter-based interview-preparation and resume-feedback app. It brings interview practice, quiz-based learning, progress tracking, and local resume analysis into one place.

> **Project status:** Portfolio project in active development. Scores and recommendations from the Resume Analyzer are rule-based estimates, not a guarantee of how a real applicant-tracking system (ATS) will score a resume.

## Features

- **Interview question bank:** 100 questions across Flutter, Dart, Programming, and HR, with difficulty levels, answers, and explanations.
- **Practice and quizzes:** Choose a category, difficulty, and question count; answer one question at a time; navigate, skip, revisit, and review answers.
- **Bookmarks and revision:** Save questions and revisit bookmarked or previously missed questions.
- **Quiz history and analytics:** Review past attempts and see score/performance summaries.
- **Personalized practice:** Use local progress and quiz history to identify categories that need more practice.
- **Resume Analyzer:** Upload a PDF resume, compare its extracted text with a job description, inspect matched/missing skills, review an ATS-style estimate, and get a rule-based action plan and interview prompts.
- **Resume checklist:** Check common resume-content essentials.
- **Local persistence:** Selected practice data and preferences are stored on the device/browser using SharedPreferences.

## Tech stack

- Flutter and Dart
- Material 3 widgets
- `shared_preferences` for local persistence
- `file_picker` for selecting a resume PDF
- Syncfusion Flutter PDF for text extraction

Check `pubspec.yaml` for the exact dependency versions used by your checkout.

## Run locally

Install the Flutter SDK and verify your setup:

```bash
flutter doctor
```

From the project root:

```bash
flutter pub get
 dart format lib/main.dart
flutter analyze
flutter test
flutter run -d chrome
```

To run with the web-server device instead:

```bash
flutter run -d web-server --web-port 8080
```

Open the local address printed by Flutter in your browser.

## Resume privacy and scoring notes

Resume text extraction and job-description matching are designed to run locally in the app; this version does not require a paid AI API. Avoid uploading resumes containing information you do not want stored or processed in your browser. The ATS-style score is a heuristic estimate based on detected keywords and resume-content checks. It is not an actual ATS result and should not be presented as one.

## Quality checks

Before pushing changes, run:

```bash
dart format lib test
flutter analyze
flutter test
flutter build web
```

See [`TESTING_CHECKLIST.md`](TESTING_CHECKLIST.md) for manual acceptance checks and [`DEPLOYMENT.md`](DEPLOYMENT.md) for web deployment notes.

## Suggested screenshots

Add real screenshots from your running app to `screenshots/` and update this section:

- `screenshots/dashboard.png` — dashboard and feature navigation
- `screenshots/quiz.png` — active quiz question
- `screenshots/progress.png` — progress and personalized practice
- `screenshots/resume-analyzer.png` — resume analysis results

Only use screenshots from the current working version. Do not include real personal resumes, email addresses, phone numbers, or other private information.

## Roadmap

- [x] Interview question bank and quiz workflow
- [x] Bookmarks, quiz history, and progress tracking
- [x] Local resume analysis and skill-gap recommendations
- [x] Personalized practice and revision mode
- [x] Responsive/error-state improvements
- [ ] Expand automated unit and widget coverage
- [ ] Capture portfolio screenshots and publish a live demo

## License

Choose and add a license before presenting this repository as open source. Do not claim a license that has not been added.
