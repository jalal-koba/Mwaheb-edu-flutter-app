 
import 'package:talents/Modules/Courses/Model/course.dart';

class TrainerInfoResponse {
    final Data data;
    final int code;

    TrainerInfoResponse({
        required this.data,
        required this.code,
    });

    factory TrainerInfoResponse.fromJson(Map<String, dynamic> json) => TrainerInfoResponse(
        data: Data.fromJson(json["data"]),
        code: json["code"],
    );

   
}

class Data {
    final int id;
    final String firstName;
    final String lastName;
    final String fullName;
    final String username;
    final String description;
    final String email;
    final String phoneNumber;
    final dynamic emailVerifiedAt;
    final dynamic lastActiveAt;
    final dynamic isHidden;
    final String? image;
    final List<Course> courses;

    Data({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.fullName,
        required this.username,
        required this.description,
        required this.email,
        required this.phoneNumber,
        required this.emailVerifiedAt,
        required this.lastActiveAt,
        required this.isHidden,
        required this.image,
        required this.courses,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        fullName: json["full_name"],
        username: json["username"],
        description: json["description"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        emailVerifiedAt: json["email_verified_at"],
        lastActiveAt: json["last_active_at"],
        isHidden: json["is_hidden"],
        image: json["image"],
        courses: List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
    );

   
}

// class Course {
//     final int id;
//     final int parentId;
//     final String type;
//     final String name;
//     final String image;
//     final String description;
//     final String isFree;
//     final int price;
//     final int discount;
//     final int totalPrice;
//     final Pivot pivot;
//     final dynamic subSections;
//     final dynamic teachers;
//     final String time;
//     final dynamic lessons;

//     Course({
//         required this.id,
//         required this.parentId,
//         required this.type,
//         required this.name,
//         required this.image,
//         required this.description,
//         required this.isFree,
//         required this.price,
//         required this.discount,
//         required this.totalPrice,
//         required this.pivot,
//         required this.subSections,
//         required this.teachers,
//         required this.time,
//         required this.lessons,
//     });

//     factory Course.fromJson(Map<String, dynamic> json) => Course(
//         id: json["id"],
//         parentId: json["parent_id"],
//         type: json["type"],
//         name: json["name"],
//         image: json["image"],
//         description: json["description"],
//         isFree: json["is_free"],
//         price: json["price"],
//         discount: json["discount"],
//         totalPrice: json["total_price"],
//         pivot: Pivot.fromJson(json["pivot"]),
//         subSections: json["sub_sections"],
//         teachers: json["teachers"],
//         time: json["time"],
//         lessons: json["lessons"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "parent_id": parentId,
//         "type": type,
//         "name": name,
//         "image": image,
//         "description": description,
//         "is_free": isFree,
//         "price": price,
//         "discount": discount,
//         "total_price": totalPrice,
//         "pivot": pivot.toJson(),
//         "sub_sections": subSections,
//         "teachers": teachers,
//         "time": time,
//         "lessons": lessons,
//     };
// }

class Pivot {
    final int teacherId;
    final int courseId;

    Pivot({
        required this.teacherId,
        required this.courseId,
    });

    factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        teacherId: json["teacher_id"],
        courseId: json["course_id"],
    );

    Map<String, dynamic> toJson() => {
        "teacher_id": teacherId,
        "course_id": courseId,
    };
}
