import 'package:get/get.dart';

import 'dulcineaController.dart';

class QuijoteBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => QuijoteController());
  }
}