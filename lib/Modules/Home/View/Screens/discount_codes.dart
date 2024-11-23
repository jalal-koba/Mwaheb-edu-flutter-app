// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// import 'package:talents/Constant/app_colors.dart';
// import 'package:talents/Constant/app_text_styles.dart';
// import 'package:talents/Constant/public_constant.dart';

// import '../../../Widgets/app_scaffold.dart';

// class DiscountCodes extends StatelessWidget {
//   const DiscountCodes({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppScaffold(
//       title: "أكواد الحسم",
//       body: ListView.builder(
//         itemCount: 15,
//         padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
//         itemBuilder: (context, index) => Container(
//           padding: EdgeInsets.all(1.w),
//           margin: EdgeInsets.only(bottom: 1.h),
//           height: 12.h,
//           decoration: BoxDecoration(
//               border: Border.all(color: AppColors.primary, width: 1),
//               boxShadow: boxShadow,
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(25)),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   Text(
//                     'رقم الكود : 1209',
//                     style: AppTextStyles.secondTitle
//                         .copyWith(fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     'مادة العلوم',
//                     style: AppTextStyles.secondTitle
//                         .copyWith(color: AppColors.primary),
//                   )
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   Text(
//                     "تاريخ صلاحية الكود : 12/8/2028",
//                     style: AppTextStyles.secondTitle,
//                   ),
//                   Text(
//                     '12000 ل س',
//                     style: AppTextStyles.secondTitle
//                         .copyWith(fontWeight: FontWeight.bold),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
