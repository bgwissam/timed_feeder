class UserModel {
  String? uid;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? emailAddress;
  int? age;
  bool? isAccountActive;

  UserModel(
      {this.uid,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.emailAddress,
      this.age,
      this.isAccountActive});
}

class DependantModel {
  String? uid;
  String? fullName;
  String? lastName;
  int? age;
  String? solidFeeds;
  double? quantitySolidInGrams;
  String? liquidFeeds;
  double? quantityLidquidInGrams;
  List<double>? weight;
  List<double>? height;
  String? gender;
}
