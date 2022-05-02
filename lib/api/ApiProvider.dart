import 'package:get/get.dart';

import '../model/MenuDetails.dart';

class ApiProvider extends GetConnect {
  Future<Response<List<MenuDetails>>> getMenuDetails() =>
      get('https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad',
      decoder: (obj){
       return (obj as List<dynamic>)
            .map((e) => MenuDetails.fromJson(e)).toList(growable: false);
      });
}
