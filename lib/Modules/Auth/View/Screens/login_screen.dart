import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Apis/network.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Auth/Cubit/auth_cubit.dart';
import 'package:talents/Modules/Auth/View/Screens/forget_password.dart';
import 'package:talents/Modules/Auth/View/Screens/sign_up.dart';
import 'package:talents/Modules/Auth/View/Widgets/auth_scaffold.dart';
import 'package:talents/Modules/Home/Cubit/cubit/main_page_cubit.dart';
import 'package:talents/Modules/Home/View/Screens/main_page.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';
import 'package:talents/Modules/Widgets/custom_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
        tag: "tologin",
        body: BlocProvider(
            create: (context) => AuthCubit(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                if (state is LoginErrorState) {
                  customSnackBar(
                      context: context, success: 0, message: state.message!);
                } else if (state is LoginSuccessState) {
                  Network.init();
                  context.read<MainPageCubit>().moveTab(0);

                  pushAndRemoveUntiTo(context: context, toPage: const MainPage());
                }
              }, builder: (context, state) {
                final login = AuthCubit.get(context);

                return Form(
                  key: login.formState,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "أهلاً بك في تطبيق مواهب",
                        style: AppTextStyles.titlesMeduim,
                      ),
                      Hero(
                        tag: "tologinword",
                        child: Text(
                          "تسجيل دخول",
                          style: AppTextStyles.titlesMeduim
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      CustomTextField(
                          // isEmail: true,
                          validat: (p0) {
                            return null;
                          },
                          focusNode: login.emailORrhoneOrNameFocusNode,
                          nextFocusNode: login.passwordFocusNode,
                          label: "البريد الالكتروني/اسم المستخدم/رقم الموبايل",
                          controller: login.emailORrhoneOrNameCont,
                          iconpreffix: const Icon(
                            Icons.email_rounded,
                            color: AppColors.primary,
                          ),
                          keyboardtype: TextInputType.emailAddress),
                      SizedBox(height: 3.h),
                      CustomTextField(
                          focusNode: login.passwordFocusNode,
                          validatorMessage: "يرجى إدخال كلمة المرور",
                          isPassword: true,
                          label: "كلمة المرور",
                          controller: login.passwordCont,
                          iconpreffix:   const Icon(
                         Icons.lock,
                            color: AppColors.primary,
                          ), 
                          keyboardtype: TextInputType.visiblePassword),
                      SizedBox(height: 2.h),
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          Navigator.of(context).push(
                            PageTransition(
                                child: const ForgetPassword(),
                                type: PageTransitionType.rightToLeft,
                                duration: const Duration(milliseconds: 400)),
                          );
                        },
                        child: Hero(
                          tag: "forgetpass",
                          child: Text(
                            "هل نسيت كلمة المرور؟",
                            style: AppTextStyles.secondTitle.copyWith(
                                decoration: TextDecoration.underline,
                                fontSize: 9.sp),
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      (state is! LoginLoadingState)
                          ? CustomButton(
                              titlebutton: "تسجيل دخول",
                              onPressed: () {
                                // AppSharedPreferences.saveToken(
                                //     " {userModel?.data?.user?.token}");
                                // AppSharedPreferences.removeIsGuest();

                                login.login();
                              })
                          : const AppLoading(),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'ليس لديك حساب؟ ',
                            style: AppTextStyles.secondTitle,
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              pushTo(context: context, toPage: const SignUpScreen());
                            },
                            child: Hero(
                              tag: "tosiginup",
                              child: Text('إنشاء حساب',
                                  style: AppTextStyles.secondTitle.copyWith(
                                      color: AppColors.primary,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.primary)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            // AppSharedPreferences.saveIsGuest(true);
                            pushAndRemoveUntiTo(
                                context: context, toPage: const MainPage());
                          },
                          child: Text('الدخول كزائر',
                              style: AppTextStyles.secondTitle.copyWith(
                                  color: AppColors.primary,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primary)),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            )));
  }
}
