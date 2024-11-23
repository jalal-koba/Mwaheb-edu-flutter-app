import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Home/View/Screens/main_page.dart';
 import 'package:talents/Modules/Widgets/custom_button.dart';

class SuccessGetCertificateDialog extends StatelessWidget {
  const SuccessGetCertificateDialog({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.primary, width: 1)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                textAlign: TextAlign.center,
                'تم ارسال طلبك بنجاح, سيتم إرسال الشهادة إليك قريباً',
                style: AppTextStyles.largeTitle,
              ),
              SizedBox(  height: 5.h),
              CustomButton(
                  height: 6,
                  fontSize: 12,
                  titlebutton: "العودة الى الصفحة الرئيسية",
                  onPressed: () {
                    pushAndRemoveUntiTo(
                        context: context, toPage: const MainPage());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
