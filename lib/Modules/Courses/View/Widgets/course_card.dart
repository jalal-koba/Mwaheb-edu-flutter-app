import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/images.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Courses/Model/course.dart';
import 'package:talents/Modules/Courses/View/Screens/course_screen.dart';
import 'package:talents/Modules/Widgets/cached_image.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.course,
    required this.tag, 
    required this.index,
  });
  final Course course;
  final int index;
  final String tag; 
  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: 300 + 150 * (index % 3)),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          pushTo(
              context: context,
              toPage: CourseScreen(
                course: course,
                tag: "courseInfo$index",  
              ));
        },
        child: CardWithShadow(
          height: 20.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      child: Text(
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        course.name,
                        style: AppTextStyles.titlesMeduim.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          if (course.teachers.isNotEmpty)
                            InfoRow(
                                title: course.teachers[0].fullName,
                                icon: Images.teacher),
                          InfoRow(
                              title: "${course.price} ل.س", icon: Images.price),
                          InfoRow(
                              title: "${course.totalLessonsTime} ساعة",
                              icon: Images.time),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Hero(
                tag: tag,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.all(1.w),
                  width: 30.w,
                  height: 15.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: const Border(
                          bottom: BorderSide(color: AppColors.primary))),
                  child: CachedImage(  imageUrl: course.image),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.title,
    required this.icon,
  });
  final String title, icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          icon,
          width: 5.w,
        ),
        SizedBox(
          width: 3.w,
        ),
        SizedBox(
          width: 47.w,
          child: Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              title,
              style: AppTextStyles.secondTitle),
        ),
      ],
    );
  }
}

class CardWithShadow extends StatelessWidget {
  const CardWithShadow({
    super.key,
    required this.child,
    this.height,
  });

  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        margin: EdgeInsets.only(
          bottom: 2.h,
        ),
        padding:
            EdgeInsets.only(left: 2.w, right: 2.5.w, bottom: 1.h, top: 1.h),
        decoration: BoxDecoration(
          border: const Border(
              bottom: BorderSide(color: AppColors.secondary, width: 2)),
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: child);
  }
}
