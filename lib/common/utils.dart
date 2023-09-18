import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weath_app/common/errors/failures.dart';
import 'package:weath_app/common/resources/styles_manager.dart';
import 'package:weath_app/common/route/app_router.dart';

part 'utils.g.dart';

@riverpod
Utils utils(UtilsRef ref) {
  return Utils(ref);
}

class Utils {
  final UtilsRef ref;
  late final BuildContext context;
  Utils(this.ref) {
    context = ref.watch(contextProvider);
  }

  void showToast(String text,
          {Color? borderColor, Color? textColor, int? duration}) =>
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            width: MediaQuery.sizeOf(context).width - 50,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: duration ?? 4),
            content: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: borderColor ?? Colors.green.withOpacity(0.7),
                ),
              ),
              elevation: 3,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 22, end: 32, top: 22, bottom: 22),
                    child: Text(
                      text,
                      style: StylesManager.medium(
                        color: textColor ?? Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.zero,
          ),
        );
      });

  void showErrorToast(String text, {int? duration}) =>
      showToast(text, borderColor: Colors.red.withOpacity(0.7));

  String handleFailures(Failure failure, {bool isShowToast = true}) {
    switch (failure.runtimeType) {
      // case UnVerifiedFailure:
      //   ref.read(appRouterProvider).goToSignInPage();
      //   break;
      case ConnectionFailure:
        if (isShowToast) {
          showErrorToast("Internet is Disconnected");
        }
        return 'Internet is Disconnected';
      case LocationPermissionFailure:
        if (isShowToast) {
          showErrorToast("Please Enable Location Service");
        }
        return 'Please Enable Location Service';
      case UnAuthorizedFailure:
        // ref.read(appRouterProvider).goToSignInPage();
        // ref.read(authProvider.notifier).resetUser();
        if (isShowToast) {
          showErrorToast(failure.message);
        }

        return failure.message;
      case ServerFailure:
        if (isShowToast) {
          showErrorToast(failure.message);
        }

        return failure.message;

      default:
        if (isShowToast) {
          showErrorToast('SomeThing Went Wrong');
        }
        return 'SomeThing Went Wrong';
    }
  }

  /// method for hide loading
  void hideLoading() {
    Navigator.pop(context);
  }

  /// method for show loading
  void showLoading() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return WillPopScope(
          onWillPop: () async => false,
          child: const AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              height: 350,
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          ),
        );
      },
    );
  }
}
