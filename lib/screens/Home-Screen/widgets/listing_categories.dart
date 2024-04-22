import 'package:my_recipes_app/screens/Home-Screen/widgets/category_card.dart';

import '../../../models/category.dart';

List<CategoryCard> generateListCategories(
    {required Map<String, Category> database,
    required Function refreshFunction,
    required int userId,
    required String token}) {

  print('entrou aqui');
  List<CategoryCard> list = [];
  database.forEach((id, category) {
    list.add(CategoryCard(
      refreshFunction: refreshFunction,
      userId: userId,
      token: token,
      category: category,
    ));
  });
  return list;
}
