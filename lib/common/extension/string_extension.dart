import 'package:weath_app/common/enums.dart';

extension RevisionExtension on String? {
  RevisionType revisionTypeFromJson() {
    return RevisionType.values.firstWhere(
      (element) => element.name == this,
      orElse: () => RevisionType.material,
    );
  }
}
