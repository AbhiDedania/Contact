class PersonModel {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? birthDay;

  PersonModel({this.phoneNumber, this.lastName, this.firstName, this.birthDay});

  PersonModel.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastname'],
        phoneNumber = json['phoneNumber'],
        birthDay = json['birthDay'];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> userMap = <String, dynamic>{};
    userMap['firstName'] = firstName;
    userMap['lastName'] = lastName;
    userMap['phoneNumber'] = phoneNumber;
    userMap['birthDay'] = birthDay;
    return userMap;
  }
}
