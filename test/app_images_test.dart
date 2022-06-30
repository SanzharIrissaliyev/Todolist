import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:todolistdb/resources/resources.dart';

void main() {
  test('app_images assets test', () {
    expect(File(AppImages.backgroundblue).existsSync(), true);
  });
}
