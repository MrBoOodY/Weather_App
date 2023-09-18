// 🎯 Dart imports:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weath_app/common/errors/failures.dart';
import 'package:weath_app/common/resources/styles_manager.dart';
import 'package:weath_app/common/utils.dart';
import 'package:weath_app/features/widgets/custom_button.dart';

class CustomErrorWidget extends ConsumerWidget {
  const CustomErrorWidget({
    Key? key,
    required this.error,
    this.tryAgainCallback,
  }) : super(key: key);

  final Object error;
  final VoidCallback? tryAgainCallback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            error is! Failure
                ? "Some Thing Went Wrong"
                : ref
                    .read(utilsProvider)
                    .handleFailures(error as Failure, isShowToast: false),
            textAlign: TextAlign.center,
            style: StylesManager.bold(
              color: Colors.red,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 50),
          CustomButton(
            color: Colors.red,
            onPressed: tryAgainCallback,
            child: Text(
              'Try Again',
              style: StylesManager.bold(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
