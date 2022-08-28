import 'package:firefight_equip/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('widget test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    await tester.tap(find.byIcon(Icons.web_rounded));
    await tester.pump();

    // expect(find.byIcon(Icons.fire_extinguisher), findsOneWidget);
  });
}
