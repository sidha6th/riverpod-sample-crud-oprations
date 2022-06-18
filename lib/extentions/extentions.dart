import 'package:flutter/cupertino.dart';

extension MediaQuerySize on BuildContext {
  Size getsize() => MediaQuery.of(this).size;
}
