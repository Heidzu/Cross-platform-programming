import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_14/main.dart';

void main() {
  testWidgets('Test counter and function result', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Counter value: 0'), findsOneWidget);
    expect(find.text('Function result: 0.00'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.pets));
    await tester.pump();

    expect(find.text('Counter value: 1'), findsOneWidget);
    expect(find.text('Function result: 0.12'), findsOneWidget);
  });

  testWidgets('Test the app title', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('AV-34: Yaroslav\'s last Flutter App'), findsOneWidget);
  });

  testWidgets('Test FloatingActionButton presence', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byIcon(Icons.pets), findsOneWidget);
  });
}
