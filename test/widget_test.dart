import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:studentify/main.dart';

void main() {
  testWidgets('can add a study task', (WidgetTester tester) async {
    await tester.pumpWidget(const StudyPlannerApp());

    expect(find.text('Study Planner'), findsOneWidget);

    await tester.tap(find.text('Add task'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'Physics revision');
    await tester.enterText(find.byType(TextField).at(1), 'Science');
    await tester.enterText(find.byType(TextField).at(2), '60');
    await tester.tap(find.text('Add task'));
    await tester.pumpAndSettle();

    expect(find.text('Physics revision'), findsOneWidget);
  });
}
