class Category {
  String catId;
  String name;
 

  Category({
    required this.catId,
    required this.name,
  });

  // Método para criar um objeto Category a partir de um Map (desserialização)
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      catId: map["catId"],
      name: map["name"],
    );
  }

  // Método para converter o objeto Category em um Map (serialização)
  Map<String, dynamic> toMap() {
    return {
      "catId": catId,
      "name": name,
    };
  }
}
