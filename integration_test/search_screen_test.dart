import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:github_flutter/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Should display Current User Profile',
    (WidgetTester tester) async {
      // Arrange
      // enableFlutterDriverExtension();

      app.main();
      await tester.pumpAndSettle();

      final titleFinder = find.byKey(const ValueKey('input.username'));
      final profileFinder = find.byKey(const ValueKey('button.check'));
      // final descriptionFinder = find.byKey(const ValueKey('input.description'));
      // final saveFinder = find.byKey(const ValueKey('button.save'));

      // Act

      await tester.enterText(titleFinder, 'safwanidrees');
      await tester.pumpAndSettle();

      await tester.tap(profileFinder);
      await tester.pumpAndSettle();

      // await tester.enterText(
      //     descriptionFinder, 'Go to the mall and shop for next month’s stock.');
      // await tester.pumpAndSettle();

      // await tester.tap(saveFinder);
      // await tester.pumpAndSettle();

      // Assert
      await Future.delayed(const Duration(seconds: 3));

      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      expect(find.byKey(const ValueKey("image.user")), findsOneWidget);
      // expect(find.text('Go to the mall and shop for next month’s stock.'),
      //     findsOneWidget);
    },
  );
}
