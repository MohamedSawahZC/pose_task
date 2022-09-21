class InterestModel {
  String intrestText;
  String id;

  InterestModel({
    required this.intrestText,
    required this.id,
  });
  factory InterestModel.fromJson(Map<String,dynamic>json){
    return InterestModel(
        intrestText: json['intrestText'] ?? '',
        id: json['id'] ?? ''
    );
  }
}