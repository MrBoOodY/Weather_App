import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class Log {
  static const perform = MethodChannel("x_log");

  static var logger = Logger();

  /// Log a message at level [Level.debug].
  static d(String msg, {tag = 'X-LOG'}) {
    logger.d(msg);
  }

  /// Log a message at level [Level.warning].
  static w(String msg, {tag = 'X-LOG'}) {
    logger.w(msg);
  }

  /// Log a message at level [Level.info].
  static i(String msg, {tag = 'X-LOG'}) {
    logger.i(msg);
  }

  /// Log a message at level [Level.error].
  static e(String msg, {tag = 'X-LOG'}) {
    logger.e(msg);
  }

  /// Log a message at level [Level.wtf].
  static json(String msg, {tag = 'X-LOG'}) {
    try {
      logger.wtf(msg);
    } catch (e) {
      d(msg);
    }
  }
}
