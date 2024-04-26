import 'package:flutter/material.dart';
import '../../../models/category.dart';

class CategoryCard extends StatefulWidget {
  final Category category;
  final Function refreshFunction;
  final int userId;
  final String token;

  const CategoryCard({
    Key? key,
    required this.category,
    required this.refreshFunction,
    required this.userId,
    required this.token,
  }) : super(key: key);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool _isPressed = false; // State to track if the card is being long-pressed

  void _handleLongPress() {
    setState(() {
      _isPressed = true;
    });
  }

  void _handleTap() {
    if (_isPressed) {
      // TODO: Implement your deletion function here
      // Example: deleteCategory(widget.category);
      widget.refreshFunction();
      setState(() {
        _isPressed = false; // Reset the pressed state
      });
    } else {
      onCardTap(context, widget.category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: _handleTap,
        onLongPress: _handleLongPress,
        child: Card(
          color: Colors.grey[200], // Background color of the card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 5.0,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _isPressed ? Container(
              height: 100,
              color: Colors.red,
              child: Icon(Icons.delete, size: 40, color: Colors.white),
            ) : Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                    ),
                    child: Image.network(
                      widget.category.urlPhoto,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.category.name,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton(
                    icon: Icon(Icons.edit, color: Colors.grey),
                    onPressed: () {
                      if (!_isPressed) { // Prevent editing in delete mode
                        Map<String, dynamic> map = {};
                        map["category"] = widget.category;
                        Navigator.pushNamed(context, 'add-category', arguments: map).then((value) {
                          widget.refreshFunction();
                          if (value != null && value == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Alteração Feita com Sucesso!"),
                              ),
                            );
                          }
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onCardTap(BuildContext context, Category category) {
    Map<String, dynamic> map = {};
    map['category'] = category;
    Navigator.pushNamed(context, 'category-screen', arguments: map);
  }
}
