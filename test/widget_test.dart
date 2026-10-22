import 'package:flutter_test/flutter_test.dart';
import 'package:career_prep_ai/main.dart';

void main() {
  testWidgets('CareerPrep AI app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const CareerPrepApp());
    await tester.pumpAndSettle();

    expect(find.byType(CareerPrepApp), findsOneWidget);
  });
}
