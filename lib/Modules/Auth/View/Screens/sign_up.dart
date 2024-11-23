import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:talents/Apis/network.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Auth/Cubit/auth_cubit.dart';
import 'package:talents/Modules/Auth/View/Screens/login_screen.dart';
import 'package:talents/Modules/Auth/View/Widgets/auth_scaffold.dart';
import 'package:talents/Modules/Courses/Util/app_functions.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';
import 'package:talents/Modules/Widgets/custom_field.dart';
import 'package:talents/Modules/Home/View/Screens/main_page.dart';

import '../../../Widgets/app_loading.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, this.fromHome = false});
  final bool fromHome;
  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
        body: BlocProvider(
            create: (context) => AuthCubit(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                if (state is SiginUpErrorState) {
                  customSnackBar(
                      context: context, success: 0, message: state.message!);
                } else if (state is SiginUpSuccessState) {
                  Network.init();
                  pushAndRemoveUntiTo(context: context, toPage: const MainPage());
                }
              }, builder: (context, state) {
                final siginUp = AuthCubit.get(context);

                return Form(
                  key: siginUp.formState,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "أهلاً بك في تطبيق مواهب",
                        style: AppTextStyles.titlesMeduim,
                      ),
                      Hero(
                        tag: "tosiginup",
                        child: Text(
                          "إنشاء حساب",
                          style: AppTextStyles.titlesMeduim
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      CustomTextField(
                          nextFocusNode: siginUp.fullNameFocusNode,
                          focusNode: siginUp.userNamseContFocusNode,
                          validatorMessage: "يرجى إدخال اسم المستحدم",
                          label: "اسم المستخدم",
                          controller: siginUp.userNamseCont,
                          iconpreffix: const Icon(
                            Icons.person,
                            color: AppColors.primary,
                          ),
                          keyboardtype: TextInputType.name),
                      SizedBox(height: 3.h),
                      CustomTextField(
                          nextFocusNode: siginUp.residencePlaceFocusNode,
                          focusNode: siginUp.fullNameFocusNode,
                          validatorMessage: "يرجى إدخال الاسم الثلاثي",
                          label: "الاسم الثلاثي",
                          controller: siginUp.fullName,
                          iconpreffix: const Icon(
                            Icons.person,
                            color: AppColors.primary,
                          ),
                          keyboardtype: TextInputType.name),
                      SizedBox(height: 1.h),
                      Text(
                        "يرجى إدخال الاسم الثلاثي كما تريد أن يكتب بالشهادة",
                        style: AppTextStyles.secondTitle,
                      ),
                      SizedBox(height: 2.5.h),
                      CustomTextField(
                        validat: (text) {
                          if (!AppFunctions.isValidDate(text!)){
                         return "2004-8-22 يرجى إضافة تاريخ يشبه الشكل"   ;
                          }
                          return null;
                        },
                         
                        validatorMessage: "يرجى اختيار تاريخ الميلاد ",
                        label: "تاريخ الميلاد",
                        ontap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1947),
                            lastDate: DateTime.now(),
                            initialDatePickerMode: DatePickerMode.year,
                          ).then((value) => {
                                if (value != null)
                                  {
                                    siginUp.birthdayDate.text =
                                        DateFormat("yyyy-MM-dd").format(value)
                                  }
                                else
                                  <String>{siginUp.birthdayDate.text = ""}
                              });
                        },
                        keyboardtype: TextInputType.datetime,
                        controller: siginUp.birthdayDate,
                        iconpreffix: 
                        
                          const Icon(
                            Icons.date_range_outlined,
                            color: AppColors.primary,
                          ),
                  
                      ),
                      SizedBox(height: 3.h),
                      CustomTextField(
                          nextFocusNode: siginUp.emailContFocusNode,
                          focusNode: siginUp.residencePlaceFocusNode,
                          validatorMessage:
                              "يرجى إدخال مكان الإقامة", // to do check its validate
                          label: "مكان الإقامة",
                          controller: siginUp.residencePlace,
                          iconpreffix:   const Icon(
                            Icons.home,
                            color: AppColors.primary,
                          ),
                          keyboardtype: TextInputType.name),
                      SizedBox(height: 3.h),
                      CustomTextField(
                          nextFocusNode: siginUp.phoneNumberFocusNode,
                          focusNode: siginUp.emailContFocusNode,
                          isEmail: true,
                          validatorMessage: "يرجى إدخال البريد الإلكتروني",
                          label: "البريد الإلكتروني",
                          controller: siginUp.emailCont,
                          iconpreffix:   const Icon(
                            Icons.email,
                            color: AppColors.primary,
                          ),
                          keyboardtype: TextInputType.emailAddress),
                      SizedBox(height: 3.h),
                      CustomTextField(
                          nextFocusNode: siginUp.passwordContFocusNode,
                          focusNode: siginUp.phoneNumberFocusNode,
                          validatorMessage: "يرجى إدخال رقم هاتف",
                          isPhoneNum: true,
                          label: "رقم الهاتف",
                          controller: siginUp.phoneNumberCont,
                          iconpreffix:   const Icon(
                            Icons.phone,
                            color: AppColors.primary,
                          ),
                          keyboardtype: TextInputType.phone),
                      SizedBox(height: 3.h),
                      CustomTextField(
                          nextFocusNode: siginUp.confirmPasswordFocusNode,
                          focusNode: siginUp.passwordContFocusNode,
                          isPassword: true,
                          validatorMessage: "يرجى إدخال كلمة مرور",
                          label: "كلمة المرور",
                          controller: siginUp.passwordCont,
                          iconpreffix:    const Icon(
                            Icons.lock,
                            color: AppColors.primary,
                          ), 
                          keyboardtype: TextInputType.visiblePassword),
                      SizedBox(height: 3.h),
                      CustomTextField(
                          nextFocusNode: null,
                          focusNode: siginUp.confirmPasswordFocusNode,
                          isPassword: true,
                          validat: (value) {
                            if (value!.isEmpty) {
                              return "يرجى تأكيد كلمة المرور";
                            }
                            if (siginUp.passwordCont.text !=
                                siginUp.confirmPasswordCont.text) {
                              return "كلمات المرور غير متطابقة";
                            }
                            return null;
                          },
                          label: "تأكيد كلمة المرور",
                          controller: siginUp.confirmPasswordCont,
                          iconpreffix:  const Icon(
                            Icons.lock,
                            color: AppColors.primary,
                          ), 
                          keyboardtype: TextInputType.visiblePassword),
                      SizedBox(height: 6.h),
                      (state is! SiginUpLoadingState)
                          ? CustomButton(
                              titlebutton: "إنشاء حساب",
                              onPressed: () {
                                siginUp.createAccount();
                              })
                          : const AppLoading(),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'هل لديك حساب؟ ',
                            style: AppTextStyles.secondTitle,
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              if (fromHome) {
                                pushAndRemoveUntiTo(
                                    context: context, toPage: const LoginScreen());
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                            child: Hero(
                              tag: "tologinword",
                              child: Text('تسجيل الدخول',
                                  style: AppTextStyles.secondTitle.copyWith(
                                      color: AppColors.primary,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.primary)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 4.h),
                    ],
                  ),
                );
              }),
            )));
  }
}
