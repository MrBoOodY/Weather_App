import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weath_app/common/extension/date_time.dart';
import 'package:weath_app/common/extension/double_extension.dart';
import 'package:weath_app/common/resources/app_colors.dart';
import 'package:weath_app/common/resources/styles_manager.dart';
import 'package:weath_app/features/home_screen/presentation/controller/home_controller.dart';
import 'package:weath_app/features/widgets/cached_image.dart';

import '../../../../widgets/animated_image.dart';

class HomeHeader extends ConsumerStatefulWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends ConsumerState<HomeHeader> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentWeather = ref.watch(
      homeControllerProvider.select(
        (value) => value.requireValue.currentWeather,
      ),
    );

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.45,
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.41,
            child: const Card(
              elevation: 5,
              shadowColor: AppColors.mainColor,
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: AnimatedImage(
                imageUrl:
                    'https://img.freepik.com/free-photo/cloud-blue-sky_1232-3108.jpg?w=1800&t=st=1685811567~exp=1685812167~hmac=9adaabe5c78995b3cda4579825a2b90f460d4c89bdac93421a403fcc178f52b1',
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: Row(
              children: [
                AnimSearchBar(
                  prefixIcon: const Icon(IconlyBroken.search),
                  width: MediaQuery.sizeOf(context).width * 0.65,
                  textController: textController,
                  suffixIcon: const Icon(IconlyBroken.send),
                  closeSearchOnSuffixTap: false,
                  color: Theme.of(context).cardColor,
                  onSuffixTap: () {
                    ref
                        .read(homeControllerProvider.notifier)
                        .searchByCity(textController.text);
                  },
                  onSubmitted:
                      ref.read(homeControllerProvider.notifier).searchByCity,
                ),
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: IconButton(
                    onPressed: () => ref
                        .read(homeControllerProvider.notifier)
                        .searchByCity(''),
                    icon: const Icon(Icons.location_on_outlined),
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Consumer(
                    builder: (context, ref, child) {
                      final isCelsius = ref.watch(homeControllerProvider
                          .select((value) => value.requireValue.isCelsius));
                      return IconButton(
                        onPressed: ref
                            .read(homeControllerProvider.notifier)
                            .changeTempMode,
                        icon: isCelsius
                            ? const Text('\u2103')
                            : const Text('\u2109'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Text(
                              currentWeather?.location.name.toUpperCase() ??
                                  'N/A',
                              style: StylesManager.regular(fontSize: 20),
                            ),
                          ),
                          Center(
                            child: Text(
                              DateTime.now().formatToDate(),
                              style: StylesManager.regular(),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Consumer(
                        builder: (context, ref, child) {
                          final isCelsius = ref.watch(homeControllerProvider
                              .select((value) => value.requireValue.isCelsius));

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                      currentWeather?.current.condition.text
                                              .toUpperCase() ??
                                          'N/A',
                                      style:
                                          StylesManager.regular(fontSize: 20)),
                                  const SizedBox(height: 10),
                                  Text(
                                    (currentWeather?.current
                                            .getTempByCondition(isCelsius))
                                        .toTemperature(isCelsius),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!,
                                  ),
                                  Text(
                                    'Min: ${currentWeather?.forecast.forecastday.first.day.getMinTempByCondition(isCelsius).toTemperature(isCelsius)} / Max: ${currentWeather?.forecast.forecastday.first.day.getMaxTempByCondition(isCelsius).toTemperature(isCelsius)}',
                                    style: StylesManager.bold(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                      'Humidity: ${currentWeather?.current.humidity}%'),
                                  CachedImageWidget(
                                    image: currentWeather
                                            ?.current.condition.iconFixedLink ??
                                        '',
                                    width: 80,
                                    height: 80,
                                  ),
                                  Text(
                                    'Wind: ${currentWeather?.current.wind_kph ?? 'N/A'} K/Hour',
                                    style: StylesManager.bold(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
