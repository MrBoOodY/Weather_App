import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weath_app/features/home_screen/domain/repositories/home_repository.dart';
import 'package:weath_app/features/home_screen/presentation/view/home_screen.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

class MockLocation extends Mock implements Location {}

void main() {
  late final ProviderContainer container;
  setUpAll(() {
    container = ProviderContainer(overrides: [
      homeRepositoryProvider.overrideWith(
        (ref) => MockHomeRepository(),
      ),
    ]);
  });
  testWidgets('first launch', (tester) async {
    final location = MockLocation();
    when(location.hasPermission)
        .thenAnswer((_) async => PermissionStatus.granted);

    await tester.pumpWidget(
      ProviderScope(
        parent: container,
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    final indicator = find.byType(CircularProgressIndicator);

    expect(indicator, findsOneWidget);
    await tester.pumpAndSettle();

    expect(indicator, findsNothing);
    // final searchButtonField = find.byType(AnimSearchBar);
    // expect(searchButtonField, findsOneWidget);
  });
}
