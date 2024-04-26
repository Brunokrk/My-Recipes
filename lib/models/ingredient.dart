class Ingredient {
  String id;
  String name;
  String quantity;
  String obs;

  Ingredient(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.obs});

  Ingredient.empty({required String recpId})
  :id = recpId,
  name ="",
  quantity = "",
  obs = "";

  // Método para criar um objeto Ingredient a partir de um Map (desserialização)
  Ingredient.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        quantity = map["quantity"],
        obs = map["obs"];

  // Método para converter o objeto Ingredient em um Map (serialização)
  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "quantity": quantity, "obs": obs};
  }
}
