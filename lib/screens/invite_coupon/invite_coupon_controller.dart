import 'package:get/get.dart';
import 'package:jynx_dj/services/coupon_services.dart';

import 'invite_counpon_page.dart';

class InviteCouponController extends GetxController
    with StateMixin<InviteCouponPage> {
  RxBool isLoading = false.obs;
  String coupon = '';

  @override
  Future<void> onInit() async {
    isLoading.value = true;
    var result = await CouponService().getCoupon();
    coupon = result;
    isLoading.value = false;

    super.onInit();
  }
}
