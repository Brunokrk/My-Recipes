import 'package:uuid/uuid.dart';

class Category {
  String id;
  String name;
  String urlPhoto;
  int userId;

  Category({
    required this.id,
    required this.name,
    required this.urlPhoto,
    required this.userId,
  });

  Category.empty({required int userIdd})
      : id = const Uuid().v1(),
        name = '',
        urlPhoto = '',
        userId = userIdd;

  Category.fromMap(Map<String, dynamic> map)
      : id = map["id"].toString(),
        name = map["name"],
        urlPhoto = map["urlPhoto"],
        userId = map["userId"];


  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "urlPhoto": urlPhoto, "userId": userId};
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name, urlPhoto: $urlPhoto, userId: $userId)';
  }

}
