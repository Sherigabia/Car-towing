class User {
  String userId;
  String firstname;
  String lastname;
  String email;
  String phoneNumber;

  User({
    required this.userId,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      userId: responseData['id'],
      firstname: responseData['firstname'],
      lastname: responseData['lastname'],
      email: responseData['email'],
      phoneNumber: responseData['phone_number'],
    );
  }
}
