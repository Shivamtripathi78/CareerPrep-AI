import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const CareerPrepApp());
}

class CareerPrepApp extends StatelessWidget {
  const CareerPrepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CareerPrep AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F7F3),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF536D4F),
          primary: const Color(0xFF536D4F),
          surface: Colors.white,
        ),
        fontFamily: 'Arial',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE4E5DB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE4E5DB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF536D4F), width: 1.6),
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0xFFE4E5DB)),
          ),
        ),
      ),
      home: const CareerPrepHome(),
    );
  }
}

class InterviewQuestion {
  final int id;
  final String category;
  final String difficulty;
  final String question;
  final String answer;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;

  const InterviewQuestion({
    required this.id,
    required this.category,
    required this.difficulty,
    required this.question,
    required this.answer,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
  });
}

const List<InterviewQuestion> questionBank = [
  InterviewQuestion(
    id: 1,
    category: 'Flutter',
    difficulty: 'Beginner',
    question: 'What is Flutter?',
    answer: 'Flutter is an open-source UI toolkit developed by Google for building cross-platform applications.',
    options: [
      'A programming language',
      'A UI toolkit for building cross-platform applications',
      'A database management system',
      'An operating system',
    ],
    correctOptionIndex: 1,
    explanation: 'Flutter is a UI toolkit that uses Dart to build applications for multiple platforms.',
  ),
  InterviewQuestion(
    id: 2,
    category: 'Flutter',
    difficulty: 'Intermediate',
    question:
        'What is the difference between StatelessWidget and StatefulWidget?',
    answer: 'A StatelessWidget is suitable for UI that does not manage mutable state. A StatefulWidget uses a separate State object to manage changing data.',
    options: [
      'They are exactly the same',
      'A StatelessWidget always requires a database',
      'A StatefulWidget can manage changing state',
      'A StatelessWidget cannot display text',
    ],
    correctOptionIndex: 2,
    explanation: 'A StatefulWidget works with a State object that can update the UI when its state changes.',
  ),
  InterviewQuestion(
    id: 3,
    category: 'Dart',
    difficulty: 'Beginner',
    question: 'What is null safety in Dart?',
    answer:
        'Null safety helps prevent errors caused by unexpected null values.',
    options: [
      'A way to make every variable nullable',
      'A feature that helps prevent unexpected null-value errors',
      'A tool for designing layouts',
      'A method for connecting to the internet',
    ],
    correctOptionIndex: 1,
    explanation: 'Dart null safety distinguishes nullable and non-nullable types to help prevent null-reference errors.',
  ),
  InterviewQuestion(
    id: 4,
    category: 'Programming',
    difficulty: 'Beginner',
    question: 'What is the difference between a List and a Set?',
    answer: 'A List is ordered and can contain duplicate values. A Set stores unique values.',
    options: [
      'A List stores only numbers',
      'A Set always allows duplicates',
      'A List and Set are identical',
      'A List is ordered and may contain duplicates, while a Set stores unique values',
    ],
    correctOptionIndex: 3,
    explanation: 'Lists preserve order and may contain duplicates. Sets are designed to contain unique elements.',
  ),
  InterviewQuestion(
    id: 5,
    category: 'Programming',
    difficulty: 'Intermediate',
    question: 'What is the time complexity of binary search?',
    answer: 'Binary search has O(log n) time complexity when searching a sorted collection.',
    options: ['O(n)', 'O(log n)', 'O(n²)', 'O(1) in every case'],
    correctOptionIndex: 1,
    explanation: 'Binary search repeatedly halves the remaining search space, giving logarithmic time complexity.',
  ),
  InterviewQuestion(
    id: 6,
    category: 'HR',
    difficulty: 'Beginner',
    question:
        'What should you include when answering "Tell me about yourself"?',
    answer: 'Briefly explain your education, relevant skills, projects, and career goals.',
    options: [
      'Only your personal hobbies',
      'Your entire life story',
      'Your education, relevant skills, projects, and career goals',
      'Only your salary expectations',
    ],
    correctOptionIndex: 2,
    explanation: 'A concise, job-relevant introduction helps an interviewer understand your background and suitability for the role.',
  ),
  InterviewQuestion(
    id: 7,
    category: 'HR',
    difficulty: 'Intermediate',
    question: 'How should you answer "Why should we hire you?"?',
    answer: 'Connect your relevant skills, projects, problem-solving abilities, and willingness to learn to the role.',
    options: [
      'Explain how your relevant skills and experience match the role',
      'Say that you need any available job',
      'Guarantee that you will never make mistakes',
      'Discuss only your personal problems',
    ],
    correctOptionIndex: 0,
    explanation: 'Support your answer with relevant skills, examples, and how you could contribute to the employer.',
  ),
  InterviewQuestion(
    id: 8,
    category: 'Dart',
    difficulty: 'Intermediate',
    question: 'What is the purpose of async and await in Dart?',
    answer: 'They make asynchronous operations easier to write and understand.',
    options: [
      'They create Flutter widgets automatically',
      'They replace all variables',
      'They make every function run synchronously',
      'They help write readable asynchronous code using Futures',
    ],
    correctOptionIndex: 3,
    explanation: 'An async function can return a Future, and await lets code wait for an asynchronous result without blocking the event loop.',
  ),
  InterviewQuestion(
    id: 9,
    category: "Flutter",
    difficulty: "Beginner",
    question: "What is the widget tree in Flutter?",
    answer: "The hierarchy of widgets that describes the UI",
    options: [
      "A database schema",
      "The hierarchy of widgets that describes the UI",
      "A network request queue",
      "A Dart package lockfile",
    ],
    correctOptionIndex: 1,
    explanation: "Flutter composes the interface from nested widgets.",
  ),
  InterviewQuestion(
    id: 10,
    category: "Flutter",
    difficulty: "Intermediate",
    question: "What does setState() do?",
    answer: "It tells Flutter to rebuild the State object’s UI after a change",
    options: [
      "It saves data to a database",
      "It tells Flutter to rebuild the State object’s UI after a change",
      "It navigates to another route",
      "It compiles Dart to machine code",
    ],
    correctOptionIndex: 1,
    explanation: "Calling setState schedules a rebuild so the UI reflects changed state.",
  ),
  InterviewQuestion(
    id: 11,
    category: "Flutter",
    difficulty: "Advanced",
    question: "What is hot reload used for?",
    answer: "Applying many code changes while preserving current app state",
    options: [
      "Reinstalling the operating system",
      "Applying many code changes while preserving current app state",
      "Publishing to an app store",
      "Clearing all application data",
    ],
    correctOptionIndex: 1,
    explanation: "Hot reload injects updated code and rebuilds the widget tree in development.",
  ),
  InterviewQuestion(
    id: 12,
    category: "Flutter",
    difficulty: "Beginner",
    question: "Which widget arranges children vertically?",
    answer: "Column",
    options: ["Row", "Stack", "Column", "Wrap"],
    correctOptionIndex: 2,
    explanation: "Column lays out its children along the vertical axis.",
  ),
  InterviewQuestion(
    id: 13,
    category: "Flutter",
    difficulty: "Intermediate",
    question: "Which widget arranges children horizontally?",
    answer: "Row",
    options: ["Row", "Column", "Scaffold", "MaterialApp"],
    correctOptionIndex: 0,
    explanation: "Row lays out children along the horizontal axis.",
  ),
  InterviewQuestion(
    id: 14,
    category: "Flutter",
    difficulty: "Advanced",
    question: "What is the purpose of Scaffold?",
    answer: "It provides a standard Material page structure",
    options: [
      "It stores preferences",
      "It provides a standard Material page structure",
      "It parses JSON",
      "It runs unit tests",
    ],
    correctOptionIndex: 1,
    explanation: "Scaffold provides common page elements such as app bar, body, drawer and bottom navigation.",
  ),
  InterviewQuestion(
    id: 15,
    category: "Flutter",
    difficulty: "Beginner",
    question: "What does Expanded do inside a Row or Column?",
    answer: "It makes a child fill available flexible space",
    options: [
      "It hides a child",
      "It makes a child fill available flexible space",
      "It adds a route",
      "It converts a widget to a stateful widget",
    ],
    correctOptionIndex: 1,
    explanation: "Expanded allocates remaining main-axis space to a child.",
  ),
  InterviewQuestion(
    id: 16,
    category: "Flutter",
    difficulty: "Intermediate",
    question: "What is BuildContext used for?",
    answer: "It identifies a widget’s location in the widget tree",
    options: [
      "It stores all app files",
      "It identifies a widget’s location in the widget tree",
      "It is a database connection",
      "It creates Dart classes automatically",
    ],
    correctOptionIndex: 1,
    explanation: "BuildContext enables access to inherited widgets and location-dependent APIs.",
  ),
  InterviewQuestion(
    id: 17,
    category: "Flutter",
    difficulty: "Advanced",
    question: "What is a Key commonly used for?",
    answer: "Helping Flutter identify widgets across rebuilds",
    options: [
      "Encrypting network traffic",
      "Helping Flutter identify widgets across rebuilds",
      "Changing text size only",
      "Loading packages",
    ],
    correctOptionIndex: 1,
    explanation: "Keys help Flutter match widgets and preserve the correct state when children change.",
  ),
  InterviewQuestion(
    id: 18,
    category: "Flutter",
    difficulty: "Beginner",
    question: "Which widget makes content scrollable?",
    answer: "SingleChildScrollView",
    options: ["Container", "Center", "SingleChildScrollView", "Divider"],
    correctOptionIndex: 2,
    explanation: "SingleChildScrollView allows a single child to scroll when it overflows.",
  ),
  InterviewQuestion(
    id: 19,
    category: "Flutter",
    difficulty: "Intermediate",
    question: "What is ListView.builder useful for?",
    answer: "Building list items lazily as they are needed",
    options: [
      "Building only static text",
      "Building list items lazily as they are needed",
      "Creating a database table",
      "Styling a theme",
    ],
    correctOptionIndex: 1,
    explanation: "Lazy construction is efficient for long or dynamic lists.",
  ),
  InterviewQuestion(
    id: 20,
    category: "Flutter",
    difficulty: "Advanced",
    question: "What does Navigator.push generally do?",
    answer: "Adds a route to the navigation stack",
    options: [
      "Removes every route",
      "Adds a route to the navigation stack",
      "Refreshes package dependencies",
      "Changes the app icon",
    ],
    correctOptionIndex: 1,
    explanation: "Navigator.push displays a new route above the current route.",
  ),
  InterviewQuestion(
    id: 21,
    category: "Flutter",
    difficulty: "Beginner",
    question: "What does Navigator.pop generally do?",
    answer: "Removes the current route from the stack",
    options: [
      "Adds a new route",
      "Removes the current route from the stack",
      "Restarts the device",
      "Updates pubspec.yaml",
    ],
    correctOptionIndex: 1,
    explanation:
        "Navigator.pop returns to the previous route in the navigation stack.",
  ),
  InterviewQuestion(
    id: 22,
    category: "Flutter",
    difficulty: "Intermediate",
    question: "What is the purpose of pubspec.yaml?",
    answer: "It declares dependencies and project assets/configuration",
    options: [
      "It defines every widget tree",
      "It declares dependencies and project assets/configuration",
      "It stores user passwords",
      "It contains only test results",
    ],
    correctOptionIndex: 1,
    explanation: "Flutter projects use pubspec.yaml for packages, assets, fonts and project metadata.",
  ),
  InterviewQuestion(
    id: 23,
    category: "Flutter",
    difficulty: "Advanced",
    question: "Why use const widgets where possible?",
    answer: "To enable compile-time constants and reduce unnecessary object creation",
    options: [
      "To make all widgets mutable",
      "To enable compile-time constants and reduce unnecessary object creation",
      "To force network calls",
      "To disable rendering",
    ],
    correctOptionIndex: 1,
    explanation: "Const constructors can allow Flutter/Dart to reuse constant widget instances.",
  ),
  InterviewQuestion(
    id: 24,
    category: "Flutter",
    difficulty: "Beginner",
    question: "What is a FutureBuilder designed for?",
    answer: "Building UI based on a Future’s state",
    options: [
      "Drawing vector icons only",
      "Building UI based on a Future’s state",
      "Saving local files automatically",
      "Defining routes only",
    ],
    correctOptionIndex: 1,
    explanation: "FutureBuilder reacts to waiting, success and error states of a Future.",
  ),
  InterviewQuestion(
    id: 25,
    category: "Flutter",
    difficulty: "Intermediate",
    question: "What is a StreamBuilder designed for?",
    answer: "Building UI in response to stream events",
    options: [
      "Building UI in response to stream events",
      "Creating static constants",
      "Replacing the Dart compiler",
      "Managing image assets only",
    ],
    correctOptionIndex: 0,
    explanation: "StreamBuilder rebuilds as new events arrive from a Stream.",
  ),
  InterviewQuestion(
    id: 26,
    category: "Flutter",
    difficulty: "Advanced",
    question: "What is an InheritedWidget used for?",
    answer: "Passing data down the widget tree efficiently",
    options: [
      "Making every variable global",
      "Passing data down the widget tree efficiently",
      "Creating SQL tables",
      "Compiling Flutter apps",
    ],
    correctOptionIndex: 1,
    explanation: "InheritedWidget lets descendants depend on shared data and be notified when it changes.",
  ),
  InterviewQuestion(
    id: 27,
    category: "Flutter",
    difficulty: "Beginner",
    question: "What is the role of MaterialApp?",
    answer: "It configures app-level Material Design behavior and navigation",
    options: [
      "It stores images in memory",
      "It configures app-level Material Design behavior and navigation",
      "It is a Dart loop",
      "It runs only on iOS",
    ],
    correctOptionIndex: 1,
    explanation: "MaterialApp commonly configures themes, routes, localization and the app navigator.",
  ),
  InterviewQuestion(
    id: 28,
    category: "Flutter",
    difficulty: "Intermediate",
    question: "What does MediaQuery provide?",
    answer: "Information about the current view such as size and accessibility settings",
    options: [
      "A list of installed packages",
      "Information about the current view such as size and accessibility settings",
      "A server database",
      "A replacement for State",
    ],
    correctOptionIndex: 1,
    explanation:
        "MediaQuery exposes view-related information to responsive widgets.",
  ),
  InterviewQuestion(
    id: 29,
    category: "Flutter",
    difficulty: "Advanced",
    question: "What is a StatelessWidget best suited for?",
    answer: "UI that depends on inputs and does not manage mutable State",
    options: [
      "Any UI requiring its own mutable State",
      "UI that depends on inputs and does not manage mutable State",
      "Database transactions",
      "Background operating-system services",
    ],
    correctOptionIndex: 1,
    explanation: "A StatelessWidget is appropriate when its configuration comes from constructor inputs or inherited data.",
  ),
  InterviewQuestion(
    id: 30,
    category: "Flutter",
    difficulty: "Beginner",
    question: "What does dispose() commonly do in a State object?",
    answer: "Releases resources such as controllers and subscriptions",
    options: [
      "Builds the widget tree for the first time",
      "Releases resources such as controllers and subscriptions",
      "Adds a route",
      "Loads pub packages",
    ],
    correctOptionIndex: 1,
    explanation: "dispose is the place to clean up resources owned by the State before it is removed.",
  ),
  InterviewQuestion(
    id: 31,
    category: "Flutter",
    difficulty: "Intermediate",
    question: "What is the purpose of a Form widget?",
    answer: "To group and validate form fields",
    options: [
      "To display only images",
      "To group and validate form fields",
      "To replace MaterialApp",
      "To persist all data automatically",
    ],
    correctOptionIndex: 1,
    explanation: "Form works with FormField widgets and a GlobalKey<FormState> for validation.",
  ),
  InterviewQuestion(
    id: 32,
    category: "Dart",
    difficulty: "Advanced",
    question: "Which keyword declares a variable whose value can be reassigned with inferred type?",
    answer: "var",
    options: ["final", "const", "var", "static"],
    correctOptionIndex: 2,
    explanation:
        "var infers a type while allowing reassignment within that type.",
  ),
  InterviewQuestion(
    id: 33,
    category: "Dart",
    difficulty: "Beginner",
    question: "What is the difference between final and const?",
    answer:
        "final is assigned once at runtime; const is a compile-time constant",
    options: [
      "They are always identical",
      "final is assigned once at runtime; const is a compile-time constant",
      "const can always be reassigned",
      "final only works with integers",
    ],
    correctOptionIndex: 1,
    explanation: "const values must be compile-time constants, while final can be initialized at runtime.",
  ),
  InterviewQuestion(
    id: 34,
    category: "Dart",
    difficulty: "Intermediate",
    question: "How do you declare a nullable String in Dart?",
    answer: "String? name",
    options: [
      "String name?",
      "nullable String name",
      "String? name",
      "String! name",
    ],
    correctOptionIndex: 2,
    explanation:
        "The question mark after the type makes the variable nullable.",
  ),
  InterviewQuestion(
    id: 35,
    category: "Dart",
    difficulty: "Advanced",
    question: "What does the ?? operator do?",
    answer: "Returns the right operand when the left operand is null",
    options: [
      "Checks equality",
      "Returns the right operand when the left operand is null",
      "Casts a value to String",
      "Creates a Future",
    ],
    correctOptionIndex: 1,
    explanation:
        "The null-coalescing operator supplies a fallback for a null value.",
  ),
  InterviewQuestion(
    id: 36,
    category: "Dart",
    difficulty: "Beginner",
    question: "What does the ??= operator do?",
    answer: "Assigns a value only if the variable is null",
    options: [
      "Always overwrites the variable",
      "Assigns a value only if the variable is null",
      "Compares two values",
      "Declares a constant",
    ],
    correctOptionIndex: 1,
    explanation:
        "Null-aware assignment preserves a non-null value already present.",
  ),
  InterviewQuestion(
    id: 37,
    category: "Dart",
    difficulty: "Intermediate",
    question: "What is a Future in Dart?",
    answer: "An eventual result or error from an asynchronous operation",
    options: [
      "A synchronous loop",
      "An eventual result or error from an asynchronous operation",
      "A widget layout",
      "A collection that forbids duplicates",
    ],
    correctOptionIndex: 1,
    explanation: "Future represents a result that may become available later.",
  ),
  InterviewQuestion(
    id: 38,
    category: "Dart",
    difficulty: "Advanced",
    question: "Which collection stores key-value pairs?",
    answer: "Map",
    options: ["List", "Set", "Map", "Queue"],
    correctOptionIndex: 2,
    explanation: "A Map associates each key with a value.",
  ),
  InterviewQuestion(
    id: 39,
    category: "Dart",
    difficulty: "Beginner",
    question: "What does List.map() typically return?",
    answer: "An iterable of transformed elements",
    options: [
      "A single integer always",
      "An iterable of transformed elements",
      "A database connection",
      "A widget context",
    ],
    correctOptionIndex: 1,
    explanation:
        "map applies a transformation to each element and returns an Iterable.",
  ),
  InterviewQuestion(
    id: 40,
    category: "Dart",
    difficulty: "Intermediate",
    question: "What does where() do on an iterable?",
    answer: "Filters elements using a condition",
    options: [
      "Sorts all elements automatically",
      "Filters elements using a condition",
      "Converts every value to String",
      "Deletes the original variable",
    ],
    correctOptionIndex: 1,
    explanation: "where yields elements for which the predicate returns true.",
  ),
  InterviewQuestion(
    id: 41,
    category: "Dart",
    difficulty: "Advanced",
    question: "What is an anonymous function?",
    answer: "A function without a declared name",
    options: [
      "A function that cannot take parameters",
      "A function without a declared name",
      "A function that always runs asynchronously",
      "A class constructor only",
    ],
    correctOptionIndex: 1,
    explanation: "Anonymous functions can be assigned to variables or passed as callbacks.",
  ),
  InterviewQuestion(
    id: 42,
    category: "Dart",
    difficulty: "Beginner",
    question: "What is a named parameter?",
    answer: "A parameter passed by its name at the call site",
    options: [
      "A parameter that must always be positional",
      "A parameter passed by its name at the call site",
      "A global variable",
      "A package dependency",
    ],
    correctOptionIndex: 1,
    explanation:
        "Named parameters improve readability and can be optional or required.",
  ),
  InterviewQuestion(
    id: 43,
    category: "Dart",
    difficulty: "Intermediate",
    question: "What does required mean for a named parameter?",
    answer: "The caller must supply that parameter",
    options: [
      "The parameter is always nullable",
      "The caller must supply that parameter",
      "The function cannot return",
      "The parameter is private",
    ],
    correctOptionIndex: 1,
    explanation: "required enforces that a named argument is provided.",
  ),
  InterviewQuestion(
    id: 44,
    category: "Dart",
    difficulty: "Advanced",
    question: "What is an extension method used for?",
    answer: "Adding callable functionality to an existing type without modifying it",
    options: [
      "Changing a type’s source code",
      "Adding callable functionality to an existing type without modifying it",
      "Creating a new isolate automatically",
      "Replacing inheritance everywhere",
    ],
    correctOptionIndex: 1,
    explanation: "Extensions add methods or getters that can be called on existing types.",
  ),
  InterviewQuestion(
    id: 45,
    category: "Dart",
    difficulty: "Beginner",
    question: "What does the late keyword allow?",
    answer: "Deferring initialization of a non-nullable variable",
    options: [
      "Making a variable constant at compile time",
      "Deferring initialization of a non-nullable variable",
      "Making all values nullable",
      "Declaring a loop",
    ],
    correctOptionIndex: 1,
    explanation: "late tells Dart that initialization will occur before the variable is accessed.",
  ),
  InterviewQuestion(
    id: 46,
    category: "Dart",
    difficulty: "Intermediate",
    question: "What is an enum used for?",
    answer: "Representing a fixed set of constant values",
    options: [
      "Storing arbitrary key-value pairs",
      "Representing a fixed set of constant values",
      "Running asynchronous tasks",
      "Building UI layouts",
    ],
    correctOptionIndex: 1,
    explanation: "Enums model a finite set of named options.",
  ),
  InterviewQuestion(
    id: 47,
    category: "Dart",
    difficulty: "Advanced",
    question: "What is a mixin in Dart?",
    answer: "A way to reuse members across classes without ordinary superclass inheritance",
    options: [
      "A database index",
      "A way to reuse members across classes without ordinary superclass inheritance",
      "A type of loop",
      "A package manager",
    ],
    correctOptionIndex: 1,
    explanation: "Mixins provide reusable implementations that classes can include with with.",
  ),
  InterviewQuestion(
    id: 48,
    category: "Dart",
    difficulty: "Beginner",
    question: "What does implements require a class to do?",
    answer: "Provide implementations for the interface members",
    options: [
      "Inherit all implementation automatically",
      "Provide implementations for the interface members",
      "Become immutable",
      "Run only on web",
    ],
    correctOptionIndex: 1,
    explanation: "A class using implements must implement the interface’s required members.",
  ),
  InterviewQuestion(
    id: 49,
    category: "Dart",
    difficulty: "Intermediate",
    question: "What does an abstract class do?",
    answer: "Defines a class that cannot be instantiated directly and may declare abstract members",
    options: [
      "It can never contain methods",
      "Defines a class that cannot be instantiated directly and may declare abstract members",
      "It stores only constants",
      "It disables inheritance",
    ],
    correctOptionIndex: 1,
    explanation: "Abstract classes can define a shared interface and partial implementation.",
  ),
  InterviewQuestion(
    id: 50,
    category: "Dart",
    difficulty: "Advanced",
    question: "What is a factory constructor allowed to do?",
    answer: "Return an existing instance or an instance of a subtype",
    options: [
      "Return only an int",
      "Return an existing instance or an instance of a subtype",
      "Never return an object",
      "Replace all named parameters",
    ],
    correctOptionIndex: 1,
    explanation: "Factory constructors control instance creation and need not always create a new instance.",
  ),
  InterviewQuestion(
    id: 51,
    category: "Dart",
    difficulty: "Beginner",
    question: "What does await do inside an async function?",
    answer: "Waits for a Future’s result before continuing that async function",
    options: [
      "Blocks the entire operating system",
      "Waits for a Future’s result before continuing that async function",
      "Makes a variable constant",
      "Converts a Future to a Stream always",
    ],
    correctOptionIndex: 1,
    explanation:
        "await suspends the async function until the awaited Future completes.",
  ),
  InterviewQuestion(
    id: 52,
    category: "Dart",
    difficulty: "Intermediate",
    question: "What is an isolate used for?",
    answer: "Running Dart code with its own memory and event loop",
    options: [
      "Sharing mutable memory freely between threads",
      "Running Dart code with its own memory and event loop",
      "Creating a widget theme",
      "Persisting browser preferences",
    ],
    correctOptionIndex: 1,
    explanation: "Isolates provide concurrency without shared mutable memory.",
  ),
  InterviewQuestion(
    id: 53,
    category: "Dart",
    difficulty: "Advanced",
    question: "What does the cascade operator (..) allow?",
    answer: "Performing multiple operations on the same object",
    options: [
      "Calling only static methods",
      "Performing multiple operations on the same object",
      "Declaring nullable types",
      "Ending a function",
    ],
    correctOptionIndex: 1,
    explanation: "Cascades let you invoke multiple members on one object without repeating its expression.",
  ),
  InterviewQuestion(
    id: 54,
    category: "Dart",
    difficulty: "Beginner",
    question: "What is a getter?",
    answer: "A method-like member accessed as a property",
    options: [
      "A constructor that deletes objects",
      "A method-like member accessed as a property",
      "A special loop",
      "A package version",
    ],
    correctOptionIndex: 1,
    explanation:
        "Getters expose computed or encapsulated values with property syntax.",
  ),
  InterviewQuestion(
    id: 55,
    category: "Programming",
    difficulty: "Intermediate",
    question: "What is the time complexity of linear search in the worst case?",
    answer: "O(n)",
    options: ["O(1)", "O(log n)", "O(n)", "O(n log n)"],
    correctOptionIndex: 2,
    explanation: "Linear search may inspect every element.",
  ),
  InterviewQuestion(
    id: 56,
    category: "Programming",
    difficulty: "Advanced",
    question: "Which data structure follows LIFO?",
    answer: "Stack",
    options: ["Queue", "Stack", "Heap", "Graph"],
    correctOptionIndex: 1,
    explanation: "A stack removes the most recently added item first.",
  ),
  InterviewQuestion(
    id: 57,
    category: "Programming",
    difficulty: "Beginner",
    question: "Which data structure follows FIFO?",
    answer: "Queue",
    options: ["Stack", "Tree", "Queue", "Graph"],
    correctOptionIndex: 2,
    explanation: "A queue removes the earliest added item first.",
  ),
  InterviewQuestion(
    id: 58,
    category: "Programming",
    difficulty: "Intermediate",
    question: "What is recursion?",
    answer: "A function calling itself to solve smaller instances",
    options: [
      "A loop that never ends",
      "A function calling itself to solve smaller instances",
      "Sorting by swapping only",
      "A database join",
    ],
    correctOptionIndex: 1,
    explanation: "Recursive solutions need a base case to stop the calls.",
  ),
  InterviewQuestion(
    id: 59,
    category: "Programming",
    difficulty: "Advanced",
    question: "What is a base case in recursion?",
    answer: "A condition that stops further recursive calls",
    options: [
      "The first array element only",
      "A condition that stops further recursive calls",
      "A class constructor",
      "A sorting algorithm",
    ],
    correctOptionIndex: 1,
    explanation: "Without a reachable base case, recursion may continue until a stack overflow.",
  ),
  InterviewQuestion(
    id: 60,
    category: "Programming",
    difficulty: "Beginner",
    question: "Which sorting algorithm has average O(n log n) time and is not stable by default?",
    answer: "Quicksort",
    options: ["Bubble sort", "Insertion sort", "Quicksort", "Linear search"],
    correctOptionIndex: 2,
    explanation: "Quicksort is typically O(n log n) on average but can degrade to O(n²).",
  ),
  InterviewQuestion(
    id: 61,
    category: "Programming",
    difficulty: "Intermediate",
    question: "What is the worst-case time complexity of bubble sort?",
    answer: "O(n²)",
    options: ["O(log n)", "O(n)", "O(n²)", "O(n log n)"],
    correctOptionIndex: 2,
    explanation:
        "Nested passes and comparisons produce quadratic worst-case time.",
  ),
  InterviewQuestion(
    id: 62,
    category: "Programming",
    difficulty: "Advanced",
    question: "What is a hash table designed for?",
    answer: "Fast key-based lookup on average",
    options: [
      "Maintaining sorted order always",
      "Fast key-based lookup on average",
      "Representing only hierarchical data",
      "Executing recursion",
    ],
    correctOptionIndex: 1,
    explanation: "Hash tables typically support average constant-time lookup, insertion and deletion.",
  ),
  InterviewQuestion(
    id: 63,
    category: "Programming",
    difficulty: "Beginner",
    question: "What is a linked list node commonly made of?",
    answer: "Data and a reference to another node",
    options: [
      "Only a sorted index",
      "Data and a reference to another node",
      "A database table and query",
      "A fixed-size matrix only",
    ],
    correctOptionIndex: 1,
    explanation:
        "A singly linked node stores data and a link to the next node.",
  ),
  InterviewQuestion(
    id: 64,
    category: "Programming",
    difficulty: "Intermediate",
    question:
        "Which traversal visits root, then left subtree, then right subtree?",
    answer: "Preorder",
    options: ["Inorder", "Postorder", "Preorder", "Level order"],
    correctOptionIndex: 2,
    explanation: "Preorder traversal order is root, left, right.",
  ),
  InterviewQuestion(
    id: 65,
    category: "Programming",
    difficulty: "Advanced",
    question:
        "Which traversal of a binary search tree visits keys in sorted order?",
    answer: "Inorder",
    options: ["Preorder", "Inorder", "Postorder", "Random order"],
    correctOptionIndex: 1,
    explanation:
        "Inorder traversal visits left subtree, root, then right subtree.",
  ),
  InterviewQuestion(
    id: 66,
    category: "Programming",
    difficulty: "Beginner",
    question: "What is a graph?",
    answer: "A collection of vertices connected by edges",
    options: [
      "A sorted array only",
      "A collection of vertices connected by edges",
      "A stack with two tops",
      "A single numeric value",
    ],
    correctOptionIndex: 1,
    explanation: "Graphs model relationships or connections between entities.",
  ),
  InterviewQuestion(
    id: 67,
    category: "Programming",
    difficulty: "Intermediate",
    question: "Which algorithm finds shortest paths in an unweighted graph?",
    answer: "Breadth-first search",
    options: [
      "Depth-first search always",
      "Breadth-first search",
      "Binary search",
      "Quicksort",
    ],
    correctOptionIndex: 1,
    explanation: "BFS explores vertices by distance in an unweighted graph.",
  ),
  InterviewQuestion(
    id: 68,
    category: "Programming",
    difficulty: "Advanced",
    question: "What is the purpose of a hash function?",
    answer: "Map a key to a hash value or bucket location",
    options: [
      "Sort a list alphabetically",
      "Map a key to a hash value or bucket location",
      "Compress every file losslessly",
      "Guarantee no collisions",
    ],
    correctOptionIndex: 1,
    explanation: "Hash functions help determine where a key is stored; collisions are still possible.",
  ),
  InterviewQuestion(
    id: 69,
    category: "Programming",
    difficulty: "Beginner",
    question: "What is a collision in hashing?",
    answer: "Two different keys map to the same hash location",
    options: [
      "A program syntax error",
      "Two different keys map to the same hash location",
      "A successful binary search",
      "A queue becoming empty",
    ],
    correctOptionIndex: 1,
    explanation:
        "Collision handling methods include chaining and open addressing.",
  ),
  InterviewQuestion(
    id: 70,
    category: "Programming",
    difficulty: "Intermediate",
    question: "What does Big-O notation describe?",
    answer: "How resource use grows with input size asymptotically",
    options: [
      "The exact runtime on every computer",
      "How resource use grows with input size asymptotically",
      "The number of source files",
      "The memory address of a variable",
    ],
    correctOptionIndex: 1,
    explanation: "Big-O expresses an upper-bound growth rate, commonly for time or space.",
  ),
  InterviewQuestion(
    id: 71,
    category: "Programming",
    difficulty: "Advanced",
    question: "What is dynamic programming commonly used for?",
    answer: "Problems with overlapping subproblems and optimal substructure",
    options: [
      "Only printing text",
      "Problems with overlapping subproblems and optimal substructure",
      "Replacing every loop",
      "Storing passwords in plain text",
    ],
    correctOptionIndex: 1,
    explanation: "Dynamic programming stores or reuses subproblem results to avoid repeated work.",
  ),
  InterviewQuestion(
    id: 72,
    category: "Programming",
    difficulty: "Beginner",
    question: "What is a greedy algorithm?",
    answer: "It chooses a locally optimal option at each step",
    options: [
      "It explores every possible solution always",
      "It chooses a locally optimal option at each step",
      "It randomly changes input",
      "It only works on strings",
    ],
    correctOptionIndex: 1,
    explanation: "Greedy methods make local choices and are correct only for suitable problem structures.",
  ),
  InterviewQuestion(
    id: 73,
    category: "Programming",
    difficulty: "Intermediate",
    question: "What is a stable sorting algorithm?",
    answer: "One that preserves the relative order of equal-key elements",
    options: [
      "One that never uses memory",
      "One that preserves the relative order of equal-key elements",
      "One that always runs in O(1)",
      "One that sorts only integers",
    ],
    correctOptionIndex: 1,
    explanation: "Stability matters when sorting records by multiple fields in sequence.",
  ),
  InterviewQuestion(
    id: 74,
    category: "Programming",
    difficulty: "Advanced",
    question: "What is the space complexity of iterative binary search?",
    answer: "O(1) auxiliary space",
    options: [
      "O(n²)",
      "O(log n) always",
      "O(1) auxiliary space",
      "O(n) auxiliary space",
    ],
    correctOptionIndex: 2,
    explanation:
        "The iterative version uses a constant number of extra variables.",
  ),
  InterviewQuestion(
    id: 75,
    category: "Programming",
    difficulty: "Beginner",
    question: "What is a queue commonly used for?",
    answer: "Scheduling work in arrival order",
    options: [
      "Finding array indexes by halving",
      "Scheduling work in arrival order",
      "Representing only parent-child relations",
      "Avoiding all memory allocation",
    ],
    correctOptionIndex: 1,
    explanation: "Queues are useful for task scheduling, buffering and breadth-first search.",
  ),
  InterviewQuestion(
    id: 76,
    category: "Programming",
    difficulty: "Intermediate",
    question: "What is a deadlock in concurrent systems?",
    answer: "Processes wait indefinitely for resources held by one another",
    options: [
      "A variable has no value",
      "Processes wait indefinitely for resources held by one another",
      "A program completes successfully",
      "A sorting algorithm finishes early",
    ],
    correctOptionIndex: 1,
    explanation: "Deadlocks can arise from circular waiting and other resource conditions.",
  ),
  InterviewQuestion(
    id: 77,
    category: "Programming",
    difficulty: "Advanced",
    question: "What is the purpose of unit testing?",
    answer: "Testing a small unit of code in isolation",
    options: [
      "Testing only the production server manually",
      "Testing a small unit of code in isolation",
      "Measuring internet speed",
      "Replacing code review completely",
    ],
    correctOptionIndex: 1,
    explanation: "Unit tests verify individual functions or components with controlled inputs.",
  ),
  InterviewQuestion(
    id: 78,
    category: "HR",
    difficulty: "Beginner",
    question: "How should you describe a weakness in an interview?",
    answer: "Choose a genuine, manageable weakness and explain how you are improving it",
    options: [
      "Say you have no weaknesses",
      "Choose a genuine, manageable weakness and explain how you are improving it",
      "Blame your previous team",
      "Avoid giving any example",
    ],
    correctOptionIndex: 1,
    explanation: "Self-awareness plus a concrete improvement plan makes the answer credible.",
  ),
  InterviewQuestion(
    id: 79,
    category: "HR",
    difficulty: "Intermediate",
    question: "How should you respond when you do not know an answer?",
    answer:
        "Be honest, explain your reasoning, and show how you would find out",
    options: [
      "Invent facts confidently",
      "Be honest, explain your reasoning, and show how you would find out",
      "Blame the interviewer",
      "End the interview",
    ],
    correctOptionIndex: 1,
    explanation: "Interviewers can value transparent reasoning and willingness to learn.",
  ),
  InterviewQuestion(
    id: 80,
    category: "HR",
    difficulty: "Advanced",
    question: "What should you do before an interview?",
    answer: "Research the company and role and prepare relevant examples",
    options: [
      "Memorize unrelated facts only",
      "Research the company and role and prepare relevant examples",
      "Avoid reading the job description",
      "Arrive without preparation",
    ],
    correctOptionIndex: 1,
    explanation:
        "Preparation helps you connect your skills to the employer’s needs.",
  ),
  InterviewQuestion(
    id: 81,
    category: "HR",
    difficulty: "Beginner",
    question: "How can you explain a project effectively?",
    answer: "Describe the problem, your role, the approach, and the result",
    options: [
      "List tools without context",
      "Describe the problem, your role, the approach, and the result",
      "Claim all team work as yours",
      "Discuss only the project title",
    ],
    correctOptionIndex: 1,
    explanation:
        "A structured explanation shows ownership, decisions and impact.",
  ),
  InterviewQuestion(
    id: 82,
    category: "HR",
    difficulty: "Intermediate",
    question: "What is a good way to handle a disagreement with a teammate?",
    answer: "Listen, discuss evidence respectfully, and work toward a shared solution",
    options: [
      "Escalate immediately without discussion",
      "Listen, discuss evidence respectfully, and work toward a shared solution",
      "Ignore the teammate permanently",
      "Insist you are always right",
    ],
    correctOptionIndex: 1,
    explanation: "Professional conflict resolution focuses on facts, listening and team outcomes.",
  ),
  InterviewQuestion(
    id: 83,
    category: "HR",
    difficulty: "Advanced",
    question: "How should you answer a question about teamwork?",
    answer: "Give a specific example of your contribution and collaboration",
    options: [
      "Say teamwork is unnecessary",
      "Give a specific example of your contribution and collaboration",
      "Describe a fictional achievement",
      "Only name your teammates",
    ],
    correctOptionIndex: 1,
    explanation:
        "Specific examples are more convincing than unsupported claims.",
  ),
  InterviewQuestion(
    id: 84,
    category: "HR",
    difficulty: "Beginner",
    question: "What does STAR stand for in behavioral interviews?",
    answer: "Situation, Task, Action, Result",
    options: [
      "Summary, Target, Answer, Review",
      "Situation, Task, Action, Result",
      "Skill, Training, Aptitude, Role",
      "Start, Test, Apply, Repeat",
    ],
    correctOptionIndex: 1,
    explanation: "STAR structures an answer around context, responsibility, actions and outcome.",
  ),
  InterviewQuestion(
    id: 85,
    category: "HR",
    difficulty: "Intermediate",
    question: "What should you do if asked about salary expectations?",
    answer: "Give a researched, reasonable range and remain open to discussing the role",
    options: [
      "Demand an arbitrary amount without context",
      "Give a researched, reasonable range and remain open to discussing the role",
      "Refuse to discuss compensation rudely",
      "Ask for the maximum before learning the role",
    ],
    correctOptionIndex: 1,
    explanation: "Market research and flexibility support a professional compensation discussion.",
  ),
  InterviewQuestion(
    id: 86,
    category: "HR",
    difficulty: "Advanced",
    question: "What is a good question to ask the interviewer?",
    answer: "Ask about team expectations, success measures, or learning opportunities",
    options: [
      "Ask nothing under any circumstances",
      "Ask about team expectations, success measures, or learning opportunities",
      "Ask for confidential company data",
      "Ask only when the company will fail",
    ],
    correctOptionIndex: 1,
    explanation: "Relevant questions demonstrate interest and help you evaluate the role.",
  ),
  InterviewQuestion(
    id: 87,
    category: "HR",
    difficulty: "Beginner",
    question: "How should you explain a gap in your resume?",
    answer:
        "Be honest and concise, and highlight relevant learning or activities",
    options: [
      "Invent employment history",
      "Be honest and concise, and highlight relevant learning or activities",
      "Hide it by changing dates",
      "Criticize every previous employer",
    ],
    correctOptionIndex: 1,
    explanation: "A factual explanation paired with readiness to contribute is usually best.",
  ),
  InterviewQuestion(
    id: 88,
    category: "HR",
    difficulty: "Intermediate",
    question: "What makes a professional introduction effective?",
    answer:
        "A concise summary of background, relevant skills, projects, and goals",
    options: [
      "A long account of unrelated personal history",
      "A concise summary of background, relevant skills, projects, and goals",
      "Only your name repeated",
      "A list of salary demands",
    ],
    correctOptionIndex: 1,
    explanation: "Keep the introduction focused on the role and your most relevant evidence.",
  ),
  InterviewQuestion(
    id: 89,
    category: "HR",
    difficulty: "Advanced",
    question: "How should you respond to constructive feedback?",
    answer: "Listen, clarify if needed, and apply it to improve",
    options: [
      "Reject it immediately",
      "Listen, clarify if needed, and apply it to improve",
      "Argue regardless of the evidence",
      "Ignore all future feedback",
    ],
    correctOptionIndex: 1,
    explanation:
        "A constructive response shows coachability and professional maturity.",
  ),
  InterviewQuestion(
    id: 90,
    category: "HR",
    difficulty: "Beginner",
    question: "What should you do if you make a mistake at work?",
    answer: "Own it, communicate appropriately, correct it, and learn from it",
    options: [
      "Hide it from everyone",
      "Own it, communicate appropriately, correct it, and learn from it",
      "Blame the newest employee",
      "Delete all project files",
    ],
    correctOptionIndex: 1,
    explanation: "Accountability and corrective action help limit impact and prevent recurrence.",
  ),
  InterviewQuestion(
    id: 91,
    category: "HR",
    difficulty: "Intermediate",
    question: "How can you demonstrate problem-solving skills?",
    answer: "Explain the problem, options considered, decision, and outcome",
    options: [
      "Say you solve everything instantly",
      "Explain the problem, options considered, decision, and outcome",
      "Only mention the problem",
      "Avoid discussing your decisions",
    ],
    correctOptionIndex: 1,
    explanation: "A clear example shows your reasoning process and impact.",
  ),
  InterviewQuestion(
    id: 92,
    category: "HR",
    difficulty: "Advanced",
    question: "What should you prioritize when describing achievements?",
    answer: "Specific outcomes and your own contribution",
    options: [
      "Vague claims with no evidence",
      "Specific outcomes and your own contribution",
      "Only team size",
      "Unrelated personal details",
    ],
    correctOptionIndex: 1,
    explanation: "Concrete outcomes make achievements easier to evaluate.",
  ),
  InterviewQuestion(
    id: 93,
    category: "HR",
    difficulty: "Beginner",
    question: "How should you handle a question that is unclear?",
    answer: "Politely ask for clarification before answering",
    options: [
      "Guess randomly",
      "Politely ask for clarification before answering",
      "Criticize the question",
      "Stay silent for the rest of the interview",
    ],
    correctOptionIndex: 1,
    explanation: "Clarifying questions help ensure your answer addresses the actual question.",
  ),
  InterviewQuestion(
    id: 94,
    category: "HR",
    difficulty: "Intermediate",
    question: "Why is punctuality important for an interview?",
    answer: "It demonstrates respect and reliability",
    options: [
      "It guarantees selection",
      "It demonstrates respect and reliability",
      "It replaces technical skills",
      "It is important only for online interviews",
    ],
    correctOptionIndex: 1,
    explanation:
        "Arriving early allows time to settle in and signals professionalism.",
  ),
  InterviewQuestion(
    id: 95,
    category: "HR",
    difficulty: "Advanced",
    question: "How should you behave in a virtual interview?",
    answer: "Test audio/video, choose a quiet setting, and communicate clearly",
    options: [
      "Keep testing the microphone during every answer",
      "Test audio/video, choose a quiet setting, and communicate clearly",
      "Join from a noisy place intentionally",
      "Ignore the interviewer’s questions",
    ],
    correctOptionIndex: 1,
    explanation: "A brief technical check reduces avoidable distractions.",
  ),
  InterviewQuestion(
    id: 96,
    category: "HR",
    difficulty: "Beginner",
    question:
        "What is a good response to “Where do you see yourself in five years?”",
    answer: "Discuss realistic growth aligned with skills and the role",
    options: [
      "Promise an unrelated career path",
      "Discuss realistic growth aligned with skills and the role",
      "Say you will leave immediately",
      "Claim you will know everything",
    ],
    correctOptionIndex: 1,
    explanation: "Show ambition while remaining realistic and connected to the opportunity.",
  ),
  InterviewQuestion(
    id: 97,
    category: "HR",
    difficulty: "Intermediate",
    question: "How should you discuss a former employer?",
    answer: "Remain professional and focus on lessons and fit",
    options: [
      "Insult individuals by name",
      "Remain professional and focus on lessons and fit",
      "Reveal confidential information",
      "Blame others for every issue",
    ],
    correctOptionIndex: 1,
    explanation: "Professional discretion reflects judgment and respect.",
  ),
  InterviewQuestion(
    id: 98,
    category: "HR",
    difficulty: "Advanced",
    question: "What does active listening involve?",
    answer: "Paying attention, clarifying, and responding to what was said",
    options: [
      "Planning your reply while ignoring the speaker",
      "Paying attention, clarifying, and responding to what was said",
      "Interrupting every sentence",
      "Repeating the same answer regardless of the question",
    ],
    correctOptionIndex: 1,
    explanation: "Active listening improves understanding and makes responses more relevant.",
  ),
  InterviewQuestion(
    id: 99,
    category: "HR",
    difficulty: "Beginner",
    question: "What should a fresher emphasize when they have limited work experience?",
    answer: "Relevant projects, coursework, skills, internships, and learning ability",
    options: [
      "Invent full-time experience",
      "Relevant projects, coursework, skills, internships, and learning ability",
      "Only school marks without context",
      "Avoid discussing projects",
    ],
    correctOptionIndex: 1,
    explanation: "Evidence from projects and learning can demonstrate readiness for an entry-level role.",
  ),
  InterviewQuestion(
    id: 100,
    category: "HR",
    difficulty: "Intermediate",
    question: "How should you close an interview?",
    answer: "Thank the interviewer and briefly reaffirm interest in the role",
    options: [
      "Leave without acknowledging anyone",
      "Thank the interviewer and briefly reaffirm interest in the role",
      "Demand an immediate offer",
      "Ask to skip all next steps",
    ],
    correctOptionIndex: 1,
    explanation: "A courteous close leaves a professional final impression.",
  ),
];

