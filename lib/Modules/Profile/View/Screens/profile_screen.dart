import 'dart:io';

import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Helper/app_sharedPreferance.dart';
import 'package:talents/Modules/Auth/View/Screens/login_screen.dart';
import 'package:talents/Modules/Home/View/Screens/image_viewer.dart';
import 'package:talents/Modules/Profile/Cubit/cubit/profile_cubit.dart';
import 'package:talents/Modules/Profile/Cubit/state/profile_state.dart';
import 'package:talents/Modules/Profile/View/Screens/change_password_screen.dart';
import 'package:talents/Modules/Widgets/app_loading.dart';
import 'package:talents/Modules/Widgets/cached_image.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';
import 'package:talents/Modules/Widgets/custom_field.dart';
import 'package:talents/Modules/Widgets/register_firstly.dart';

import '../../../Widgets/try_agin.dart';
import '../Widgets/profile_shimmer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    if (AppSharedPreferences.hasToken &&
        AppSharedPreferences.getToken != null &&
        !context.read<ProfileCubit>().isEdit) {
      // to do
      context.read<ProfileCubit>().getProfileInfo();
    }
    return SlideInRight(
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is UnAuthenticatedState) {
            AppSharedPreferences.removeToken;
            pushAndRemoveUntiTo(context: context, toPage: const LoginScreen());
          }
          if (state is ProfileErrorState) {
            customSnackBar(
                context: context, message: state.message, success: 0);
          }
          if (state is ProfileEditingErrorState) {
            customSnackBar(
                context: context, message: state.message, success: 0);
          }

          if (state is ProfileEditingSuccessState) {
            customSnackBar(
                context: context,
                message: "تم تعديل الملف الشخصي بنجاح",
                success: 1);
          }
        },
        builder: (context, state) {
          final ProfileCubit profileCubit = ProfileCubit.get(context);

          if (!AppSharedPreferences.hasToken) {
            return const RegisterFirstly();
          }

          if (state is ProfileErrorState) {
            return TryAgain(
              message: state.message,
              onTap: () {
                profileCubit.getProfileInfo();
              },
            );
          }

          if (state is ProfileLoadingState) {
            return const ProfileShimmer();
          }

          return Form(
            key: profileCubit.formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              children: [
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    alignment:
                        Alignment.bottomLeft, // to do make it more porformance
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        width: 35.w,
                        height: 35.w,
                        decoration: BoxDecoration(
                          boxShadow: blueBoxShadow,
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                        child: profileCubit.userPhotoFile != null
                            ? Image.file(
                                fit: BoxFit.cover,
                                File(profileCubit.userPhotoFile!
                                    .path)) // to show dialog in this case motier the image
                            : profileCubit.userPhotoUrl != null
                                ? InkWell(
                                    onTap: () {
                                      pushTo(
                                          context: context,
                                          toPage: ImageViewer(
                                              imageUrl:
                                                  profileCubit.userPhotoUrl!));
                                    },
                                    child: CachedImage(
                                        isPerson: true,
                                        imageUrl: profileCubit.userPhotoUrl),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      profileCubit // to do
                                          .showPicker(context);
                                      print("objectaaaaaaaaaaaaaaa");

                                      profileCubit.editProfile();
                                    },
                                    icon: Icon(
                                      Icons.add_photo_alternate,
                                      size: 50.sp,
                                      color: AppColors.secondary,
                                    )),
                      ),
                      if (profileCubit.isEdit &&
                          (profileCubit.userPhotoUrl != null ||
                              profileCubit.userPhotoFile != null))
                        ElasticIn(
                          child: IconButton(
                              style: IconButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(181, 0, 101, 190)),
                              onPressed: () {
                                profileCubit.showPicker(context);
                              },
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                              )),
                        ),
                      if (profileCubit.isEdit &&
                          (profileCubit.userPhotoUrl != null ||
                              profileCubit.userPhotoFile != null))
                        Positioned(
                            right: 0,
                            child: ElasticIn(
                              child: IconButton(
                                  style: IconButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          162, 244, 67, 54)),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            DeleteUserImageDialog(
                                                profileCubit: profileCubit));
                                  },
                                  icon: const Icon(
                                    Icons.restore_from_trash,
                                    color: Colors.white,
                                  )),
                            ))
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                if (!profileCubit.isEdit)
                  SlideInUp(
                    child: CustomButton(
                        fontSize: 12,
                        width: 60,
                        titlebutton: "تعديل الملف الشخصي",
                        onPressed: () {
                          profileCubit.editProfile();
                        }),
                  ),
                if (!profileCubit.isEdit) SizedBox(height: 4.h),
                CustomTextField(
                    validatorMessage: "يرجى إدخال اسم المستحدم",
                    edit: profileCubit.isEdit,
                    readonly: !profileCubit.isEdit,
                    label: "اسم المستخدم",
                    controller: profileCubit.userNamseCont,
                    iconpreffix: const Icon(
                      Icons.person,
                      color: AppColors.primary,
                    ),
                    keyboardtype: TextInputType.name),
                SizedBox(height: 2.5.h),
                CustomTextField(
                    validat: (value) {
                      if (value!.length < 3) {
                        return "الاسم الثلاثي يجب أن يكون أكثر من 3 أحرف";
                      }
                      return null;
                    },
                    validatorMessage: "يرجى إدخال الاسم الثلاثي",
                    edit: profileCubit.isEdit,
                    readonly: !profileCubit.isEdit,
                    label: "الاسم الثلاثي",
                    controller: profileCubit.fullName,
                    iconpreffix: const Icon(
                      Icons.person,
                      color: AppColors.primary,
                    ),
                    keyboardtype: TextInputType.name),
                SizedBox(height: 2.5.h),
                CustomTextField(
                  edit: profileCubit.isEdit,
                  readonly: !profileCubit.isEdit,
                  validatorMessage: "يرجى اختيار تاريخ الميلاد ",
                  label: "تاريخ الميلاد",
                  ontap: () {
                    if (profileCubit.isEdit) {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1947),
                        lastDate: DateTime.now(),
                        initialDatePickerMode: DatePickerMode.year,
                      ).then((value) => {
                            if (value != null)
                              {
                                profileCubit.birthdayDate.text =
                                    DateFormat("yyyy-MM-dd").format(value)
                              }
                            else
                              {profileCubit.birthdayDate.text = ""}
                          });
                    }
                  },
                  keyboardtype: TextInputType.datetime,
                  controller: profileCubit.birthdayDate,
                  iconpreffix: const Icon(
                    Icons.date_range_outlined,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 2.5.h),
                CustomTextField(
                    edit: profileCubit.isEdit,
                    readonly: !profileCubit.isEdit,
                    nextFocusNode: profileCubit.emailContFocusNode,
                    focusNode: profileCubit.residencePlaceFocusNode,
                    validatorMessage:
                        "يرجى إدخال مكان الإقامة", // to do check its validate
                    label: "مكان الإقامة",
                    controller: profileCubit.residencePlace,
                    iconpreffix: const Icon(
                      Icons.home,
                      color: AppColors.primary,
                    ),
                    keyboardtype: TextInputType.name),
                SizedBox(height: 2.5.h),
                CustomTextField(
                    validatorMessage: "يرجى إدخال البريد الإلكتروني",
                    edit: profileCubit.isEdit,
                    readonly: !profileCubit.isEdit,
                    isEmail: true,
                    label: "البريد الإلكتروني",
                    controller: profileCubit.emailCont,
                    iconpreffix: const Icon(
                      Icons.email,
                      color: AppColors.primary,
                    ),
                    keyboardtype: TextInputType.emailAddress),
                SizedBox(height: 2.5.h),
                CustomTextField(
                    validatorMessage: "يرجى إدخال رقم هاتف",
                    edit: profileCubit.isEdit,
                    readonly: !profileCubit.isEdit,
                    isPhoneNum: true,
                    label: "رقم الهاتف",
                    controller: profileCubit.phoneNumberCont,
                    iconpreffix: const Icon(
                      Icons.phone,
                      color: AppColors.primary,
                    ),
                    keyboardtype: TextInputType.phone),
                SizedBox(height: 2.5.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: CustomTextField(
                          readonly: true,
                          isvisible: true,
                          enabled: false,
                          label: "كلمة المرور",
                          controller: profileCubit.passwordCont,
                          iconpreffix: const Icon(
                            Icons.lock,
                            color: AppColors.primary,
                          ),
                          keyboardtype: TextInputType.visiblePassword),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    if (profileCubit.isEdit)
                      ElasticIn(
                        child: CustomButton(
                          fontSize: 10.sp,
                          titlebutton: "تغيير",
                          onPressed: () {
                            pushTo(context: context, toPage: const ChangePassword());
                          },
                          width: 20,
                          height: 5,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 2.5.h),
                Builder(builder: (context) {
                  if (profileCubit.isEdit) {
                    if (state is ProfileEditingLoadingState) {
                      return const AppLoading();
                    } else {
                      return SlideInDown(
                        child: CustomButton(
                            width: 92,
                            fontSize: 12,
                            titlebutton: "حفظ",
                            onPressed: () {
                              if (profileCubit.formKey.currentState!
                                  .validate()) {
                                profileCubit.updateProfile();
                              }
                            }),
                      );
                    }
                  }
                  return const SizedBox();
                }),
                SizedBox(height: 10.h),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DeleteUserImageDialog extends StatelessWidget {
  const DeleteUserImageDialog({
    super.key,
    required this.profileCubit,
  });

  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return FlipInY(
      duration: const Duration(milliseconds: 300),
      child: Dialog(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'هل تريد حذف صورة الملف الشخصي؟',
                style: AppTextStyles.titlesMeduim,
              ),
              SizedBox(height: 1.h),
              BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is ProfileErrorState) {
                    customSnackBar(
                        context: context, success: 0, message: state.message);
                    Navigator.pop(context);
                  }
                  if (state is ProfileEditingSuccessState) {
                    customSnackBar(
                        context: context,
                        success: 1,
                        message: "تم حذف الصورة بنجاح");
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  return state is! ProfileEditingLoadingState
                      ? Row(
                          children: <Widget>[
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  profileCubit.removeImage = true;
                                  profileCubit.updateProfile();
                                },
                                child: Text(
                                  'نعم',
                                  style: AppTextStyles.titlesMeduim
                                      .copyWith(color: AppColors.primary),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'لا',
                                  style: AppTextStyles.titlesMeduim
                                      .copyWith(color: AppColors.primary),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const AppLoading();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
