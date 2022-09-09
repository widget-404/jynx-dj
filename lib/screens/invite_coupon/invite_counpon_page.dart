import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import 'invite_coupon_controller.dart';

class InviteCouponPage extends GetView<InviteCouponController> {
  const InviteCouponPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF1B5BA1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B5BA1),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Coupons',
          style: GoogleFonts.montserrat().copyWith(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: getBody(size, context),
    );
  }

  getBody(size, context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Invite Coupons',
            style: GoogleFonts.montserrat().copyWith(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(() {
            return controller.isLoading.value
                ? const CircularProgressIndicator()
                : Text(controller.coupon,
                    style: GoogleFonts.montserrat()
                        .copyWith(fontSize: 18, color: Colors.white));
          }),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              if (controller.coupon.isNotEmpty) {
                openShareDialog(size, context);
              }
            },
            child: Container(
              width: size.width * 0.6,
              height: size.height * 0.075,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: const Color(0xFF143B66)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text('Share',
                      style: GoogleFonts.montserrat()
                          .copyWith(fontSize: 18, color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  openShareDialog(sizes, context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.white30,
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (ctx, anim1, anim2) => AlertDialog(
        title: Center(
          child: Text(
            'Coupon Code',
            style: GoogleFonts.montserrat()
                .copyWith(fontSize: 24, color: Color(0xFF143B66)),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Hey Use this promo coupon . Share it with Friends and give them free entrance.',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat()
                  .copyWith(fontSize: 16, color: Color(0xFF143B66)),
            ),
          ],
        ),
        actions: [
          Center(
            child: GestureDetector(
              onTap: () async {
                final box = context.findRenderObject() as RenderBox?;

                await Share.share(
                  controller.coupon,
                  sharePositionOrigin:
                      box!.localToGlobal(Offset.zero) & box.size,
                );
              },
              child: Container(
                width: sizes.width * 0.6,
                height: sizes.height * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white70,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12, blurRadius: 2, spreadRadius: 4),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(controller.coupon,
                        style: GoogleFonts.montserrat()
                            .copyWith(fontSize: 18, color: Color(0xFF143B66))),
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(
                      Icons.share,
                      color: Color(0xFF143B66),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        backgroundColor: Colors.white,
        buttonPadding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 10,
        ),
        actionsPadding: EdgeInsets.symmetric(vertical: 20),
      ),
    );
  }
}
