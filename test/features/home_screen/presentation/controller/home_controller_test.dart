import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weath_app/common/services/location_service/location_service.dart';
import 'package:weath_app/features/home_screen/domain/repositories/home_repository.dart';
import 'package:weath_app/features/home_screen/presentation/controller/home_controller.dart';

import '../../../../fixtures/fixture_location_data.dart';

class Listener<T> extends Mock {
  void call(T? previous, T value);
}

class MockHomeRepository extends Mock implements HomeRepository {}

class MockLocationService extends Mock implements LocationService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('lat long granted successfully', () {
    late final ProviderContainer container;
    late final LocationService locationService;
    late final Listener<AsyncValue<HomeState>> listener;
    setUpAll(() {
      listener = Listener<AsyncValue<HomeState>>();
      container = ProviderContainer(
        overrides: [
          locationServiceProvider.overrideWith((ref) => MockLocationService()),
          determinePositionProvider.overrideWith((ref) => null)
        ],
      )..listen(
          homeControllerProvider,
          listener.call,
          fireImmediately: true,
        );
      locationService = container.read(locationServiceProvider);
      registerFallbackValue(AsyncData<HomeState>(HomeState()));
      registerFallbackValue(const AsyncLoading<HomeState>());
      when(locationService.serviceEnabled).thenAnswer((_) async => true);
      when(locationService.hasPermission)
          .thenAnswer((_) async => PermissionStatus.granted);
      when(locationService.getLocation)
          .thenAnswer((_) async => testLocationData);
    });
    test('first state should be HomeState then AsyncLoading', () async {
      final homeController =
          await container.read(homeControllerProvider.future);

      // verify

      verifyInOrder([
        () => listener(null, any(that: isA<AsyncData<HomeState>>())),
        () => listener(any(that: isA<AsyncData<HomeState>>()),
            const AsyncLoading<HomeState>()),
      ]);

      expect(homeController.currentWeather, isNotNull);
    });
  });
}
