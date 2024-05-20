import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:project_demo_t/core/constants/size.dart';

class AppToast {
  AppToast._();

  static void showToast() {
    BotToast.showCustomText(
      toastBuilder: (cancelFunc) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.s20),
          child: Container(
            height: Sizes.s50,
            // margin: EdgeInsets.only(bottom: Sizes.s10),
            // padding: EdgeInsets.symmetric(horizontal: Sizes.s35),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(Sizes.s10),
            ),
            child: const Center(
              child: Text(
                'Something Went Wrong',
                // message,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.s13,
                    fontWeight: FontWeight.w600,
                    height: 1.5),
              ),
            ),
          ),
        );
      },
    );
  }
}
