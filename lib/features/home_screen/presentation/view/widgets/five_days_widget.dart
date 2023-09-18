import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weath_app/common/extension/date_time.dart';
import 'package:weath_app/common/extension/double_extension.dart';
import 'package:weath_app/common/resources/app_colors.dart';
import 'package:weath_app/common/resources/styles_manager.dart';
import 'package:weath_app/features/home_screen/data/model/five_days_model.dart';
import 'package:weath_app/features/home_screen/presentation/controller/home_controller.dart';
import 'package:weath_app/features/widgets/cached_image.dart';

class FiveDaysWidget extends StatelessWidget {
  final ForecastDay forecastDay;

  const FiveDaysWidget({Key? key, required this.forecastDay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        shadowColor: AppColors.mainColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                forecastDay.date.formatToDate(),
              ),
              Text(
                forecastDay.day.condition.text.toUpperCase(),
                style: StylesManager.bold(color: Colors.grey),
              ),
              CachedImageWidget(
                image: forecastDay.day.condition.iconFixedLink,
                height: 60,
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer(
                builder: (context, ref, child) {
                  final isCelsius = ref.watch(homeControllerProvider
                      .select((value) => value.requireValue.isCelsius));
                  return Column(
                    children: [
                      Text(
                        forecastDay.day
                            .getAvgTempByCondition(isCelsius)
                            .toTemperature(isCelsius),
                        style: StylesManager.bold(color: AppColors.mainColor),
                      ),
                      Text(
                        'Min: ${forecastDay.day.getMinTempByCondition(isCelsius).toTemperature(isCelsius)} / Max: ${forecastDay.day.getMaxTempByCondition(isCelsius).toTemperature(isCelsius)}',
                        style: StylesManager.bold(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  );
                },
              ),
              Text(
                'Wind: ${forecastDay.day.maxwind_kph} K/Hour',
                style: StylesManager.bold(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