const List<Map<String, dynamic>> categories = [
  {
    'name': 'Flutter',
    'description': 'Widgets, layouts and mobile development',
    'icon': Icons.phone_android_rounded,
    'color': Color(0xFF6D8266),
  },
  {
    'name': 'Dart',
    'description': 'Language fundamentals and asynchronous code',
    'icon': Icons.code_rounded,
    'color': Color(0xFF7C5CFC),
  },
  {
    'name': 'Programming',
    'description': 'Logic, algorithms and data structures',
    'icon': Icons.terminal_rounded,
    'color': Color(0xFF536D4F),
  },
  {
    'name': 'HR',
    'description': 'Communication and behavioral interviews',
    'icon': Icons.people_alt_rounded,
    'color': Color(0xFF9A7A46),
  },
];

const List<String> resumeTasks = [
  'Add a professional summary',
  'Highlight technical skills',
  'Include relevant projects',
  'Add GitHub and LinkedIn links',
  'Check grammar and formatting',
];

class CareerPrepHome extends StatefulWidget {
  const CareerPrepHome({super.key});

  @override
  State<CareerPrepHome> createState() => _CareerPrepHomeState();
}

class _CareerPrepHomeState extends State<CareerPrepHome> {
  int selectedPage = 0;
  String selectedCategory = 'All';
  String selectedCareerTrack = 'Software Developer';
  String selectedJobRole = 'Software Developer';
  String selectedTechnology = 'Flutter';
  String selectedCompany = 'Google';
  String selectedPreparationFocus = 'Technology & programming';
  final TextEditingController _preparationTopicController =
      TextEditingController();
  final TextEditingController _careerChatController = TextEditingController();
  String careerChatReply =
      'Hi! Tell me your target role, current skill level, or interview concern. I can suggest a preparation path using the sections in this app.';
  String searchQuery = '';
  final TextEditingController _practiceSearchController =
      TextEditingController();
  int currentQuestionIndex = 0;

