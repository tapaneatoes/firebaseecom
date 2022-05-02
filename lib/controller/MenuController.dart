import 'package:firebaseecom/api/ApiProvider.dart';
import 'package:firebaseecom/model/MenuDetails.dart';
import 'package:get/get.dart';

class MenuController extends GetxController with StateMixin<List<MenuDetails>> {
  final ApiProvider apiProvider;

  MenuController({required this.apiProvider});

  @override
  void onInit() {
    getMenuDetails();
    super.onInit();
  }

  void getMenuDetails() {
    apiProvider
        .getMenuDetails()
        .then((value) => {change(value.body, status: RxStatus.success())})
        .onError(
            (error, stackTrace) => {change(null, status: RxStatus.error())});
  }
}
