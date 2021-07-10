part of 'models.dart';

@HiveType(typeId: 2)
class UserModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final LocalizedName name;
  @HiveField(2)
  final String sabNumber;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final String media;
  @HiveField(5)
  final DateTime lastVisit;
  @HiveField(6)
  final Target target;

  UserModel({
    required this.sabNumber,
    required this.phone,
    required this.media,
    required this.lastVisit,
    required this.target,
    required this.id,
    required this.name,
  });

  @override
  String toString() {
    return '''
    UserModel{
    id: $id, 
    name: $name, 
    sabNumber: $sabNumber,
    phone: $phone, 
    media: $media, 
    lastVisit: $lastVisit, 
    target: $target
    } ''';
  }
}

@HiveType(typeId: 3)
class Target {
  @HiveField(0)
  double totalSellOut;
  @HiveField(1)
  double target;

  Target({required this.totalSellOut, required this.target});
}

@HiveType(typeId: 4)
class LoginModel extends HiveObject {
  @HiveField(0)
  String authToken;
  @HiveField(1)
  UserModel? userProfile;

  LoginModel({required this.authToken, required this.userProfile});

  factory LoginModel.copyWith({required LoginModel origin, String? authToken, UserModel? userProfile}) {
    return LoginModel(
      authToken: authToken ?? origin.authToken,
      userProfile: userProfile ?? origin.userProfile,
    );
  }

  @override
  String toString() {
    return '''
    LoginModel {
    authToken: $authToken,
    userProfile: $userProfile } ''';
  }
}