  String quizCategory = 'All';
  String quizDifficulty = 'All';
  int quizQuestionCount = 10;
  List<InterviewQuestion> quizQuestions = [];
  final Map<int, int> quizAnswers = {};
  bool quizFinished = false;
  bool showingQuizReview = false;
  final List<Map<String, dynamic>> quizHistory = [];

  String resumeText = '';
  String jobDescriptionText = '';
  String? uploadedResumeFileName;
  bool isExtractingResume = false;
  bool resumeAnalyzed = false;

  final Set<int> bookmarkedIds = <int>{};

  bool isLoadingBookmarks = true;
  final Set<int> answeredIds = {};
  final Set<int> missedQuestionIds = {};
  final Set<int> completedTasks = {};

  // Stores the selected option for each question.
  final Map<int, int> selectedAnswers = {};

  // Stores whether each question was answered correctly.
  final Map<int, bool> answerResults = {};

  List<InterviewQuestion> get filteredQuestions {
    return questionBank.where((question) {
      final matchesCategory =
          selectedCategory == 'All' || question.category == selectedCategory;

      final query = searchQuery.toLowerCase();

      final matchesSearch =
          question.question.toLowerCase().contains(query) ||
          question.category.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  double get resumeProgress => completedTasks.length / resumeTasks.length;

  double get learningProgress => answeredIds.length / questionBank.length;

  void openPractice({String category = 'All'}) {
    _practiceSearchController.clear();
    setState(() {
      selectedPage = 1;
      selectedCategory = category;
      currentQuestionIndex = 0;
      searchQuery = '';
    });
  }

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();

    final savedIds = prefs.getStringList('bookmarked_question_ids') ?? [];

    if (!mounted) {
      return;
    }

    setState(() {
      bookmarkedIds
        ..clear()
        ..addAll(savedIds.map((id) => int.parse(id)));

      isLoadingBookmarks = false;
    });
  }

  Future<void> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();

    final savedAnsweredIds = prefs.getStringList('answered_question_ids') ?? [];

    final savedCompletedTasks =
        prefs.getStringList('completed_resume_tasks') ?? [];
    final savedMissedIds = prefs.getStringList('missed_question_ids') ?? [];

    if (!mounted) {
      return;
    }

    setState(() {
      answeredIds
        ..clear()
        ..addAll(savedAnsweredIds.map(int.parse));

      completedTasks
        ..clear()
        ..addAll(savedCompletedTasks.map(int.parse));

      missedQuestionIds
        ..clear()
        ..addAll(savedMissedIds.map(int.parse));
    });
  }

  Future<void> toggleBookmark(int id) async {
    final wasBookmarked = bookmarkedIds.contains(id);

    setState(() {
      if (wasBookmarked) {
        bookmarkedIds.remove(id);
      } else {
        bookmarkedIds.add(id);
      }
    });

    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setStringList(
        'bookmarked_question_ids',
        bookmarkedIds.map((id) => id.toString()).toList(),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not save your bookmark. Please try again.'),
        ),
      );
    }
  }

  Future<void> loadQuizHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('quiz_history') ?? [];
    final loaded = <Map<String, dynamic>>[];
    for (final item in saved) {
      try {
        final decoded = jsonDecode(item);
        if (decoded is Map<String, dynamic>) loaded.add(decoded);
      } catch (_) {
        // Ignore a damaged history entry and keep the remaining records.
      }
    }
    if (!mounted) {
      return;
    }
    setState(() {
      quizHistory
        ..clear()
        ..addAll(loaded);
    });
  }

  Future<void> _saveQuizAttempt() async {
    final total = quizQuestions.length;
    if (total == 0) {
      return;
    }
    final record = <String, dynamic>{
      'date': DateTime.now().toIso8601String(),
      'category': quizCategory == 'Revision' ? 'Revision' : quizCategory,
      'difficulty': quizDifficulty,
      'total': total,
      'correct': _quizCorrectCount,
      'incorrect': _quizIncorrectCount,
      'unanswered': _quizUnansweredCount,
      'percentage': (_quizCorrectCount / total * 100).round(),
    };
    quizHistory.insert(0, record);
    if (quizHistory.length > 100) {
      quizHistory.removeRange(100, quizHistory.length);
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        'quiz_history',
        quizHistory.map((item) => jsonEncode(item)).toList(),
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Quiz completed, but history could not be saved.'),
          ),
        );
      }
    }
  }

  void _showQuizHistory() {
    setState(() {
      showingQuizReview = false;
      quizQuestions = [];
      quizFinished = false;
    });
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        final attempts = quizHistory;
        final average = attempts.isEmpty
            ? 0
            : (attempts.fold<int>(
                        0,
                        (sum, item) => sum + (item['percentage'] as int? ?? 0),
                      ) /
                      attempts.length)
                  .round();
        final best = attempts.isEmpty
            ? 0
            : attempts
                  .map((item) => item['percentage'] as int? ?? 0)
                  .reduce((a, b) => a > b ? a : b);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: MediaQuery.of(sheetContext).size.height * 0.78,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quiz history & analytics',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${attempts.length} completed quiz${attempts.length == 1 ? '' : 'zes'} saved',
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _quizResultStat(
                          'Average',
                          average,
                          const Color(0xFF536D4F),
                          110,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _quizResultStat(
                          'Best score',
                          best,
                          const Color(0xFF536D4F),
                          110,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (attempts.isEmpty)
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Complete a quiz to start building your history.',
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.separated(
                        itemCount: attempts.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (_, index) {
                          final item = attempts[index];
                          final date = DateTime.tryParse(
                            item['date'] as String? ?? '',
                          )?.toLocal();
                          final dateText = date == null
                              ? 'Date unavailable'
                              : '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} · ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text('${item['percentage'] ?? 0}%'),
                              ),
                              title: Text(
                                '${item['category'] ?? 'All'} · ${item['difficulty'] ?? 'All'}',
                              ),
                              subtitle: Text(
                                '$dateText\n${item['correct'] ?? 0}/${item['total'] ?? 0} correct · ${item['incorrect'] ?? 0} incorrect · ${item['unanswered'] ?? 0} unanswered',
                              ),
                              isThreeLine: true,
                            ),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (attempts.isNotEmpty)
                        TextButton.icon(
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: sheetContext,
                              builder: (dialogContext) => AlertDialog(
                                title: const Text('Clear quiz history?'),
                                content: const Text(
                                  'This will permanently remove saved quiz attempts.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext, false),
                                    child: const Text('Cancel'),
                                  ),
                                  FilledButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext, true),
                                    child: const Text('Clear history'),
                                  ),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.remove('quiz_history');
                              if (mounted) setState(() => quizHistory.clear());
                              if (sheetContext.mounted) {
                                Navigator.pop(sheetContext);
                              }
                            }
                          },
                          icon: const Icon(Icons.delete_outline),
                          label: const Text('Clear history'),
                        ),
                      const Spacer(),
                      FilledButton(
                        onPressed: () => Navigator.pop(sheetContext),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadBookmarks();
    loadProgress();
    loadQuizHistory();
  }

  Future<void> toggleTask(int index) async {
    setState(() {
      if (completedTasks.contains(index)) {
        completedTasks.remove(index);
      } else {
        completedTasks.add(index);
      }
    });

    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
      'completed_resume_tasks',
      completedTasks.map((index) => index.toString()).toList(),
    );
  }

  Future<void> markAnswered(int id) async {
    if (answeredIds.contains(id)) return;

    setState(() {
      answeredIds.add(id);
    });

    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
      'answered_question_ids',
      answeredIds.map((id) => id.toString()).toList(),
    );
  }

  void selectAnswer(InterviewQuestion question, int optionIndex) {
    // Prevent changing an answer after submission.
    if (selectedAnswers.containsKey(question.id)) return;

    final isCorrect = optionIndex == question.correctOptionIndex;

    setState(() {
      selectedAnswers[question.id] = optionIndex;
      answerResults[question.id] = isCorrect;
      if (isCorrect) {
        missedQuestionIds.remove(question.id);
      } else {
        missedQuestionIds.add(question.id);
      }
    });

    markAnswered(question.id);
    SharedPreferences.getInstance().then(
      (prefs) => prefs.setStringList(
        'missed_question_ids',
        missedQuestionIds.map((id) => id.toString()).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _practiceSearchController.dispose();
    _careerChatController.dispose();
    _preparationTopicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 850;

        return Scaffold(
          body: Row(
            children: [
              if (isDesktop) _buildSidebar(),
              Expanded(
                child: Column(
                  children: [
                    _buildTopBar(isDesktop),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 36 : 18,
                          vertical: 24,
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1200),
                            child: _buildPage(isDesktop),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: isDesktop
              ? null
              : NavigationBar(
                  selectedIndex: selectedPage.clamp(0, 5),
                  onDestinationSelected: (index) {
                    _practiceSearchController.clear();
                    setState(() {
                      selectedPage = index;
                      selectedCategory = 'All';
                      searchQuery = '';
                    });
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home_rounded),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.quiz_outlined),
                      selectedIcon: Icon(Icons.quiz_rounded),
                      label: 'Practice',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.bookmark_border_rounded),
                      selectedIcon: Icon(Icons.bookmark_rounded),
                      label: 'Saved',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.insights_outlined),
                      selectedIcon: Icon(Icons.insights_rounded),
                      label: 'Progress',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.emoji_events_outlined),
                      selectedIcon: Icon(Icons.emoji_events_rounded),
                      label: 'Quiz',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.description_outlined),
                      selectedIcon: Icon(Icons.description_rounded),
                      label: 'Resume',
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 258,
      decoration: const BoxDecoration(
        color: Color(0xFFFDFDF9),
        border: Border(right: BorderSide(color: Color(0xFFE4E5DB))),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 28, 18, 34),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(0xFF536D4F),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: const Icon(
                          Icons.rocket_launch_rounded,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 11),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CareerPrep',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              'AI CAREER COMPANION',
                              style: TextStyle(
                                fontSize: 9,
                                letterSpacing: 1.0,
                                color: Color(0xFF73786C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(22, 0, 16, 10),
                  child: Text(
                    'YOUR WORKSPACE',
                    style: TextStyle(
                      color: Color(0xFF858A7E),
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                _navItem(0, Icons.grid_view_rounded, 'Dashboard'),
                _navItem(1, Icons.code_rounded, 'Interview Practice'),
                _navItem(2, Icons.bookmark_outline_rounded, 'Bookmarks'),
                _navItem(3, Icons.insights_rounded, 'My Progress'),
                _navItem(4, Icons.emoji_events_outlined, 'Take a Quiz'),
                _navItem(5, Icons.description_outlined, 'Resume Analyzer'),
                const Padding(
                  padding: EdgeInsets.fromLTRB(22, 18, 16, 10),
                  child: Text(
                    'EXPLORE & PREPARE',
                    style: TextStyle(
                      color: Color(0xFF858A7E),
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                _navItem(6, Icons.route_outlined, 'Career Tracks'),
                _navItem(7, Icons.badge_outlined, 'Job Roles'),
                _navItem(8, Icons.business_outlined, 'Company Prep'),
                _navItem(9, Icons.memory_outlined, 'Technologies'),
                _navItem(10, Icons.fact_check_outlined, 'Assessment Center'),
                _navItem(
                  11,
                  Icons.chat_bubble_outline_rounded,
                  'Career Chatbot',
                ),
                const SizedBox(height: 18),
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4EE),
                    border: Border.all(color: const Color(0xFFE0E4D9)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.lightbulb_outline_rounded,
                        color: Color(0xFFDDE7D5),
                        size: 28,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Small steps, big careers.',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Practice consistently and build confidence.',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.5,
                          color: Color(0xFF73786C),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    final selected = selectedPage == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: Material(
        color: selected ? const Color(0xFFE8EEE3) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            setState(() {
              selectedPage = index;
              selectedCategory = 'All';
              searchQuery = '';
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 14),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 21,
                  color: selected
                      ? const Color(0xFF536D4F)
                      : const Color(0xFF73786C),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 13,
                      color: selected
                          ? const Color(0xFF536D4F)
                          : const Color(0xFF454A40),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(bool isDesktop) {
    return Container(
      height: 72,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 32 : 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE4E5DB))),
      ),
      child: Row(
        children: [
          if (!isDesktop)
            Container(
              width: 39,
              height: 39,
              decoration: BoxDecoration(
                color: const Color(0xFF536D4F),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.rocket_launch_rounded,
                color: Colors.white,
              ),
            ),
          if (!isDesktop) const SizedBox(width: 10),
          Expanded(
            child: Text(
              [
                'Dashboard',
                'Interview Practice',
                'Saved Questions',
                'My Progress',
                'Take a Quiz',
                'Resume Analyzer',
                'Career Tracks',
                'Job Roles',
                'Company Preparation',
                'Technologies',
                'Assessment Center',
                'Career Chatbot',
              ][selectedPage.clamp(0, 11)],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
          ),
          const Icon(
            Icons.auto_awesome_rounded,
            size: 20,
            color: Color(0xFF536D4F),
          ),
          const SizedBox(width: 8),
          const Text(
            'Your career, your pace',
            style: TextStyle(color: Color(0xFF73786C), fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(bool isDesktop) {
    switch (selectedPage) {
      case 1:
        return _buildPracticePage(isDesktop);
      case 2:
        return _buildBookmarksPage();
      case 3:
        return _buildProgressPage(isDesktop);
      case 4:
        return _buildQuizPage();
      case 5:
        return _buildResumeAnalyzerPage(isDesktop);
      case 6:
        return _buildCareerTracksPage(isDesktop);
      case 7:
        return _buildJobRolesPage(isDesktop);
      case 8:
        return _buildCompanyPrepPage(isDesktop);
      case 9:
        return _buildTechnologiesPage(isDesktop);
      case 10:
        return _buildAssessmentCenterPage(isDesktop);
      case 11:
        return _buildCareerChatbotPage(isDesktop);
      default:
        return _buildDashboard(isDesktop);
    }
  }

  Widget _buildExploreGrid(bool isDesktop) {
    final items = <Map<String, dynamic>>[
      {
        'title': 'Career Tracks',
        'subtitle': 'Follow a role-based roadmap',
        'icon': Icons.route_rounded,
        'page': 6,
      },
      {
        'title': 'Job Roles',
        'subtitle': 'Explore skills for different careers',
        'icon': Icons.badge_outlined,
        'page': 7,
      },
      {
        'title': 'Company Prep',
        'subtitle': 'Plan company-focused preparation',
        'icon': Icons.business_outlined,
        'page': 8,
      },
      {
        'title': 'Technologies',
        'subtitle': 'Choose a language or tech stack',
        'icon': Icons.memory_rounded,
        'page': 9,
      },
      {
        'title': 'Assessment Center',
        'subtitle': 'Practice quizzes and test skills',
        'icon': Icons.fact_check_outlined,
        'page': 10,
      },
      {
        'title': 'Career Chatbot',
        'subtitle': 'Get a guided next-step suggestion',
        'icon': Icons.chat_bubble_outline_rounded,
        'page': 11,
      },
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 3 : 1,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        mainAxisExtent: 112,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => setState(() => selectedPage = item['page'] as int),
          child: Container(
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE4E5DB)),
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8EEE3),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: const Color(0xFF536D4F),
                  ),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item['title'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item['subtitle'] as String,
                        style: const TextStyle(
                          color: Color(0xFF73786C),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 18,
                  color: Color(0xFF73786C),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _pageIntro(String title, String subtitle, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF536D4F), Color(0xFF40563D)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFF536D4F),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: Colors.white, size: 27),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFFD4D9E7),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _choiceCards({
    required List<Map<String, String>> choices,
    required String selected,
    required ValueChanged<String> onSelect,
    required bool isDesktop,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: choices.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 3 : 1,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        mainAxisExtent: 132,
      ),
      itemBuilder: (context, index) {
        final choice = choices[index];
        final name = choice['name']!;
        final active = selected == name;
        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => onSelect(name),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: active ? const Color(0xFFE8EEE3) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: active
                    ? const Color(0xFF536D4F)
                    : const Color(0xFFE4E5DB),
                width: active ? 1.5 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    if (active)
                      const Icon(
                        Icons.check_circle_rounded,
                        color: Color(0xFF536D4F),
                        size: 19,
                      ),
                  ],
                ),
                const SizedBox(height: 9),
                Expanded(
                  child: Text(
                    choice['description'] ?? '',
                    style: const TextStyle(
                      color: Color(0xFF73786C),
                      fontSize: 12,
                      height: 1.45,
                    ),
                  ),
                ),
                Text(
                  choice['tag'] ?? 'Explore',
                  style: const TextStyle(
                    color: Color(0xFF536D4F),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCareerTracksPage(bool isDesktop) {
    final tracks = [
      {
        'name': 'Software Developer',
        'description': 'Programming fundamentals, DSA, projects, and technical interviews.',
        'tag': 'Coding + problem solving',
      },
      {
        'name': 'Frontend Developer',
        'description': 'HTML, CSS, JavaScript, UI frameworks, accessibility, and web projects.',
        'tag': 'Web development',
      },
      {
        'name': 'Backend Developer',
        'description': 'APIs, databases, authentication, system basics, and server-side design.',
        'tag': 'APIs + databases',
      },
      {
        'name': 'Data Analyst',
        'description': 'SQL, spreadsheets, statistics, dashboards, and communicating insights.',
        'tag': 'Data + analytics',
      },
      {
        'name': 'AI / ML Engineer',
        'description': 'Python, data preparation, model evaluation, ML concepts, and deployment basics.',
        'tag': 'AI + machine learning',
      },
      {
        'name': 'QA / Test Engineer',
        'description': 'Test design, bug reports, automation concepts, and quality workflows.',
        'tag': 'Testing',
      },
      {
        'name': 'Cloud / DevOps',
        'description': 'Linux, networking, cloud concepts, CI/CD, containers, and monitoring.',
        'tag': 'Cloud + operations',
      },
      {
        'name': 'Cybersecurity Analyst',
        'description': 'Networking, security fundamentals, risk awareness, and defensive practices.',
        'tag': 'Security fundamentals',
      },
      {
        'name': 'Mobile App Developer',
        'description': 'Mobile UI, app state, APIs, storage, testing, and publishing workflows.',
        'tag': 'Android / iOS',
      },
    ];
    final selected = tracks.firstWhere(
      (e) => e['name'] == selectedCareerTrack,
      orElse: () => tracks.first,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _pageIntro(
          'Choose your career track',
          'Select a direction to see a starter roadmap. You can change tracks whenever your goals change.',
          Icons.route_rounded,
        ),
        const SizedBox(height: 24),
        _choiceCards(
          choices: tracks,
          selected: selectedCareerTrack,
          onSelect: (v) => setState(() => selectedCareerTrack = v),
          isDesktop: isDesktop,
        ),
        const SizedBox(height: 22),
        _sectionHeading(
          'Your starter roadmap',
          'A practical sequence for ${selected['name']}.',
        ),
        const SizedBox(height: 14),
        _roadmapCard([
          'Review the core concepts and vocabulary',
          'Practice beginner tasks and explain your reasoning',
          'Build one small project that demonstrates the skills',
          'Complete timed questions and review mistakes',
          'Prepare project stories and role-specific interview answers',
        ]),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: () => openPractice(category: 'All'),
          icon: const Icon(Icons.play_arrow_rounded),
          label: const Text('Start with available practice questions'),
        ),
        const SizedBox(height: 10),
        const Text(
          'This is a starter roadmap, not a guarantee of hiring requirements. Tailor it to the job description you are targeting.',
          style: TextStyle(color: Color(0xFF73786C), fontSize: 12),
        ),
      ],
    );
  }

  Widget _roadmapCard(List<String> steps) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFE4E5DB)),
    ),
    child: Column(
      children: [
        for (int i = 0; i < steps.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: i == steps.length - 1 ? 0 : 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: const Color(0xFFE8EEE3),
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(
                      color: Color(0xFF536D4F),
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(steps[i], style: const TextStyle(height: 1.4)),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );

  Widget _buildJobRolesPage(bool isDesktop) {
    final roles = [
      {
        'name': 'Software Engineer',
        'description':
            'DSA, programming fundamentals, OOP, projects, and debugging.',
        'tag': 'Technical interview',
      },
      {
        'name': 'Frontend Engineer',
        'description': 'JavaScript, browser basics, UI frameworks, CSS, and accessibility.',
        'tag': 'Web',
      },
      {
        'name': 'Backend Engineer',
        'description':
            'REST APIs, databases, authentication, caching, and reliability.',
        'tag': 'Backend',
      },
      {
        'name': 'Data Analyst',
        'description': 'SQL, statistics, data cleaning, visualization, and business reasoning.',
        'tag': 'Data',
      },
      {
        'name': 'ML Engineer',
        'description': 'Python, ML fundamentals, evaluation, data pipelines, and deployment.',
        'tag': 'AI / ML',
      },
      {
        'name': 'QA Engineer',
        'description': 'Test cases, regression, bug lifecycle, automation, and edge cases.',
        'tag': 'Quality',
      },
      {
        'name': 'Product / Business Analyst',
        'description': 'Requirements, stakeholder communication, metrics, and structured problem solving.',
        'tag': 'Business',
      },
      {
        'name': 'Technical Support',
        'description': 'Troubleshooting, networking basics, customer communication, and documentation.',
        'tag': 'Support',
      },
      {
        'name': 'Mobile Developer',
        'description': 'App architecture, state, API integration, local storage, and app testing.',
        'tag': 'Mobile',
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _pageIntro(
          'Explore job roles',
          'Compare the kinds of skills commonly associated with a role before you start preparing.',
          Icons.badge_outlined,
        ),
        const SizedBox(height: 24),
        _choiceCards(
          choices: roles,
          selected: selectedJobRole,
          onSelect: (v) => setState(() => selectedJobRole = v),
          isDesktop: isDesktop,
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE4E5DB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selected role: $selectedJobRole',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Next steps',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              const Text(
                '1. Compare the role with a real job description.\n2. Identify skills you already have and skills to learn.\n3. Practice relevant questions and prepare project examples.',
                style: TextStyle(height: 1.6, color: Color(0xFF73786C)),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    onPressed: () => setState(() => selectedPage = 6),
                    icon: const Icon(Icons.route_rounded),
                    label: const Text('View career tracks'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => setState(() => selectedPage = 5),
                    icon: const Icon(Icons.description_outlined),
                    label: const Text('Match a job description'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyPrepPage(bool isDesktop) {
    final companies = [
      {
        'name': 'Google',
        'description': 'Use the role description to plan coding, problem-solving, and behavioral preparation.',
        'tag': 'Example employer',
      },
      {
        'name': 'Microsoft',
        'description': 'Review fundamentals, coding practice, collaboration stories, and role-specific skills.',
        'tag': 'Example employer',
      },
      {
        'name': 'Amazon',
        'description': 'Prepare technical fundamentals and concise examples of ownership and decision-making.',
        'tag': 'Example employer',
      },
      {
        'name': 'TCS',
        'description': 'Check the specific hiring process and prepare aptitude, programming, and communication as applicable.',
        'tag': 'Example employer',
      },
      {
        'name': 'Infosys',
        'description': 'Use the official role details to guide aptitude, coding, and interview practice.',
        'tag': 'Example employer',
      },
      {
        'name': 'Accenture',
        'description': 'Review role requirements and prepare assessment, communication, and technical fundamentals as applicable.',
        'tag': 'Example employer',
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _pageIntro(
          'Company preparation',
          'Choose an example employer and build a preparation checklist around its actual job description.',
          Icons.business_outlined,
        ),
        const SizedBox(height: 24),
        _choiceCards(
          choices: companies,
          selected: selectedCompany,
          onSelect: (v) => setState(() => selectedCompany = v),
          isDesktop: isDesktop,
        ),
        const SizedBox(height: 20),
        _sectionHeading(
          '$selectedCompany preparation checklist',
          'General guidance only—interview rounds and questions vary by role, team, location, and hiring cycle.',
        ),
        const SizedBox(height: 14),
        _roadmapCard([
          'Find the current official job posting and eligibility criteria',
          'Highlight required skills and tools from the job description',
          'Practice relevant coding, aptitude, or role tasks',
          'Prepare two project explanations and behavioral examples',
          'Verify the current interview process from official recruitment communications',
        ]),
        const SizedBox(height: 14),
        const Text(
          'This section does not claim to contain verified or leaked company interview questions. Use current official recruitment information to confirm requirements.',
          style: TextStyle(color: Color(0xFF73786C), fontSize: 12, height: 1.5),
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: () => setState(() => selectedPage = 5),
          icon: const Icon(Icons.description_outlined),
          label: const Text('Analyze a job description'),
        ),
      ],
    );
  }

  Widget _buildTechnologiesPage(bool isDesktop) {
    final technologies = [
      {
        'name': 'Flutter',
        'description':
            'Widgets, state, navigation, async, testing, and app architecture.',
        'tag': 'Mobile UI',
      },
      {
        'name': 'Dart',
        'description':
            'Types, collections, null safety, OOP, Futures, and Streams.',
        'tag': 'Language',
      },
      {
        'name': 'Python',
        'description': 'Core syntax, collections, functions, OOP, files, and problem solving.',
        'tag': 'Language',
      },
      {
        'name': 'Java',
        'description':
            'OOP, collections, exceptions, JVM basics, and coding problems.',
        'tag': 'Language',
      },
      {
        'name': 'C++',
        'description':
            'STL, pointers/references, OOP, complexity, and DSA practice.',
        'tag': 'Language',
      },
      {
        'name': 'JavaScript',
        'description': 'Scope, closures, promises, DOM, async patterns, and browser concepts.',
        'tag': 'Web',
      },
      {
        'name': 'React',
        'description':
            'Components, props/state, hooks, rendering, and frontend patterns.',
        'tag': 'Framework',
      },
      {
        'name': 'HTML & CSS',
        'description':
            'Semantic markup, layout, responsive design, and accessibility.',
        'tag': 'Web',
      },
      {
        'name': 'SQL / Databases',
        'description': 'Queries, joins, grouping, normalization, and indexes.',
        'tag': 'Data',
      },
      {
        'name': 'Git & GitHub',
        'description':
            'Commits, branches, pull/push, merge conflicts, and collaboration.',
        'tag': 'Tools',
      },
      {
        'name': 'REST APIs',
        'description': 'HTTP methods, status codes, JSON, authentication, and error handling.',
        'tag': 'Backend',
      },
      {
        'name': 'Machine Learning',
        'description':
            'Data preparation, train/test split, evaluation, and model basics.',
        'tag': 'AI / ML',
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _pageIntro(
          'Technologies & subjects',
          'Pick the language, framework, or technical subject you want to focus on.',
          Icons.memory_rounded,
        ),
        const SizedBox(height: 24),
        _choiceCards(
          choices: technologies,
          selected: selectedTechnology,
          onSelect: (v) => setState(() => selectedTechnology = v),
          isDesktop: isDesktop,
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE4E5DB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Study plan: $selectedTechnology',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Suggested order',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              const Text(
                'Concepts → short examples → hands-on practice → interview questions → revision of mistakes.',
                style: TextStyle(height: 1.5, color: Color(0xFF73786C)),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    onPressed: () => openPractice(category: 'All'),
                    icon: const Icon(Icons.quiz_outlined),
                    label: const Text('Open question practice'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => setState(() => selectedPage = 10),
                    icon: const Icon(Icons.fact_check_outlined),
                    label: const Text('Go to assessments'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'The existing question bank currently contains Flutter, Dart, Programming, and HR questions. Other technology cards provide a study direction; they do not imply that a full dedicated question bank already exists for every technology.',
          style: TextStyle(color: Color(0xFF73786C), fontSize: 12, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildAssessmentCenterPage(bool isDesktop) {
    final tests = [
      {
        'name': 'Technical Quiz',
        'description':
            'Practice from the current question bank and review your answers.',
        'tag': 'Available now',
      },
      {
        'name': 'Programming Fundamentals',
        'description': 'Review general programming and data-structure concepts in the current bank.',
        'tag': 'Available now',
      },
      {
        'name': 'Flutter & Dart',
        'description': 'Practice the existing Flutter and Dart questions.',
        'tag': 'Available now',
      },
      {
        'name': 'HR & Behavioral',
        'description': 'Prepare introductions, teamwork, project explanations, and interview situations.',
        'tag': 'Available now',
      },
      {
        'name': 'Aptitude Assessment',
        'description': 'A dedicated numerical, logical, and verbal question bank can be added as a separate module.',
        'tag': 'Expansion area',
      },
      {
        'name': 'Role-specific Mock Test',
        'description': 'Build timed assessments from the selected role and required skills.',
        'tag': 'Expansion area',
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _pageIntro(
          'Assessment center',
          'Choose a test type, practice under a clear goal, and review your results.',
          Icons.fact_check_outlined,
        ),
        const SizedBox(height: 24),
        _choiceCards(
          choices: tests,
          selected: 'Technical Quiz',
          onSelect: (v) {
            if (v == 'Technical Quiz' ||
                v == 'Programming Fundamentals' ||
                v == 'Flutter & Dart' ||
                v == 'HR & Behavioral') {
              setState(() {
                selectedPage = 4;
                quizCategory = v == 'Flutter & Dart'
                    ? 'Flutter'
                    : v == 'HR & Behavioral'
                    ? 'HR'
                    : v == 'Programming Fundamentals'
                    ? 'Programming'
                    : 'All';
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '$v is identified as a future module; it is not implemented as a dedicated test yet.',
                  ),
                ),
              );
            }
          },
          isDesktop: isDesktop,
        ),
        const SizedBox(height: 18),
        const Text(
          'Available-now cards open the current quiz engine. Aptitude-specific and fully role-generated tests are listed transparently as future expansion areas, not as completed features.',
          style: TextStyle(color: Color(0xFF73786C), fontSize: 12, height: 1.5),
        ),
      ],
    );
  }

  void _sendCareerChat() {
    final message = _careerChatController.text.trim();
    if (message.isEmpty) return;
    final text = message.toLowerCase();
    String reply;
    if (text.contains('resume') ||
        text.contains('cv') ||
        text.contains('ats')) {
      reply = 'Start in Resume Analyzer: upload your PDF, add the target job description, review matched and missing skills, then tailor your resume truthfully to the role.';
    } else if (text.contains('company') ||
        text.contains('google') ||
        text.contains('amazon') ||
        text.contains('tcs') ||
        text.contains('infosys') ||
        text.contains('microsoft')) {
      reply = 'Open Company Prep, choose an example employer, then use its checklist alongside the current official job posting. This starter guide does not contain verified company-specific questions.';
    } else if (text.contains('python') ||
        text.contains('java') ||
        text.contains('flutter') ||
        text.contains('react') ||
        text.contains('technology') ||
        text.contains('language')) {
      reply = 'Open Technologies and select the technology. Study concepts first, practice examples, then use the current question bank. Dedicated banks for every listed technology still need to be added.';
    } else if (text.contains('role') ||
        text.contains('career') ||
        text.contains('job')) {
      reply = 'Start with Job Roles to compare typical skills, then choose a Career Track and review its roadmap. Bring a real job description into Resume Analyzer to personalize the plan.';
    } else if (text.contains('test') ||
        text.contains('quiz') ||
        text.contains('assessment') ||
        text.contains('aptitude')) {
      reply = 'Open Assessment Center for the currently available Flutter, Dart, Programming, and HR quizzes. Dedicated aptitude and role-generated tests are future modules.';
    } else if (text.contains('beginner') ||
        text.contains('start') ||
        text.contains('learn')) {
      reply = 'A good beginner path is: choose one target role, learn its core skills, build a small project, practice a few questions daily, and review mistakes. Use Career Tracks to get started.';
    } else {
      reply = 'Try asking about choosing a job role, preparing for a company, learning a technology, improving a resume, or starting a quiz. I am an offline starter guide right now, not a connected generative AI service.';
    }
    setState(() {
      careerChatReply = reply;
      _careerChatController.clear();
    });
  }

  Widget _buildCareerChatbotPage(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _pageIntro(
          'Career guide',
          'Ask where to begin. This first version uses local guidance rules and works without an API key.',
          Icons.chat_bubble_outline_rounded,
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE4E5DB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFFE8EEE3),
                    child: Icon(
                      Icons.auto_awesome_rounded,
                      color: Color(0xFF536D4F),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CareerPrep Guide',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Offline starter assistant',
                          style: TextStyle(
                            color: Color(0xFF73786C),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                'What would you like help with?',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    [
                          'Choose a job role',
                          'Prepare for a company',
                          'Learn Python',
                          'Improve my resume',
                          'Practice a test',
                        ]
                        .map(
                          (prompt) => ActionChip(
                            label: Text(prompt),
                            onPressed: () {
                              _careerChatController.text = prompt;
                              _sendCareerChat();
                            },
                          ),
                        )
                        .toList(),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: _careerChatController,
                onSubmitted: (_) => _sendCareerChat(),
                minLines: 1,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'e.g. I am a beginner aiming for a software developer role',
                  suffixIcon: IconButton(
                    onPressed: _sendCareerChat,
                    icon: const Icon(Icons.send_rounded),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F3),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SUGGESTED NEXT STEP',
                      style: TextStyle(
                        color: Color(0xFF536D4F),
                        fontWeight: FontWeight.w800,
                        fontSize: 10,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(careerChatReply, style: const TextStyle(height: 1.55)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'An API-connected AI chatbot, chat history, and personalized plans based on a user profile are not implemented in this starter version.',
          style: TextStyle(color: Color(0xFF73786C), fontSize: 12, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildDashboard(bool isDesktop) {
    final subjectSummaries = <Map<String, dynamic>>[
      {
        'title': 'Flutter',
        'subtitle': 'Widgets, layouts, state, navigation, lifecycle and app architecture.',
        'icon': Icons.phone_android_rounded,
        'page': 9,
      },
      {
        'title': 'Dart',
        'subtitle': 'Types, null safety, collections, OOP, Futures and asynchronous code.',
        'icon': Icons.code_rounded,
        'page': 9,
      },
      {
        'title': 'Programming & DSA',
        'subtitle': 'Complexity, data structures, algorithms, recursion and problem-solving.',
        'icon': Icons.account_tree_outlined,
        'page': 1,
      },
      {
        'title': 'HR & Behavioural',
        'subtitle': 'Self-introduction, STAR answers, teamwork, strengths and interview etiquette.',
        'icon': Icons.forum_outlined,
        'page': 1,
      },
      {
        'title': 'Resume & Job Matching',
        'subtitle': 'Extract resume text, compare it with a job description and identify skill gaps.',
        'icon': Icons.description_outlined,
        'page': 5,
      },
      {
        'title': 'Assessments & Revision',
        'subtitle': 'Take quizzes, review answers, bookmark questions and track attempts.',
        'icon': Icons.fact_check_outlined,
        'page': 10,
      },
    ];

    final roleSummaries = <Map<String, dynamic>>[
      {
        'title': 'Software Developer',
        'subtitle': 'Programming, DSA, OOP, projects and debugging.',
      },
      {
        'title': 'Frontend Developer',
        'subtitle': 'HTML, CSS, JavaScript, React, UI and accessibility.',
      },
      {
        'title': 'Backend Developer',
        'subtitle': 'APIs, databases, authentication and server-side basics.',
      },
      {
        'title': 'Data Analyst',
        'subtitle': 'SQL, data cleaning, statistics and visualisation.',
      },
      {
        'title': 'AI / ML Engineer',
        'subtitle': 'Python, datasets, model evaluation and ML fundamentals.',
      },
      {
        'title': 'QA / Test Engineer',
        'subtitle':
            'Test cases, bug reports, regression and automation basics.',
      },
      {
        'title': 'Mobile Developer',
        'subtitle': 'App UI, state management, APIs, storage and testing.',
      },
      {
        'title': 'Cloud / DevOps & Security',
        'subtitle':
            'Linux, networking, CI/CD, cloud and defensive security basics.',
      },
    ];

    final companySummaries = <Map<String, dynamic>>[
      {
        'title': 'Google',
        'subtitle': 'Use the target role description to guide coding and problem-solving prep.',
      },
      {
        'title': 'Microsoft',
        'subtitle': 'Review fundamentals, projects, collaboration and role-specific skills.',
      },
      {
        'title': 'Amazon',
        'subtitle': 'Practise technical fundamentals and structured behavioural examples.',
      },
      {
        'title': 'TCS',
        'subtitle': 'Check current eligibility and prepare relevant aptitude or technical topics.',
      },
      {
        'title': 'Infosys',
        'subtitle': 'Use the official job details to guide assessment and interview practice.',
      },
      {
        'title': 'Accenture',
        'subtitle': 'Review the role requirements and prepare communication and technical basics.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHero(isDesktop),
        const SizedBox(height: 22),
        _buildStats(isDesktop),
        const SizedBox(height: 34),
        _sectionHeading(
          'Welcome to your career workspace',
          'CareerPrep AI brings interview learning, career exploration and application preparation together.',
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 850
                ? 4
                : constraints.maxWidth >= 520
                ? 2
                : 1;
            final items = <Map<String, dynamic>>[
              {
                'title': 'Learn by subject',
                'description': 'Explore technology topics and practice the questions currently available in the question bank.',
                'icon': Icons.menu_book_rounded,
                'action': 'Explore technologies',
                'tap': () => setState(() => selectedPage = 9),
              },
              {
                'title': 'Practice interviews',
                'description': 'Answer questions, check explanations, save important questions and revise weak areas.',
                'icon': Icons.record_voice_over_rounded,
                'action': 'Start practice',
                'tap': () => openPractice(),
              },
              {
                'title': 'Prepare for roles',
                'description': 'Compare career tracks and understand the skills commonly associated with different roles.',
                'icon': Icons.route_rounded,
                'action': 'Explore career tracks',
                'tap': () => setState(() => selectedPage = 6),
              },
              {
                'title': 'Check your resume',
                'description': 'Extract text from a PDF resume and compare it with a job description to spot possible gaps.',
                'icon': Icons.description_outlined,
                'action': 'Open resume analyzer',
                'tap': () => setState(() => selectedPage = 5),
              },
            ];
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                mainAxisExtent: 208,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return _dashboardInfoCard(
                  title: item['title'] as String,
                  description: item['description'] as String,
                  icon: item['icon'] as IconData,
                  actionLabel: item['action'] as String,
                  onTap: item['tap'] as VoidCallback,
                );
              },
            );
          },
        ),
        const SizedBox(height: 34),
        _sectionHeading(
          'Subjects & preparation areas',
          'A quick map of what you can study on the platform. Dedicated question-bank coverage currently focuses on Flutter, Dart, Programming and HR.',
          action: 'View technologies',
          onAction: () => setState(() => selectedPage = 9),
        ),
        const SizedBox(height: 16),
        _buildDashboardSummaryGrid(
          subjectSummaries,
          onTap: (item) {
            final page = item['page'] as int;
            if (page == 1) {
              openPractice(
                category: item['title'] == 'HR & Behavioural'
                    ? 'HR'
                    : 'Programming',
              );
            } else {
              setState(() => selectedPage = page);
            }
          },
        ),
        const SizedBox(height: 34),
        _sectionHeading(
          'Career roles to explore',
          'Understand the typical skills to prepare for each path. Requirements differ between employers and job descriptions.',
          action: 'Browse job roles',
          onAction: () => setState(() => selectedPage = 7),
        ),
        const SizedBox(height: 16),
        _buildDashboardSummaryGrid(
          roleSummaries,
          onTap: (_) => setState(() => selectedPage = 7),
        ),
        const SizedBox(height: 34),
        _sectionHeading(
          'Company preparation',
          'Use these employer examples as starting points—not as a guarantee of their current hiring process or interview questions.',
          action: 'Open company prep',
          onAction: () => setState(() => selectedPage = 8),
        ),
        const SizedBox(height: 16),
        _buildDashboardSummaryGrid(
          companySummaries,
          onTap: (item) {
            setState(() {
              selectedCompany = item['title'] as String;
              selectedPage = 8;
            });
          },
        ),
        const SizedBox(height: 34),
        _sectionHeading(
          'Choose your next step',
          'Move from learning to practice, assessment and application preparation.',
        ),
        const SizedBox(height: 16),
        _buildPreparationChooser(isDesktop),
        const SizedBox(height: 34),
        _sectionHeading(
          'Explore more tools',
          'Open a focused workspace for career roadmaps, role research, company preparation, technologies and assessments.',
        ),
        const SizedBox(height: 16),
        _buildExploreGrid(isDesktop),
        const SizedBox(height: 24),
        _buildQuizPromotion(),
        const SizedBox(height: 34),
        _sectionHeading(
          'Resume readiness',
          'Use this checklist to keep your application preparation organised.',
          action: '${completedTasks.length}/${resumeTasks.length} complete',
        ),
        const SizedBox(height: 16),
        _buildResumeChecklist(),
        const SizedBox(height: 34),
        _sectionHeading(
          'Recommended practice',
          'Try a few questions, review the explanations and bookmark anything you want to revisit.',
          action: 'Practice all',
          onAction: () => openPractice(),
        ),
        const SizedBox(height: 16),
        ...questionBank.take(3).map(_buildQuestionPreview),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFE8EEE3),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFD8E1D2)),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.lightbulb_outline_rounded,
                color: Color(0xFF536D4F),
                size: 27,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'A useful workflow: choose a target role, read a current job description, identify skill gaps, study the relevant subjects, practise questions, review your progress and prepare project examples. Company processes and role requirements can change, so verify details from official recruitment information.',
                  style: TextStyle(height: 1.55, color: Color(0xFF454A40)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Center(
          child: Text(
            'CareerPrep AI • Learn with purpose. Prepare with confidence.',
            style: TextStyle(color: Color(0xFF858A7E), fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _dashboardInfoCard({
    required String title,
    required String description,
    required IconData icon,
    required String actionLabel,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE4E5DB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFE8EEE3),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: const Color(0xFF536D4F)),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFF24271F),
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 12,
                height: 1.45,
                color: Color(0xFF73786C),
              ),
            ),
          ),
          TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF536D4F),
              padding: EdgeInsets.zero,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  actionLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(Icons.arrow_forward_rounded, size: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardSummaryGrid(
    List<Map<String, dynamic>> items, {
    required ValueChanged<Map<String, dynamic>> onTap,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 950
            ? 4
            : constraints.maxWidth >= 600
            ? 3
            : 1;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 150,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            final title = item['title'] as String;
            final description = item['subtitle'] as String;
            final icons = <String, IconData>{
              'Flutter': Icons.phone_android_rounded,
              'Dart': Icons.code_rounded,
              'Programming & DSA': Icons.account_tree_outlined,
              'HR & Behavioural': Icons.forum_outlined,
              'Resume & Job Matching': Icons.description_outlined,
              'Assessments & Revision': Icons.fact_check_outlined,
            };
            return InkWell(
              onTap: () => onTap(item),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE4E5DB)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          icons[title] ?? Icons.arrow_outward_rounded,
                          size: 20,
                          color: const Color(0xFF536D4F),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_outward_rounded,
                          size: 16,
                          color: Color(0xFF92978A),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        color: Color(0xFF24271F),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      child: Text(
                        description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          height: 1.4,
                          color: Color(0xFF73786C),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHero(bool isDesktop) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isDesktop ? 34 : 23),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF536D4F), Color(0xFF40563D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Icon(
              Icons.auto_awesome_rounded,
              size: isDesktop ? 125 : 75,
              color: Colors.white.withValues(alpha: 0.13),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.17),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.waving_hand_rounded,
                      size: 15,
                      color: Colors.white,
                    ),
                    SizedBox(width: 7),
                    Text(
                      'YOUR CAREER, BUILT A STEP AT A TIME',
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 23),
              Text(
                'Build skills.\nMove your career forward.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isDesktop ? 32 : 25,
                  fontWeight: FontWeight.w800,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Prepare for the role you want, practice what matters,\nand turn your next step into a plan.',
                style: TextStyle(
                  color: Color(0xFFE8EEE3),
                  height: 1.6,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => openPractice(),
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Start practicing'),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF536D4F),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStats(bool isDesktop) {
    final stats = [
      (
        'Question bank',
        '${questionBank.length}',
        'Questions to explore',
        Icons.menu_book_rounded,
        const Color(0xFF536D4F),
      ),
      (
        'Attempted',
        '${answeredIds.length}',
        'Questions practiced',
        Icons.check_circle_outline_rounded,
        const Color(0xFF536D4F),
      ),
      (
        'Bookmarked',
        '${bookmarkedIds.length}',
        'Saved for revision',
        Icons.bookmark_outline_rounded,
        const Color(0xFF9A7A46),
      ),
      (
        'Resume tasks',
        '${completedTasks.length}/${resumeTasks.length}',
        'Checklist completed',
        Icons.description_outlined,
        const Color(0xFF6D8266),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 900
            ? 4
            : constraints.maxWidth >= 500
            ? 2
            : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: stats.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            mainAxisExtent: 120,
          ),
          itemBuilder: (context, index) {
            final stat = stats[index];

            return Container(
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE4E5DB)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: stat.$5.withValues(alpha: 0.11),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(stat.$4, color: stat.$5),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stat.$1,
                          style: const TextStyle(
                            color: Color(0xFF73786C),
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          stat.$2,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 23,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          stat.$3,
                          style: const TextStyle(
                            color: Color(0xFF858A7E),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _sectionHeading(
    String title,
    String subtitle, {
    String? action,
    VoidCallback? onAction,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Color(0xFF73786C)),
              ),
            ],
          ),
        ),
        if (action != null && onAction != null)
          TextButton(onPressed: onAction, child: Text(action))
        else if (action != null)
          Text(
            action,
            style: const TextStyle(
              color: Color(0xFF536D4F),
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
      ],
    );
  }

  Widget _buildPreparationChooser(bool isDesktop) {
    final options = <Map<String, dynamic>>[
      {
        'title': 'Languages & programming',
        'subtitle': 'Python, Java, C++, SQL, DSA and more',
        'focus': 'Technology & programming',
        'icon': Icons.code_rounded,
        'color': const Color(0xFF536D4F),
      },
      {
        'title': 'Frameworks & tools',
        'subtitle': 'Flutter, React, Spring, Git, cloud and more',
        'focus': 'Frameworks & tools',
        'icon': Icons.widgets_outlined,
        'color': const Color(0xFF536D4F),
      },
      {
        'title': 'Job roles & skills',
        'subtitle': 'Developer, analyst, designer, tester and more',
        'focus': 'Job role',
        'icon': Icons.badge_outlined,
        'color': const Color(0xFF6D8266),
      },
      {
        'title': 'Company interviews',
        'subtitle': 'Prepare around a target employer or job description',
        'focus': 'Company interview',
        'icon': Icons.business_outlined,
        'color': const Color(0xFF9A7A46),
      },
      {
        'title': 'Aptitude & assessments',
        'subtitle': 'Reasoning, quantitative aptitude and test practice',
        'focus': 'Aptitude & assessments',
        'icon': Icons.fact_check_outlined,
        'color': const Color(0xFF9B59B6),
      },
      {
        'title': 'HR & communication',
        'subtitle': 'Behavioral interviews, speaking and confidence',
        'focus': 'HR & communication',
        'icon': Icons.forum_outlined,
        'color': const Color(0xFFDA5277),
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isDesktop ? 24 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE4E5DB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pick your preparation focus',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'CareerPrep is for every candidate. Start with a suggested area or enter any topic you have in mind.',
            style: TextStyle(
              color: Color(0xFF73786C),
              height: 1.5,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 900
                  ? 3
                  : constraints.maxWidth >= 540
                  ? 2
                  : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: options.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  mainAxisExtent: 112,
                ),
                itemBuilder: (context, index) {
                  final option = options[index];
                  final focus = option['focus'] as String;
                  final color = option['color'] as Color;
                  final selected = selectedPreparationFocus == focus;
                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => setState(() {
                      selectedPreparationFocus = focus;
                      if (_preparationTopicController.text.trim().isEmpty) {
                        switch (focus) {
                          case 'Technology & programming':
                            _preparationTopicController.text = '';
                            break;
                          case 'Frameworks & tools':
                            _preparationTopicController.text = '';
                            break;
                          case 'Job role':
                            _preparationTopicController.text = '';
                            break;
                          case 'Company interview':
                            _preparationTopicController.text = '';
                            break;
                          default:
                            _preparationTopicController.text = '';
                        }
                      }
                    }),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: selected
                            ? color.withValues(alpha: 0.07)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: selected ? color : const Color(0xFFE4E5DB),
                          width: selected ? 1.6 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              option['icon'] as IconData,
                              color: color,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  option['title'] as String,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  option['subtitle'] as String,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    height: 1.35,
                                    color: Color(0xFF73786C),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (selected)
                            Icon(
                              Icons.check_circle_rounded,
                              color: color,
                              size: 19,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 18),
          TextField(
            controller: _preparationTopicController,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _startSelectedPreparation(),
            decoration: InputDecoration(
              labelText: 'Your topic (optional)',
              hintText:
                  'e.g. Python, Cybersecurity, Data Analyst, UPSC, Amazon...',
              prefixIcon: const Icon(Icons.search_rounded),
              helperText: 'Enter any language, technology, role, company, exam, or subject.',
              helperMaxLines: 2,
              suffixIcon: IconButton(
                tooltip: 'Clear topic',
                onPressed: () => _preparationTopicController.clear(),
                icon: const Icon(Icons.close_rounded),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                [
                  'Python',
                  'Java',
                  'Cybersecurity',
                  'Data Analyst',
                  'Product Manager',
                  'Aptitude',
                ].map((topic) {
                  return ActionChip(
                    label: Text(topic),
                    onPressed: () {
                      setState(() {
                        _preparationTopicController.text = topic;
                        if (topic == 'Aptitude') {
                          selectedPreparationFocus = 'Aptitude & assessments';
                        } else if (topic == 'Data Analyst' ||
                            topic == 'Product Manager') {
                          selectedPreparationFocus = 'Job role';
                        } else {
                          selectedPreparationFocus = 'Technology & programming';
                        }
                      });
                    },
                  );
                }).toList(),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _startSelectedPreparation,
              icon: const Icon(Icons.arrow_forward_rounded),
              label: const Text('Continue with my preparation'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Your selection opens the closest matching preparation workspace. Custom topics are saved into that workspace; topic-specific question generation will be added as a separate feature.',
            style: TextStyle(
              fontSize: 11,
              height: 1.45,
              color: Color(0xFF73786C),
            ),
          ),
        ],
      ),
    );
  }

  void _startSelectedPreparation() {
    final topic = _preparationTopicController.text.trim();
    switch (selectedPreparationFocus) {
      case 'Technology & programming':
      case 'Frameworks & tools':
        if (topic.isNotEmpty) selectedTechnology = topic;
        setState(() => selectedPage = 9);
        break;
      case 'Job role':
        if (topic.isNotEmpty) selectedJobRole = topic;
        setState(() => selectedPage = 7);
        break;
      case 'Company interview':
        if (topic.isNotEmpty) selectedCompany = topic;
        setState(() => selectedPage = 8);
        break;
      case 'Aptitude & assessments':
        setState(() => selectedPage = 10);
        break;
      case 'HR & communication':
        openPractice(category: 'HR');
        break;
      default:
        _careerChatController.text = topic.isEmpty
            ? 'Help me choose what to prepare based on my career goal.'
            : 'Help me prepare for: $topic';
        setState(() => selectedPage = 11);
    }
  }

  Widget _buildResumeChecklist() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(19),
        child: Column(
          children: List.generate(resumeTasks.length, (index) {
            final completed = completedTasks.contains(index);

            return CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              value: completed,
              activeColor: const Color(0xFF536D4F),
              title: Text(
                resumeTasks[index],
                style: TextStyle(
                  fontSize: 13,
                  decoration: completed ? TextDecoration.lineThrough : null,
                  color: completed
                      ? const Color(0xFF858A7E)
                      : const Color(0xFF292B3A),
                ),
              ),
              onChanged: (_) => toggleTask(index),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildQuestionPreview(InterviewQuestion question) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 10,
          ),
          leading: Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EEFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.quiz_outlined, color: Color(0xFF536D4F)),
          ),
          title: Text(
            question.question,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Text(
              '${question.category} • ${question.difficulty}',
              style: const TextStyle(fontSize: 11, color: Color(0xFF73786C)),
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
          onTap: () => openPractice(category: question.category),
        ),
      ),
    );
  }

  Widget _buildPracticePage(bool isDesktop) {
    final questions = filteredQuestions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Practice makes progress.',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text(
          'Explore interview questions and reveal answers when you are ready.',
          style: TextStyle(color: Color(0xFF73786C), height: 1.5),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: _practiceSearchController,
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search interview questions...',
            prefixIcon: const Icon(Icons.search_rounded),
            suffixIcon: searchQuery.isEmpty
                ? null
                : IconButton(
                    tooltip: 'Clear search',
                    onPressed: () {
                      _practiceSearchController.clear();
                      setState(() => searchQuery = '');
                    },
                    icon: const Icon(Icons.close_rounded),
                  ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              [
                'All',
                ...categories.map((category) => category['name'] as String),
              ].map((category) {
                return ChoiceChip(
                  label: Text(category),
                  selected: selectedCategory == category,
                  onSelected: (_) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                );
              }).toList(),
        ),
        const SizedBox(height: 24),
        Text(
          '${questions.length} questions found',
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 14),
        if (questions.isEmpty)
          _emptyState(
            Icons.search_off_rounded,
            'No questions found',
            'Try another keyword or reset the category and search filters.',
            'Reset filters',
            () {
              _practiceSearchController.clear();
              setState(() {
                searchQuery = '';
                selectedCategory = 'All';
              });
            },
          )
        else
          ...questions.map((question) => _buildInteractiveQuestion(question)),
      ],
    );
  }

  Widget _buildInteractiveQuestion(InterviewQuestion question) {
    final selectedOption = selectedAnswers[question.id];
    final hasAnswered = selectedOption != null;
    final isCorrect = answerResults[question.id] ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _badge(
                    question.category,
                    const Color(0xFFF0EEFF),
                    const Color(0xFF536D4F),
                  ),
                  _badge(
                    question.difficulty,
                    const Color(0xFFE8EEE3),
                    const Color(0xFF536D4F),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                question.question,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),

              // Multiple-choice options.
              ...List.generate(question.options.length, (index) {
                final isSelected = selectedOption == index;
                final isCorrectOption = index == question.correctOptionIndex;

                Color borderColor = const Color(0xFFE4E5DB);
                Color backgroundColor = Colors.white;
                Color textColor = const Color(0xFF292B3A);

                if (hasAnswered && isCorrectOption) {
                  borderColor = const Color(0xFF536D4F);
                  backgroundColor = const Color(0xFFE8EEE3);
                  textColor = const Color(0xFF087653);
                } else if (hasAnswered && isSelected && !isCorrect) {
                  borderColor = const Color(0xFFD94040);
                  backgroundColor = const Color(0xFFFFEEEE);
                  textColor = const Color(0xFFB42318);
                }

                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onTap: hasAnswered
                        ? null
                        : () => selectAnswer(question, index),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderColor),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${String.fromCharCode(65 + index)}. '
                              '${question.options[index]}',
                              style: TextStyle(
                                color: textColor,
                                fontWeight:
                                    isSelected ||
                                        (hasAnswered && isCorrectOption)
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                          if (hasAnswered && isCorrectOption)
                            const Icon(
                              Icons.check_circle_rounded,
                              color: Color(0xFF536D4F),
                            )
                          else if (hasAnswered && isSelected && !isCorrect)
                            const Icon(
                              Icons.cancel_rounded,
                              color: Color(0xFFD94040),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),

              // Feedback and explanation.
              if (hasAnswered) ...[
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isCorrect
                        ? const Color(0xFFE8EEE3)
                        : const Color(0xFFFFF4E5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isCorrect ? 'Correct answer!' : 'Not quite!',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: isCorrect
                              ? const Color(0xFF087653)
                              : const Color(0xFF9A5B00),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        question.explanation,
                        style: const TextStyle(height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 16),

              // Bookmark and answer status.
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => toggleBookmark(question.id),
                      icon: Icon(
                        bookmarkedIds.contains(question.id)
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_border_rounded,
                      ),
                      label: Text(
                        bookmarkedIds.contains(question.id)
                            ? 'Saved'
                            : 'Bookmark',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: hasAnswered
                          ? null
                          : () => _showAnswer(question),
                      icon: const Icon(Icons.menu_book_rounded),
                      label: const Text('View answer'),
                    ),
                  ),
                ],
              ),

              if (answeredIds.contains(question.id)) ...[
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      size: 16,
                      color: Color(0xFF536D4F),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Previously practiced',
                      style: TextStyle(color: Color(0xFF536D4F), fontSize: 12),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _badge(String text, Color background, Color foreground) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: foreground,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  void _showAnswer(InterviewQuestion question) {
    markAnswered(question.id);

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(question.question),
          content: SingleChildScrollView(
            child: Text(
              question.answer,
              style: const TextStyle(height: 1.7, fontSize: 14),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildQuizPromotion() {
    final isNarrow = MediaQuery.sizeOf(context).width < 600;
    final message = const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ready to test yourself?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Take a practice quiz, check your score, and review every answer.',
          style: TextStyle(color: Colors.white, height: 1.5),
        ),
      ],
    );
    final button = FilledButton.tonalIcon(
      onPressed: () {
        setState(() {
          selectedPage = 4;
          quizQuestions = [];
          quizFinished = false;
          showingQuizReview = false;
        });
      },
      icon: const Icon(Icons.play_arrow_rounded),
      label: const Text('Start quiz'),
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF536D4F), Color(0xFF897CF5)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: isNarrow
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [message, const SizedBox(height: 16), button],
            )
          : Row(
              children: [
                Expanded(child: message),
                const SizedBox(width: 16),
                button,
              ],
            ),
    );
  }

  // Start a quiz focused on a category identified by local performance data.
  void _startRecommendedQuiz(String category) {
    setState(() {
      quizCategory = category;
      quizDifficulty = 'All';
      quizQuestionCount = 10;
    });
    _startQuiz();
  }

  // Revision mode combines bookmarked questions and questions previously answered incorrectly.
  void _startRevisionQuiz() {
    final revisionIds = <int>{...bookmarkedIds, ...missedQuestionIds};
    final revisionQuestions =
        questionBank
            .where((question) => revisionIds.contains(question.id))
            .toList()
          ..shuffle();

    if (revisionQuestions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No revision questions yet. Bookmark questions or answer some practice questions incorrectly first.',
          ),
        ),
      );
      return;
    }

    setState(() {
      quizCategory = 'Revision';
      quizDifficulty = 'All';
      quizQuestions = revisionQuestions.take(20).toList();
      quizAnswers.clear();
      currentQuestionIndex = 0;
      quizFinished = false;
      showingQuizReview = false;
      selectedPage = 4;
    });
  }

  Map<String, dynamic> _categoryLearningInsight(String category) {
    final categoryQuestions = questionBank
        .where((question) => question.category == category)
        .toList();
    final practiced = categoryQuestions
        .where((question) => answeredIds.contains(question.id))
        .length;
    final attempts = quizHistory.where((item) => item['category'] == category);
    final scores = attempts
        .map((item) => (item['percentage'] as num?)?.toDouble() ?? 0.0)
        .toList();
    final average = scores.isEmpty
        ? null
        : scores.reduce((a, b) => a + b) / scores.length;
    final completion = categoryQuestions.isEmpty
        ? 0.0
        : practiced / categoryQuestions.length;
    // Lower quiz averages weigh more heavily than practice completion.
    final priority = average == null
        ? 100.0 - completion * 100
        : (100.0 - average) * 0.75 + (100.0 - completion * 100) * 0.25;
    return {
      'category': category,
      'practiced': practiced,
      'total': categoryQuestions.length,
      'completion': completion,
      'average': average,
      'priority': priority,
    };
  }

  Widget _buildPersonalizedStudyPlan(bool isDesktop) {
    final insights =
        categories
            .map((item) => _categoryLearningInsight(item['name'] as String))
            .toList()
          ..sort(
            (a, b) =>
                (b['priority'] as double).compareTo(a['priority'] as double),
          );
    final weakest = insights.take(2).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE4E5DB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.track_changes_rounded, color: Color(0xFF536D4F)),
              const SizedBox(width: 9),
              const Expanded(
                child: Text(
                  'Personalized study plan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Recommendations are calculated locally from your practice completion and saved quiz scores.',
            style: TextStyle(color: Color(0xFF73786C), height: 1.4),
          ),
          const SizedBox(height: 14),
          ...weakest.map((insight) {
            final category = insight['category'] as String;
            final average = insight['average'] as double?;
            final completion = ((insight['completion'] as double) * 100)
                .round();
            final practiced = insight['practiced'] as int;
            final total = insight['total'] as int;
            final title = average == null
                ? 'Start with $category'
                : average < 70
                ? 'Prioritize $category'
                : 'Keep improving $category';
            final detail = average == null
                ? 'You have practiced $practiced/$total questions. Take a quiz to establish your baseline.'
                : 'Quiz average ${average.round()}% · $completion% of questions practiced. Aim for 80% or higher.';
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F6FF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.bolt_rounded, color: Color(0xFF536D4F)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          detail,
                          style: const TextStyle(
                            color: Color(0xFF73786C),
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () => _startRecommendedQuiz(category),
                    child: const Text('Practice'),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 4),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              FilledButton.icon(
                onPressed: _startRevisionQuiz,
                icon: const Icon(Icons.replay_rounded),
                label: Text(
                  'Revision mode (${bookmarkedIds.length + missedQuestionIds.difference(bookmarkedIds).length})',
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => setState(() => selectedPage = 2),
                icon: const Icon(Icons.bookmark_outline_rounded),
                label: const Text('Review bookmarks'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _startQuiz() {
    var available = questionBank.where((question) {
      final categoryMatches =
          quizCategory == 'All' || question.category == quizCategory;
      final difficultyMatches =
          quizDifficulty == 'All' || question.difficulty == quizDifficulty;
      return categoryMatches && difficultyMatches;
    }).toList();

    available.shuffle();
    if (available.length > quizQuestionCount) {
      available = available.take(quizQuestionCount).toList();
    }

    if (available.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No questions match these settings.')),
      );
      return;
    }

    setState(() {
      quizQuestions = available;
      quizAnswers.clear();
      currentQuestionIndex = 0;
      quizFinished = false;
      showingQuizReview = false;
      selectedPage = 4;
    });
  }

  int get _quizCorrectCount => quizQuestions.where((question) {
    return quizAnswers[question.id] == question.correctOptionIndex;
  }).length;

  int get _quizIncorrectCount => quizQuestions.where((question) {
    final selected = quizAnswers[question.id];
    return selected != null && selected != question.correctOptionIndex;
  }).length;

  int get _quizUnansweredCount => quizQuestions.length - quizAnswers.length;

  void _finishQuiz() {
    if (quizFinished) {
      return;
    }
    _saveQuizAttempt();
    setState(() {
      quizFinished = true;
      showingQuizReview = false;
    });
  }

  Widget _buildQuizPage() {
    if (quizQuestions.isEmpty) {
      return _buildQuizSetup();
    }
    if (quizFinished) {
      return showingQuizReview ? _buildQuizReview() : _buildQuizResults();
    }

    final question = quizQuestions[currentQuestionIndex];
    final selected = quizAnswers[question.id];
    final progress = (currentQuestionIndex + 1) / quizQuestions.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          'Practice quiz',
          '${question.category} • ${question.difficulty}',
          action: 'Exit quiz',
          onAction: () {
            setState(() {
              quizQuestions = [];
              quizAnswers.clear();
              quizFinished = false;
              showingQuizReview = false;
            });
          },
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Question ${currentQuestionIndex + 1} of ${quizQuestions.length}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    _badge(
                      '${(progress * 100).round()}%',
                      const Color(0xFFF0EEFF),
                      const Color(0xFF536D4F),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: const Color(0xFFEEEAFB),
                    color: const Color(0xFF536D4F),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  question.question,
                  style: const TextStyle(
                    fontSize: 21,
                    height: 1.45,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 22),
                ...List.generate(question.options.length, (index) {
                  final isSelected = selected == index;
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: OutlinedButton(
                      onPressed: selected == null
                          ? () => setState(() {
                              quizAnswers[question.id] = index;
                            })
                          : null,
                      style: OutlinedButton.styleFrom(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(16),
                        backgroundColor: isSelected
                            ? const Color(0xFFF0EEFF)
                            : Colors.white,
                        side: BorderSide(
                          color: isSelected
                              ? const Color(0xFF536D4F)
                              : const Color(0xFFE4E5DB),
                          width: isSelected ? 2 : 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF536D4F)
                                  : const Color(0xFFF2F3F8),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Text(
                              String.fromCharCode(65 + index),
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF55576B),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              question.options[index],
                              style: const TextStyle(height: 1.4),
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check_circle_rounded,
                              color: Color(0xFF536D4F),
                            ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 16),
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: currentQuestionIndex == 0
                          ? null
                          : () => setState(() => currentQuestionIndex--),
                      icon: const Icon(Icons.arrow_back_rounded),
                      label: const Text('Previous'),
                    ),
                    const Spacer(),
                    FilledButton.icon(
                      onPressed: () {
                        if (currentQuestionIndex == quizQuestions.length - 1) {
                          _finishQuiz();
                        } else {
                          setState(() => currentQuestionIndex++);
                        }
                      },
                      icon: Icon(
                        currentQuestionIndex == quizQuestions.length - 1
                            ? Icons.flag_rounded
                            : Icons.arrow_forward_rounded,
                      ),
                      label: Text(
                        currentQuestionIndex == quizQuestions.length - 1
                            ? 'Finish quiz'
                            : 'Next question',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'You can skip a question and return to it before finishing.',
                  style: TextStyle(color: Color(0xFF73786C), fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuizSetup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quiz Center',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text(
          'Choose your settings, attempt the questions, and get a score with answer explanations.',
          style: TextStyle(color: Color(0xFF73786C), height: 1.5),
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Set up your quiz',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Category',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: quizCategory,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: [
                    const DropdownMenuItem(
                      value: 'All',
                      child: Text('All categories'),
                    ),
                    ...categories.map((category) {
                      final name = category['name'] as String;
                      return DropdownMenuItem(value: name, child: Text(name));
                    }),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => quizCategory = value);
                  },
                ),
                const SizedBox(height: 18),
                const Text(
                  'Difficulty',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: quizDifficulty,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'All',
                      child: Text('All difficulties'),
                    ),
                    DropdownMenuItem(
                      value: 'Beginner',
                      child: Text('Beginner'),
                    ),
                    DropdownMenuItem(
                      value: 'Intermediate',
                      child: Text('Intermediate'),
                    ),
                    DropdownMenuItem(
                      value: 'Advanced',
                      child: Text('Advanced'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => quizDifficulty = value);
                  },
                ),
                const SizedBox(height: 18),
                const Text(
                  'Number of questions',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [5, 10, 20, 50, 100].map((count) {
                    return ChoiceChip(
                      label: Text('$count'),
                      selected: quizQuestionCount == count,
                      onSelected: (_) =>
                          setState(() => quizQuestionCount = count),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _startQuiz,
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text('Start quiz'),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _showQuizHistory,
                    icon: const Icon(Icons.history_rounded),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Quiz history & analytics'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            const Icon(Icons.library_books_rounded, color: Color(0xFF536D4F)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '${questionBank.length} questions available across ${categories.length} categories.',
                style: const TextStyle(color: Color(0xFF73786C)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuizResults() {
    final total = quizQuestions.length;
    final percentage = total == 0
        ? 0
        : (_quizCorrectCount / total * 100).round();
    final performance = percentage >= 80
        ? 'Excellent work!'
        : percentage >= 60
        ? 'Good effort!'
        : percentage >= 40
        ? 'Keep practicing!'
        : 'Every attempt helps you improve!';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quiz completed',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text(
          'Here is a summary of your performance.',
          style: TextStyle(color: Color(0xFF73786C)),
        ),
        const SizedBox(height: 22),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF536D4F), Color(0xFF897CF5)],
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.emoji_events_rounded,
                size: 52,
                color: Colors.white,
              ),
              const SizedBox(height: 12),
              Text(
                '$percentage%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                '$_quizCorrectCount / $total correct',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                performance,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = (constraints.maxWidth - 24) / 3;
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _quizResultStat(
                  'Correct',
                  _quizCorrectCount,
                  const Color(0xFF536D4F),
                  width,
                ),
                _quizResultStat(
                  'Incorrect',
                  _quizIncorrectCount,
                  const Color(0xFFD94040),
                  width,
                ),
                _quizResultStat(
                  'Unanswered',
                  _quizUnansweredCount,
                  const Color(0xFF73786C),
                  width,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: () => setState(() => showingQuizReview = true),
          icon: const Icon(Icons.fact_check_rounded),
          label: const Text('Review answers'),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: () {
            setState(() {
              quizQuestions = [];
              quizAnswers.clear();
              quizFinished = false;
              showingQuizReview = false;
            });
          },
          icon: const Icon(Icons.refresh_rounded),
          label: const Text('Create another quiz'),
        ),
        const SizedBox(height: 10),
        TextButton.icon(
          onPressed: () => setState(() {
            selectedPage = 0;
            quizQuestions = [];
          }),
          icon: const Icon(Icons.home_rounded),
          label: const Text('Back to dashboard'),
        ),
      ],
    );
  }

  Widget _quizResultStat(String label, int value, Color color, double width) {
    return SizedBox(
      width: width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
          child: Column(
            children: [
              Text(
                '$value',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuizReview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          'Answer review',
          'Check your choices and read the explanations.',
          action: 'Back to results',
          onAction: () => setState(() => showingQuizReview = false),
        ),
        const SizedBox(height: 18),
        ...quizQuestions.asMap().entries.map((entry) {
          final index = entry.key;
          final question = entry.value;
          final selected = quizAnswers[question.id];
          final correct = selected == question.correctOptionIndex;
          final skipped = selected == null;

          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question ${index + 1}',
                      style: const TextStyle(
                        color: Color(0xFF536D4F),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      question.question,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Your answer: ${skipped ? 'Not answered' : question.options[selected]}',
                      style: TextStyle(
                        color: skipped
                            ? const Color(0xFF73786C)
                            : correct
                            ? const Color(0xFF536D4F)
                            : const Color(0xFFD94040),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Correct answer: ${question.options[question.correctOptionIndex]}',
                      style: const TextStyle(
                        color: Color(0xFF536D4F),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      question.explanation,
                      style: const TextStyle(
                        color: Color(0xFF73786C),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        FilledButton.icon(
          onPressed: () => setState(() => showingQuizReview = false),
          icon: const Icon(Icons.arrow_back_rounded),
          label: const Text('Back to results'),
        ),
      ],
    );
  }

  Widget _buildBookmarksPage() {
    final savedQuestions = questionBank
        .where((question) => bookmarkedIds.contains(question.id))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your saved questions',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text(
          'Keep important questions handy for revision.',
          style: TextStyle(color: Color(0xFF73786C)),
        ),
        const SizedBox(height: 24),
        if (savedQuestions.isEmpty)
          _emptyState(
            Icons.bookmark_border_rounded,
            'No bookmarks yet',
            'Save questions from the Practice section to see them here.',
            'Explore questions',
            () => openPractice(),
          )
        else
          ...savedQuestions.map(_buildInteractiveQuestion),
      ],
    );
  }

  int get _totalQuizAttempts => quizHistory.length;

  double get _averageQuizScore {
    if (quizHistory.isEmpty) return 0;
    final total = quizHistory.fold<int>(
      0,
      (sum, item) => sum + ((item['percentage'] as num?)?.toInt() ?? 0),
    );
    return total / quizHistory.length;
  }

  int get _bestQuizScore {
    if (quizHistory.isEmpty) return 0;
    return quizHistory.fold<int>(0, (best, item) {
      final score = (item['percentage'] as num?)?.toInt() ?? 0;
      return score > best ? score : best;
    });
  }

  Widget _analyticsMetric({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE4E5DB)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF73786C),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF858A7E),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizAnalyticsSection(bool isDesktop) {
    final metrics = [
      _analyticsMetric(
        title: 'Quiz attempts',
        value: '$_totalQuizAttempts',
        subtitle: 'Completed quizzes',
        icon: Icons.quiz_rounded,
        color: const Color(0xFF536D4F),
      ),
      _analyticsMetric(
        title: 'Average score',
        value: '${_averageQuizScore.round()}%',
        subtitle: 'Across all attempts',
        icon: Icons.trending_up_rounded,
        color: const Color(0xFF249B76),
      ),
      _analyticsMetric(
        title: 'Best score',
        value: '$_bestQuizScore%',
        subtitle: 'Personal best',
        icon: Icons.emoji_events_rounded,
        color: const Color(0xFF9A7A46),
      ),
    ];

    final recentAttempts = quizHistory.take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeading(
          'Quiz performance',
          'Track your results and see how your preparation is improving.',
          action: 'Take a quiz',
          onAction: () => setState(() => selectedPage = 4),
        ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            final useRow = constraints.maxWidth >= 760;
            if (useRow) {
              return Row(
                children: [
                  for (var i = 0; i < metrics.length; i++) ...[
                    if (i > 0) const SizedBox(width: 14),
                    Expanded(child: metrics[i]),
                  ],
                ],
              );
            }
            return Column(
              children: [
                for (var i = 0; i < metrics.length; i++) ...[
                  if (i > 0) const SizedBox(height: 12),
                  metrics[i],
                ],
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE4E5DB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Recent quiz attempts',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              if (recentAttempts.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    'No quiz attempts yet. Complete a quiz to see your performance here.',
                    style: TextStyle(color: Color(0xFF73786C)),
                  ),
                )
              else
                ...recentAttempts.map((attempt) {
                  final score = (attempt['percentage'] as num?)?.toInt() ?? 0;
                  final dateText = DateTime.tryParse(
                    attempt['date']?.toString() ?? '',
                  );
                  final dateLabel = dateText == null
                      ? 'Date unavailable'
                      : '${dateText.day.toString().padLeft(2, '0')}/${dateText.month.toString().padLeft(2, '0')}/${dateText.year}';
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    child: Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFF536D4F)
                                .withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '$score%',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF536D4F),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${attempt['category'] ?? 'All'} · ${attempt['difficulty'] ?? 'All'}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '$dateLabel · ${attempt['correct'] ?? 0}/${attempt['total'] ?? 0} correct',
                                style: const TextStyle(
                                  color: Color(0xFF73786C),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 74,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: (score / 100).clamp(0.0, 1.0),
                              minHeight: 7,
                              backgroundColor: const Color(0xFFEEEAFB),
                              color: score >= 70
                                  ? const Color(0xFF249B76)
                                  : const Color(0xFF9A7A46),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              if (quizHistory.isNotEmpty) ...[
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: _showQuizHistory,
                    icon: const Icon(Icons.history_rounded),
                    label: const Text('View full quiz history'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  final Set<String> _resumeStopWords = const {
    'the',
    'and',
    'for',
    'with',
    'you',
    'your',
    'are',
    'our',
    'from',
    'that',
    'this',
    'will',
    'have',
    'has',
    'had',
    'was',
    'were',
    'who',
    'what',
    'when',
    'where',
    'how',
    'why',
    'all',
    'any',
    'can',
    'may',
    'must',
    'should',
    'would',
    'could',
    'into',
    'onto',
    'over',
    'under',
    'about',
    'after',
    'before',
    'between',
    'using',
    'use',
    'used',
    'work',
    'working',
    'role',
    'job',
    'team',
    'good',
    'strong',
    'ability',
    'skills',
    'skill',
    'experience',
    'years',
    'year',
    'including',
    'such',
    'etc',
    'their',
    'they',
    'them',
    'these',
    'those',
    'which',
    'while',
    'within',
    'across',
    'both',
    'more',
    'most',
    'some',
    'other',
    'also',
    'not',
    'required',
    'preferred',
    'responsibilities',
    'requirements',
    'candidate',
  };

  // Common technical terms are kept as phrases so the analyzer can provide
  // a useful skill-focused report instead of treating every generic word as a skill.
  static const Map<String, List<String>> _resumeSkillAliases = {
    'Flutter': ['flutter'],
    'Dart': ['dart'],
    'Firebase': ['firebase'],
    'REST APIs': ['rest api', 'rest apis', 'restful api', 'restful apis'],
    'SQL': ['sql', 'mysql', 'postgresql', 'sqlite'],
    'Git': ['git', 'github', 'gitlab'],
    'State management': [
      'provider',
      'riverpod',
      'bloc',
      'cubit',
      'getx',
      'state management',
    ],
    'Unit testing': ['unit test', 'unit testing', 'flutter test', 'mockito'],
    'Java': ['java'],
    'Python': ['python'],
    'JavaScript': ['javascript', 'js'],
    'TypeScript': ['typescript', 'ts'],
    'React': ['react', 'react.js', 'reactjs'],
    'Node.js': ['node.js', 'nodejs', 'express.js', 'expressjs'],
    'HTML/CSS': ['html', 'css'],
    'C++': ['c++'],
    'C#': ['c#', 'c sharp'],
    'OOP': ['object oriented', 'object-oriented', 'oop'],
    'Data structures': ['data structures', 'data structure', 'dsa'],
    'Algorithms': ['algorithms', 'algorithm'],
    'API integration': ['api integration', 'integrate api', 'integrated api'],
    'Problem solving': ['problem solving', 'problem-solving'],
    'Agile/Scrum': ['agile', 'scrum', 'sprint'],
    'CI/CD': ['ci/cd', 'continuous integration', 'continuous deployment'],
    'AWS': ['aws', 'amazon web services'],
    'Docker': ['docker'],
  };

  String _normalizeResumeText(String value) => value
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9+#./\s-]'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  bool _containsTerm(String haystack, String term) {
    final normalizedHaystack = _normalizeResumeText(haystack);
    final normalizedTerm = _normalizeResumeText(term);
    if (normalizedTerm.isEmpty) return false;
    final escaped = RegExp.escape(normalizedTerm).replaceAll(r'\ ', r'\s+');
    return RegExp('(^|\\s)$escaped(\$|\\s|[.,;:/])')
        .hasMatch(normalizedHaystack);
  }

  List<String> _resumeKeywords(String text) {
    final normalized = _normalizeResumeText(text);
    final detectedSkills = <String>[];
    for (final entry in _resumeSkillAliases.entries) {
      if (entry.value.any((alias) => _containsTerm(normalized, alias))) {
        detectedSkills.add(entry.key);
      }
    }

    final words = RegExp(r'[a-zA-Z][a-zA-Z0-9+#.\-]{1,}')
        .allMatches(normalized)
        .map((match) => match.group(0)!.replaceAll(RegExp(r'[.\-]+$'), ''))
        .where((word) => word.length >= 3 && !_resumeStopWords.contains(word));
    for (final word in words) {
      if (detectedSkills.length >= 30) break;
      if (!detectedSkills.any((item) => item.toLowerCase() == word)) {
        detectedSkills.add(word);
      }
    }
    return detectedSkills.take(30).toList();
  }

  bool _resumeContainsKeyword(String text, String keyword) {
    final aliases = _resumeSkillAliases[keyword];
    if (aliases != null) {
      return aliases.any((alias) => _containsTerm(text, alias));
    }
    return _containsTerm(text, keyword);
  }

  List<String> get _matchedResumeKeywords =>
      _resumeKeywords(jobDescriptionText)
          .where((keyword) => _resumeContainsKeyword(resumeText, keyword))
          .toList();

  List<String> get _missingResumeKeywords =>
      _resumeKeywords(jobDescriptionText)
          .where((keyword) => !_resumeContainsKeyword(resumeText, keyword))
          .toList();

  int get _resumeQualityScore {
    final lower = resumeText.toLowerCase();
    if (lower.trim().isEmpty) return 0;
    final checks = <bool>[
      RegExp(r'\b[\w.+-]+@[\w.-]+\.[a-z]{2,}\b').hasMatch(lower),
      RegExp(r'\b(education|b\.tech|bachelor|degree|university|college)\b')
          .hasMatch(lower),
      RegExp(r'\b(project|projects)\b').hasMatch(lower),
      RegExp(r'\b(skills|technical skills|technologies)\b').hasMatch(lower),
      RegExp(r'\b(experience|internship|employment)\b').hasMatch(lower),
      RegExp(r'\b(achievement|achievements|certification|certifications)\b')
          .hasMatch(lower),
      RegExp(r'\b\d+\s*(%|users|projects|ms|seconds|months|years)\b')
          .hasMatch(lower),
      RegExp(r'\b(github|linkedin|portfolio)\b').hasMatch(lower),
    ];
    return (checks.where((check) => check).length / checks.length * 100)
        .round();
  }

  int get _combinedResumeScore {
    final keywords = _resumeKeywords(jobDescriptionText);
    final matchScore = keywords.isEmpty
        ? 0
        : (_matchedResumeKeywords.length / keywords.length * 100).round();
    // 70% job-description match + 30% resume completeness checks.
    return (matchScore * 0.7 + _resumeQualityScore * 0.3).round();
  }

  List<String> get _localInterviewQuestions {
    final focusSkills = _matchedResumeKeywords.take(5).toList();
    final gaps = _missingResumeKeywords.take(3).toList();
    final questions = <String>[];
    for (final skill in focusSkills) {
      questions.add(
        'Explain how you have used $skill in a project and describe one challenge you solved.',
      );
    }
    for (final skill in gaps) {
      questions.add(
        'What do you understand about $skill, and how would you begin learning or applying it?',
      );
    }
    if (questions.isEmpty) {
      questions.addAll([
        'Walk through one project and explain your individual contribution.',
        'Describe a technical problem you solved and how you verified the solution.',
        'Which role-related skill are you currently improving, and how?',
      ]);
    }
    return questions.take(8).toList();
  }

  Future<void> _pickResumePdf() async {
    try {
      final file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (file == null) return;

      final bytes = await file.readAsBytes();
      if (bytes.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not read this PDF. Try another file.'),
          ),
        );
        return;
      }

      setState(() => isExtractingResume = true);
      String extractedText;
      PdfDocument? document;
      try {
        document = PdfDocument(inputBytes: bytes);
        extractedText = PdfTextExtractor(document).extractText();
      } finally {
        document?.dispose();
      }

      if (!mounted) return;
      if (extractedText.trim().isEmpty) {
        setState(() => isExtractingResume = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'No selectable text was found. This may be a scanned PDF; paste the text manually or use OCR.',
            ),
          ),
        );
        return;
      }

      setState(() {
        resumeText = extractedText.trim();
        uploadedResumeFileName = file.name;
        resumeAnalyzed = false;
        isExtractingResume = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Resume text extracted from ${file.name}.')),
      );
    } catch (error) {
      if (!mounted) return;
      setState(() => isExtractingResume = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not read this PDF. Make sure it is a valid, unencrypted PDF and try again.',
          ),
        ),
      );
    }
  }

  void _analyzeResume() {
    if (resumeText.trim().isEmpty || jobDescriptionText.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter both your resume and the job description.'),
        ),
      );
      return;
    }
    setState(() => resumeAnalyzed = true);
  }

  Widget _buildResumeAnalyzerPage(bool isDesktop) {
    final keywords = _resumeKeywords(jobDescriptionText);
    final matched = _matchedResumeKeywords;
    final missing = _missingResumeKeywords;
    final score = keywords.isEmpty
        ? 0
        : (matched.length / keywords.length * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Resume Analyzer',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text(
          'Compare your resume with a target job description and find keywords to review.',
          style: TextStyle(color: Color(0xFF73786C), height: 1.5),
        ),
        const SizedBox(height: 22),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE4E5DB)),
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 10,
            children: [
              FilledButton.tonalIcon(
                onPressed: isExtractingResume ? null : _pickResumePdf,
                icon: isExtractingResume
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.upload_file_rounded),
                label: Text(
                  isExtractingResume ? 'Extracting PDF…' : 'Upload resume PDF',
                ),
              ),
              if (uploadedResumeFileName != null)
                Chip(
                  avatar: const Icon(Icons.check_circle, size: 17),
                  label: Text(
                    uploadedResumeFileName!,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              const Text(
                'PDF text is extracted locally in this app. Scanned image-only PDFs need OCR.',
                style: TextStyle(
                  color: Color(0xFF73786C),
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final stacked = constraints.maxWidth < 760;
            final resumeField = _resumeInputCard(
              title: 'Your resume',
              subtitle: 'Paste the text from your current resume.',
              value: resumeText,
              hint: 'Paste resume text here…',
              icon: Icons.description_outlined,
              onChanged: (value) => setState(() {
                resumeText = value;
                resumeAnalyzed = false;
              }),
            );
            final jobField = _resumeInputCard(
              title: 'Target job description',
              subtitle: 'Paste the job requirements you want to match.',
              value: jobDescriptionText,
              hint: 'Paste job description here…',
              icon: Icons.work_outline_rounded,
              onChanged: (value) => setState(() {
                jobDescriptionText = value;
                resumeAnalyzed = false;
              }),
            );
            if (stacked) {
              return Column(
                children: [resumeField, const SizedBox(height: 16), jobField],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: resumeField),
                const SizedBox(width: 16),
                Expanded(child: jobField),
              ],
            );
          },
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: isDesktop ? 230 : double.infinity,
          height: 50,
          child: FilledButton.icon(
            onPressed: isExtractingResume ? null : _analyzeResume,
            icon: const Icon(Icons.analytics_outlined),
            label: const Text('Analyze resume'),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF536D4F),
            ),
          ),
        ),
        if (resumeAnalyzed) ...[
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE4E5DB)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Resume match overview',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      width: 86,
                      height: 86,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF536D4F).withValues(alpha: 0.10),
                        border: Border.all(
                          color: const Color(0xFF536D4F),
                          width: 3,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$score%',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF536D4F),
                        ),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${matched.length} of ${keywords.length} keywords matched',
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'This is a basic keyword comparison, not a prediction of interview or hiring success.',
                            style: TextStyle(
                              color: Color(0xFF73786C),
                              height: 1.4,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _resumeMetricCard(
                      title: 'ATS-style estimate',
                      value: '$_combinedResumeScore%',
                      detail: '70% job match + 30% resume completeness',
                      icon: Icons.fact_check_outlined,
                    ),
                    _resumeMetricCard(
                      title: 'Resume completeness',
                      value: '$_resumeQualityScore%',
                      detail: 'Based on 8 visible content checks',
                      icon: Icons.description_outlined,
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                _resumeKeywordGroup(
                  'Keywords found',
                  matched,
                  const Color(0xFF536D4F),
                ),
                const SizedBox(height: 18),
                _resumeKeywordGroup(
                  'Skills / keywords to review',
                  missing,
                  const Color(0xFFD97706),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Skill gap action plan',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                Text(
                  missing.isEmpty
                      ? 'No missing keywords were detected by this rule-based comparison. Review the job description manually as well.'
                      : 'Review these ${missing.length} items against the role. Prioritize essential requirements, learn what you genuinely need, and add a skill to your resume only when you can support it with real experience.',
                  style: const TextStyle(
                    color: Color(0xFF73786C),
                    height: 1.45,
                  ),
                ),
                if (missing.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  ...missing
                      .take(8)
                      .map(
                        (keyword) => Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.flag_outlined,
                                size: 18,
                                color: Color(0xFFD97706),
                              ),
                              const SizedBox(width: 8),
                              Expanded(child: Text('Review: $keyword')),
                            ],
                          ),
                        ),
                      ),
                ],
                const SizedBox(height: 20),
                const Text(
                  'Local interview practice',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Questions generated from the skills and keywords detected above. These are rule-based prompts, not AI-generated answers.',
                  style: TextStyle(
                    color: Color(0xFF73786C),
                    height: 1.45,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                ..._localInterviewQuestions.asMap().entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: const Color(0xFF536D4F)
                              .withValues(alpha: 0.10),
                          child: Text(
                            '${entry.key + 1}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF536D4F),
                            ),
                          ),
                        ),
                        const SizedBox(width: 9),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: const TextStyle(height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Suggestions',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                _resumeSuggestion(
                  Icons.fact_check_outlined,
                  'Check each missing keyword against your real experience. Only add it if it accurately describes your skills.',
                ),
                _resumeSuggestion(
                  Icons.code_rounded,
                  'For relevant projects, describe what you built, the technologies used, and the measurable result.',
                ),
                _resumeSuggestion(
                  Icons.format_list_bulleted_rounded,
                  'Keep the resume easy to scan with clear sections for summary, skills, projects, and education.',
                ),
                _resumeSuggestion(
                  Icons.link_rounded,
                  'Include working GitHub, portfolio, and LinkedIn links when relevant to the role.',
                ),
              ],
            ),
          ),
        ],
        if (resumeAnalyzed) ...[
          const SizedBox(height: 20),
          _buildResumeQualityFeedback(),
        ],
        const SizedBox(height: 18),
        const Text(
          'Privacy note: resume text and job-description analysis run locally in this app. PDF text extraction also happens on your device.',
          style: TextStyle(color: Color(0xFF73786C), fontSize: 12, height: 1.5),
        ),
      ],
    );
  }

  Widget _resumeMetricCard({
    required String title,
    required String value,
    required String detail,
    required IconData icon,
  }) {
    return Container(
      constraints: const BoxConstraints(minWidth: 220, maxWidth: 320),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F7FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE4E0FF)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 2),
          Icon(icon, size: 24, color: const Color(0xFF536D4F)),
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF536D4F),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  detail,
                  style: const TextStyle(
                    fontSize: 11,
                    height: 1.35,
                    color: Color(0xFF73786C),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResumeQualityFeedback() {
    final lower = resumeText.toLowerCase();
    final checks = <(String, String, bool)>[
      (
        'Contact details',
        'Include a professional email and phone number.',
        RegExp(r'\b[\w.+-]+@[\w.-]+\.[a-z]{2,}\b').hasMatch(lower),
      ),
      (
        'Projects',
        'Add 1–3 relevant projects with your role and technologies.',
        lower.contains('project'),
      ),
      (
        'Education',
        'Include your degree, institution, and expected/completion year.',
        lower.contains('education') ||
            lower.contains('b.tech') ||
            lower.contains('bachelor'),
      ),
      (
        'Skills',
        'Add a clearly labelled skills section with technologies you can discuss.',
        lower.contains('skills') || lower.contains('technical skills'),
      ),
      (
        'Impact',
        'Where possible, quantify outcomes (for example, load time reduced or users served).',
        RegExp(r'\b\d+\s*(%|users|projects|ms|seconds|months|years)\b')
            .hasMatch(lower),
      ),
    ];
    final missing = checks.where((check) => !check.$3).toList();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE4E5DB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Resume quality checks',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'Rule-based checks for common resume sections. Review each suggestion and only include accurate information.',
            style: TextStyle(
              color: Color(0xFF73786C),
              height: 1.4,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: _resumeQualityScore / 100,
              minHeight: 9,
              backgroundColor: const Color(0xFFE4E5DB),
              color: const Color(0xFF536D4F),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Completeness estimate: $_resumeQualityScore% (${checks.where((check) => check.$3).length} of ${checks.length} checks shown below)',
            style: const TextStyle(fontSize: 12, color: Color(0xFF73786C)),
          ),
          const SizedBox(height: 14),
          ...checks.map(
            (check) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    check.$3
                        ? Icons.check_circle_rounded
                        : Icons.info_outline_rounded,
                    color: check.$3
                        ? const Color(0xFF536D4F)
                        : const Color(0xFFD97706),
                    size: 19,
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          check.$1,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          check.$3
                              ? 'Likely present in the resume text.'
                              : check.$2,
                          style: const TextStyle(
                            color: Color(0xFF73786C),
                            height: 1.35,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (missing.isEmpty)
            const Text(
              'All common checks passed. Still review accuracy, formatting, and relevance before applying.',
            ),
        ],
      ),
    );
  }

  Widget _resumeInputCard({
    required String title,
    required String subtitle,
    required String value,
    required String hint,
    required IconData icon,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE4E5DB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF536D4F)),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(color: Color(0xFF73786C), fontSize: 12),
          ),
          const SizedBox(height: 14),
          TextFormField(
            key: ValueKey(title),
            initialValue: value,
            onChanged: onChanged,
            minLines: 9,
            maxLines: 13,
            decoration: InputDecoration(
              hintText: hint,
              alignLabelWithHint: true,
              filled: true,
              fillColor: const Color(0xFFF8F8FC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _resumeKeywordGroup(String title, List<String> words, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title (${words.length})',
          style: TextStyle(fontWeight: FontWeight.w700, color: color),
        ),
        const SizedBox(height: 9),
        if (words.isEmpty)
          const Text(
            'No keywords in this group.',
            style: TextStyle(color: Color(0xFF73786C), fontSize: 12),
          )
        else
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: words
                .map(
                  (word) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.09),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      word,
                      style: TextStyle(
                        fontSize: 12,
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  Widget _resumeSuggestion(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF536D4F)),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(height: 1.45, color: Color(0xFF55576B)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressPage(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your learning progress',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text(
          'Every question you practice is a step forward.',
          style: TextStyle(color: Color(0xFF73786C)),
        ),
        const SizedBox(height: 24),
        _buildQuizAnalyticsSection(isDesktop),
        const SizedBox(height: 22),
        _buildPersonalizedStudyPlan(isDesktop),
        const SizedBox(height: 28),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE4E5DB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Question practice completion',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 18),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${(learningProgress * 100).round()}%',
                    style: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF536D4F),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      '${answeredIds.length} of ${questionBank.length} questions practiced',
                      style: const TextStyle(
                        color: Color(0xFF73786C),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: learningProgress,
                  minHeight: 10,
                  backgroundColor: const Color(0xFFEEEAFB),
                  color: const Color(0xFF536D4F),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _sectionHeading('Category breakdown', 'Explore questions by topic.'),
        const SizedBox(height: 16),
        ...categories.map((category) {
          final name = category['name'] as String;
          final color = category['color'] as Color;

          final total = questionBank
              .where((question) => question.category == name)
              .length;

          final completed = questionBank
              .where(
                (question) =>
                    question.category == name &&
                    answeredIds.contains(question.id),
              )
              .length;

          final progress = total == 0 ? 0.0 : completed / total;

          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(19),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE4E5DB)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(category['icon'] as IconData, color: color),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      '$completed/$total',
                      style: const TextStyle(
                        color: Color(0xFF73786C),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 7,
                    color: color,
                    backgroundColor: color.withValues(alpha: 0.12),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 24),
        _sectionHeading('Resume readiness', 'Your completed checklist items.'),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${(resumeProgress * 100).round()}% completed',
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: resumeProgress,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFF536D4F),
                  backgroundColor: const Color(0xFFE8EEE3),
                ),
                const SizedBox(height: 12),
                Text(
                  '${completedTasks.length} of ${resumeTasks.length} resume tasks completed.',
                  style: const TextStyle(
                    color: Color(0xFF73786C),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _emptyState(
    IconData icon,
    String title,
    String description,
    String buttonText,
    VoidCallback onPressed,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(35),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE4E5DB)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 48, color: const Color(0xFF536D4F)),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF73786C), height: 1.5),
          ),
          const SizedBox(height: 18),
          FilledButton(onPressed: onPressed, child: Text(buttonText)),
        ],
      ),
    );
  }
}
