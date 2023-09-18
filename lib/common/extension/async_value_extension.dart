import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weath_app/common/extension/object_extension.dart';

extension AsyncValueExtension on AsyncValue {
  void handleGuardResults<T>(
      {Function? onSuccess, Function? onError, required dynamic ref}) {
    if (hasError) {
      error!.handleExceptions(ref);
      if (onError != null) {
        onError();
      }
    } else {
      if (onSuccess != null) {
        onSuccess();
      }
    }
  }
}
