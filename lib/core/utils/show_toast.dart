import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType {
  success,
  error,
}

showToast({
  required String message,
  required BuildContext context,
  required ToastType type,
}) {
  FToast fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.black,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          type == ToastType.error
              ? "assets/images/toast_fail.png"
              : "assets/images/toast_win.png",
          height: 20,
          width: 20,
        ),
        const SizedBox(
          width: 12.0,
        ),
        // Expanded(
        //   child: Text(
        //     message,
        //     overflow: TextOverflow.ellipsis,
        //     style: TextStyle(
        //       color: AppColor.whiteColor,
        //       fontSize: 14.sp,
        //     ),
        //   ),
        // )
        // make the text fit
        Expanded(
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              message,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.TOP,
    toastDuration: const Duration(seconds: 2),
  );
}
