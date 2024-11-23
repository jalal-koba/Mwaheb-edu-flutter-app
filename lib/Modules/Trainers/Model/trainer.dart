class Trainer {
  final int id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String username;
  final String? description;
  final String email;
  final String phoneNumber;
  final dynamic emailVerifiedAt;
  final dynamic lastActiveAt;
  final int isHidden;
  final String? image;
  final dynamic courses;

  Trainer({
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

  factory Trainer.fromJson(Map<String, dynamic> json) => Trainer(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        fullName: json["full_name"] ?? "",
        username: json["username"],
        description: json["description"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        emailVerifiedAt: json["email_verified_at"],
        lastActiveAt: json["last_active_at"],
        isHidden: json["is_hidden"],
        image: json["image"],
        courses: json["courses"],
      );}
 
 