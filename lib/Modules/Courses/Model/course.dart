import 'package:talents/Modules/Lessons/Models/lesson.dart';
import 'package:talents/Modules/Trainers/Model/trainer.dart';
import 'package:talents/Modules/Utils/bool_converter.dart';

class Course {

  final int id;
  final String name;
  final String image;
  final String description;
  final bool isFree;
  final String? introVideo;
  final dynamic price;
  final dynamic discount;
  final dynamic totalPrice;
  final String? totalLessonsTime;
  final List<Trainer> teachers;
  final List<Lesson> freeLessons;
  final List<Lesson> paidLessons;
  final dynamic subSections;
  final dynamic lessons;
    bool subscribed;
    bool refreshCourseScreen=false;
  Course({
    required this.id,
    required this.name,
    required this.image,
    required this.introVideo,
    required this.description,
    required this.isFree,
    required this.price,
    required this.discount,
    required this.totalPrice,
    required this.totalLessonsTime,
    required this.teachers,
    required this.freeLessons,
    required this.paidLessons,
    required this.subSections,
    required this.lessons,
    required this.subscribed,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"] ?? -1,
        name: json["name"],
        image: json["image"],
        introVideo: json["intro_video"],
        totalLessonsTime: json["total_lessons_time"]??"",
        description: json["description"],
        isFree: boolConverter(json["is_free"]),
        price: json["price"],
        discount: json["discount"],
        totalPrice: json["total_price"],
        teachers: json["teachers"] != null
            ? List<Trainer>.from(
                json["teachers"].map((x) => Trainer.fromJson(x)))
            : [],
            
        freeLessons: json["free_lessons"] != null
            ? List<Lesson>.from(
                json["free_lessons"].map(
                  (x) => Lesson.fromJson(x),
                ),
              )
            : [],
        paidLessons: json["paid_lessons"] != null
            ? List<Lesson>.from(
                json["paid_lessons"].map(
                  (x) => Lesson.fromJson(x),
                ),
              )
            : [],
        subSections: json["sub_sections"],
        lessons: json["lessons"],
        subscribed: boolConverter(json["subscribed"]),
      );
}
