 import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Auth/Cubit/auth_cubit.dart';
  import 'package:talents/Modules/Auth/View/Screens/reset_password.dart';
import 'package:talents/Modules/Auth/View/Widgets/auth_scaffold.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';

class OtpCode extends StatelessWidget {
  const OtpCode({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
        body: BlocProvider(
            create: (context) => AuthCubit(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                if (state is CheckCodeErrorState) {
                  customSnackBar(
                      context: context, success: 0, message: state.message);
                } else if (state is GetCodeSuccessState) {
                  customSnackBar(
                      context: context,
                      success: 1,
                      message: "تم إرسال الرمز بنجاح");
                }

                if (state is CheckCodeErrorState) {
                  customSnackBar(
                      context: context, success: 0, message: state.message);
                } else if (state is CheckCodeSuccessState) {
                  if (state.isValid) {
                    pushTo(
                        context: context,
                        toPage: ResetPassword(
                          email: email,
                          verificationCode:
                              context.read<AuthCubit>().otpCode.text,
                        ));
                  } else {
                    customSnackBar(
                        context: context,
                        success: 0,
                        message: "الرمز المدخل غير صحيح");
                  }
                }
              }, builder: (context, state) {
                final forgetPassword = AuthCubit.get(context);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "نسيت كلمة المرور",
                      style: AppTextStyles.titlesMeduim
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 1.h),
                    Hero(
                      tag: "otp",
                      child: Text(
                        "لقد تم ارسال رمز إلى بريدك الالكتروني",
                        style:
                            AppTextStyles.secondTitle.copyWith(fontSize: 11.sp),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Align(
                      alignment: Alignment.center,
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: OTPField(
                            email: email, forgetPassword: forgetPassword),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'لم أتلقى الرمز  ',
                          style: AppTextStyles.secondTitle,
                        ),
                        //

                        Wait(email: email)
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Hero(
                      tag: "respass",
                      child: Material(
                        child: state is! CheckCodeLoadingState
                            ? CustomButton(
                                titlebutton: "تأكيد الرمز",
                                onPressed: () {
                                  if (forgetPassword.otpCode.text.length < 4) {
                                    customSnackBar(
                                        context: context,
                                        success: 0,
                                        message: "يرجى إدخال الرمز");
                                  } else {
                                    forgetPassword.checkCode(email: email);
                                  }
                                })
                            : const AppLoading(),
                      ),
                    ),
                    SizedBox(height: 4.h),
                  ],
                );
              }),
            )));
  }
}

class Wait extends StatefulWidget {
  const Wait({super.key, required this.email});

  final String email;
  @override
  _WaitState createState() => _WaitState();
}

int seconds = 59;
bool buttonActivate = false;
Timer? _timer;

class _WaitState extends State<Wait> {
  @override
  void initState() {
    print("object");
    resend();

    super.initState();
  }

  void resend() {
    buttonActivate = false;
    if (mounted) setState(() {});

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (seconds > 0) {
          seconds--;
          if (mounted) setState(() {});
          // print(seconds);
        } else if (seconds == 0) {
          seconds = 59;
          _timer?.cancel();
          buttonActivate = true;
          if (mounted) setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: buttonActivate
          ? () {
              resend();
              context.read<AuthCubit>().getCode(email: widget.email);
            }
          : null,
      child: Text(buttonActivate ? 'إعادة إرسال' : " انتظر $seconds ثانية",
          style: AppTextStyles.secondTitle.copyWith(
              color: AppColors.primary,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primary)),
    );
  }
}

class OTPField extends StatelessWidget {
  const OTPField({
    super.key,
    required this.forgetPassword,
    required this.email,
  });

  final AuthCubit forgetPassword;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: forgetPassword.otpCode,
      length: 4,
      defaultPinTheme: PinTheme(
          margin: EdgeInsets.only(left: 5.w),
          height: 6.5.h,
          width: 6.5.h,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(15))),
      submittedPinTheme: PinTheme(
          margin: EdgeInsets.only(left: 5.w),
          height: 6.5.h,
          width: 6.5.h,
          decoration: BoxDecoration(
              color: const Color.fromARGB(29, 33, 149, 243),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 1, color: AppColors.primary))),
      errorPinTheme: PinTheme(
          margin: EdgeInsets.only(left: 5.w),
          height: 6.5.h,
          width: 6.5.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 1, color: Colors.red))),
      focusedPinTheme: PinTheme(
          margin: EdgeInsets.only(left: 5.w),
          height: 6.5.h,
          width: 6.5.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 1, color: AppColors.primary))),
      useNativeKeyboard: true,
      onCompleted: (value) {
        forgetPassword.checkCode(email: email);
      },
      errorTextStyle: AppTextStyles.titlesMeduim.copyWith(color: Colors.red),
    );
  }
}
