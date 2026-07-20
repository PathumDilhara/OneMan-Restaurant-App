import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final Logger appLogger = Logger(
  // level: Level.off
  level: kReleaseMode ? Level.error : Level.debug,
);
