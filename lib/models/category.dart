class Category {
  String catId;
  String name;
  String urlPhoto;
 

  Category({
    required this.catId,
    required this.name,
    required this.urlPhoto,
  });

  // Método para criar um objeto Category a partir de um Map (desserialização)
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      catId: map["catId"],
      name: map["name"],
      urlPhoto: map["urlPhoto"]
    );
  }

  // Método para converter o objeto Category em um Map (serialização)
  Map<String, dynamic> toMap() {
    return {
      "catId": catId,
      "name": name,
      "urlPhoto": urlPhoto
    };
  }
}
