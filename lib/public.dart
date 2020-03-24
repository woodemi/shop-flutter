import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';

bool hadLoadDeafult = false;
loadDeafultData() async {
  if (hadLoadDeafult) {
    return;
  }
  hadLoadDeafult = true;
  Logger.root.onRecord.listen((LogRecord rec) {
    debugPrint('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
