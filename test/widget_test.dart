import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_coffeee/main.dart';

void main() {
  testWidgets('App loads root view', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(darkModeEnabled: true));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.home_outlined), findsOneWidget);
    expect(find.byIcon(Icons.fitness_center), findsOneWidget);
  });
}
