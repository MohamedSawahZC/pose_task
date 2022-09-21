class NoteModel {
  String text;
  String placeDateTime;
  String userId;
  String id;
  NoteModel({
    required this.text,
    required this.placeDateTime,
    required this.userId,
    required this.id,
  });
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      text: json['text'] ?? '',
      placeDateTime: json['placeDateTime'] ?? '',
      userId: json['userId'] ?? '',
      id: json['id'].toString() ?? '',
    );
  }
}