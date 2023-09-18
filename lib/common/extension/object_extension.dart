import 'package:weath_app/common/errors/failures.dart';
import 'package:weath_app/common/utils.dart';

extension ObjectExtension on Object? {
  handleExceptions(dynamic ref) {
    final Utils utils = ref.read(utilsProvider);
    if (this is Failure) {
      utils.handleFailures(this as Failure);
    } else {
      utils.showErrorToast(toString());
    }
  }
}
