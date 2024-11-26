import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teste_unit/features/task/presentation/pages/task_page.dart';

void main() {
  testWidgets("icon delete", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TaskPage()));

    final inputField = find.byType(TextField);
    final addButton = find.text("Add Task");

    await tester.enterText(inputField, "Task Delete");
    await tester.tap(addButton);
    await tester.pump();

    expect(find.text("Task Delete"), findsOneWidget);

    final deleteIcon = find.byIcon(Icons.delete);
    await tester.tap(deleteIcon.first);
    await tester.pump();

    expect(find.text("Task Delete"), findsNothing);
  });
}
