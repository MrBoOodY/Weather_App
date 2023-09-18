///Basic classes for data analysis
class BaseResponse<T> {
  int? code;
  String? message;
  String? error;
  T? data;
  List<T>? listData = [];

  BaseResponse.fromJson(
    Map<String, dynamic> json, {
    required T Function(Map<String, dynamic> json)? fromJson,
  }) {
    {
      code = json['code'];
      message = json['message'].toString();
      if (json['error'] != null) {
        if (json['error'] is List) {
          error = json['error'].first['message'];
        } else {
          error = json['error']['message'];
        }
      }
      if (json['items'] != null) {
        if (json['items'] is List) {
          for (final item in json['items']) {
            if (fromJson != null) {
              listData!.add(fromJson(item));
            } else {
              listData!.add(item);
            }
          }
          return;
        } else {
          json['item'] = json['items'];
        }
      }
      json = resolveResponseData(json);
      if (json['item'] != null) {
        if (fromJson == null) {
          data = json['item'] as T;
        } else {
          data = fromJson(json['item']);
        }
      }
    }
  }
}

Map<String, dynamic> resolveResponseData(Map<String, dynamic> json) {
  final Map<String, dynamic> newJson = {};
  json.forEach((key, value) {
    switch (key) {
      case 'message':
      case 'cod':
      case 'item':
      case 'error':
      case 'items':
        newJson[key] = value;
        break;

      default:
        if (!newJson.containsKey('item')) {
          newJson['item'] = <String, dynamic>{};
        }
        newJson['item'][key] = value;
    }
  });
  return newJson;
}
