import csv
from pathlib import Path

FILE = Path(__file__).with_name("students.csv")

SUBJECTS = ["English", "Maths", "Science"]


def load_students():
    if not FILE.exists():
        return []

    with open(FILE, "r", newline="", encoding="utf-8") as file:
        return list(csv.DictReader(file))


def save_students(students):
    fields = ["name"] + SUBJECTS

    with open(FILE, "w", newline="", encoding="utf-8") as file:
        writer = csv.DictWriter(file, fieldnames=fields)
        writer.writeheader()
        writer.writerows(students)


def get_marks(subject):
    while True:
        try:
            marks = float(input(f"Enter {subject} marks (0-100): "))

            if 0 <= marks <= 100:
                return marks

            print("Marks must be between 0 and 100.")

        except ValueError:
            print("Please enter a valid number.")


def add_student(students):
    name = input("Enter student name: ").strip()

    if not name:
        print("Name cannot be empty.")
        return

    student = {"name": name}

    for subject in SUBJECTS:
        student[subject] = get_marks(subject)

    students.append(student)
    save_students(students)

    print("Student record saved successfully!")


def calculate_average(student):
    marks = [float(student[subject]) for subject in SUBJECTS]
    return sum(marks) / len(marks)


def get_grade(average):
    if average >= 90:
        return "A+"
    elif average >= 80:
        return "A"
    elif average >= 70:
        return "B"
    elif average >= 60:
        return "C"
    elif average >= 40:
        return "D"
    return "F"


def view_students(students):
    if not students:
        print("No student records found.")
        return

    print("\n========== STUDENT RECORDS ==========")

    for student in students:
        average = calculate_average(student)
        total = sum(float(student[s]) for s in SUBJECTS)

        print(f"\nName: {student['name']}")
        print(f"Total Marks: {total:.2f}/300")
        print(f"Average: {average:.2f}%")
        print(f"Grade: {get_grade(average)}")


def show_topper(students):
    if not students:
        print("No student records available.")
        return

    topper = max(students, key=calculate_average)
    average = calculate_average(topper)

    print("\n========== CLASS TOPPER ==========")
    print(f"Name: {topper['name']}")
    print(f"Average: {average:.2f}%")
    print(f"Grade: {get_grade(average)}")


def show_statistics(students):
    if not students:
        print("No student records available.")
        return

    averages = [calculate_average(s) for s in students]
    passed = sum(average >= 40 for average in averages)

    print("\n========== CLASS STATISTICS ==========")
    print(f"Total Students: {len(students)}")
    print(f"Class Average: {sum(averages) / len(averages):.2f}%")
    print(f"Highest Average: {max(averages):.2f}%")
    print(f"Lowest Average: {min(averages):.2f}%")
    print(f"Students Passing: {passed}")
    print(f"Pass Percentage: {passed / len(students) * 100:.2f}%")


def search_student(students):
    query = input("Enter student name to search: ").strip().casefold()

    matches = [
        student for student in students
        if query and query in student["name"].casefold()
    ]

    if not matches:
        print("No matching student found.")
        return

    view_students(matches)


def main():
    students = load_students()

    while True:
        print("\n===== STUDENT PERFORMANCE ANALYZER =====")
        print("1. Add Student")
        print("2. View All Students")
        print("3. Show Topper")
        print("4. Class Statistics")
        print("5. Search Student")
        print("6. Exit")

        choice = input("Choose an option: ").strip()

        if choice == "1":
            add_student(students)
        elif choice == "2":
            view_students(students)
        elif choice == "3":
            show_topper(students)
        elif choice == "4":
            show_statistics(students)
        elif choice == "5":
            search_student(students)
        elif choice == "6":
            print("Goodbye!")
            break
        else:
            print("Invalid choice. Select 1-6.")


if __name__ == "__main__":
    main()