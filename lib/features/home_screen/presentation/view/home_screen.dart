import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weath_app/common/resources/app_colors.dart';
import 'package:weath_app/common/resources/styles_manager.dart';
import 'package:weath_app/features/widgets/custom_error_widget.dart';

import '../controller/home_controller.dart';
import 'widgets/five_days_widget.dart';
import 'widgets/home_header.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading =
        ref.watch(homeControllerProvider.select((value) => value.isLoading));
    final state = ref.read(homeControllerProvider);
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    } else if (state.hasError && !state.hasValue) {
      return Scaffold(
        body: CustomErrorWidget(
          error: state.error!,
          tryAgainCallback: () => ref.refresh(homeControllerProvider),
        ),
      );
    }
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            const HomeHeader(),
            const SizedBox(
              height: 10,
            ),
            Text(
              '5-days forecast',
              style: StylesManager.bold(color: AppColors.mainColor),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 230,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state
                    .requireValue.currentWeather?.forecast.forecastday.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return FiveDaysWidget(
                    forecastDay: state.requireValue.currentWeather!.forecast
                        .forecastday[index],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
