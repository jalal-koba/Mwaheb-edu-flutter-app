class Urls {
  
  static const String domain = "https://khrejeen-back.icrcompany.net";

  static const String baseUrl = "$domain/api/v1/";

  static const String storageBaseUrl = "$domain/storage/";

  static const String siginUp = "${baseUrl}register";

  static const String login = "${baseUrl}login";

  static const String logout = "${baseUrl}logout";

  static const String sendVerificationCode = "${baseUrl}send/verification-code";

  static const String checkVerificationCode =
      "${baseUrl}check/verification-code";

  static const String restPassword = "${baseUrl}reset-password";

  static const String profileInfo = "${baseUrl}profile";

  static const String updateProfile = "${baseUrl}profile/update";

  static const String changePassword = "${baseUrl}change-password";

  static const String contactMessages = "${baseUrl}contact-messages";

  static const String sections = "${baseUrl}sections";

  static const String librarySections = "${baseUrl}sections?type=book_section";

  static const String courses = "${baseUrl}sections?type=courses";

  static const String librarySubSections = "${baseUrl}sections";

  static const String trainers = "${baseUrl}teachers";

  static const String offers = "${baseUrl}offers";

  static const String home = "${baseUrl}home/mobile";

  static const String infos = "${baseUrl}infos";

  static const String payCourse = "${baseUrl}student/subs-requests";

  static const String getPaymentsOrders = "${baseUrl}student/subs-requests";

  static String oneCourseInfo({required int id, required String additional}) =>
      "${baseUrl}sections/$id/lessons?get=1&$additional";

  static String subscribedCourses({required int page}) =>
      "${baseUrl}auth/courses?page=$page";

  static String lesson({required int parentId, required int lessonId}) =>
      "${baseUrl}sections/$parentId/lessons/$lessonId";

  static const getSections = '${baseUrl}sections';

  static const certificateRequests = '${baseUrl}certificate-requests?get=1';

  static const subscribeInFreeCourse = '${baseUrl}course-student';

  static const studentExams = '${baseUrl}student-exams';

  static getExam({required int id}) => '${baseUrl}exams/$id';

  static const postCertificateRequest = '${baseUrl}certificate-requests';
  static const checkCopun = '${baseUrl}student/subs-requests/coupon-check';

  static  String  notifications ({required int read,required int page}) => '${baseUrl}notifications?page=$page&mark_read=$read';
}
