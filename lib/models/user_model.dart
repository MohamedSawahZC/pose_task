class UserModel {
  String username;
  String password;
  String email;
  String imageAsBase64;
  String intrestId;
  String id;
  UserModel({
  required this.username,
  required this.password,
  required this.email,
  required this.imageAsBase64,
  required this.intrestId,
  required this.id,
});
  factory UserModel.fromJson(Map<String,dynamic>json){
    return UserModel(
        username: json['username'] ?? '',
        password: json['password'] ?? '',
        email: json['email'] ?? '',
        imageAsBase64: json['imageAsBase64'] ?? '',
        intrestId: json['intrestId'] ?? '',
        id: json['id'] ?? ''
    );
  }
}