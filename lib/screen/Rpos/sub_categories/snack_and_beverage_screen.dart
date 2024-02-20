import 'package:flutter/material.dart';

class SnacksAndBeverage extends StatelessWidget {
  final List<String> categoryItems = [
    " Apple Pie",
    "Chocolate Cake",
    "Vanilla Ice Cream",
    "Almond Malai Kulfi",
    "Lemon Tart",
    "Pistachio Phirni",
    "Low Fat Tiramisu",
    "Mango Lassi",
    "Coffee",
    "Coconut Kheer",
    "Orange Juice",
    "Ginger Ale",
    "Kesari Shrikhand"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snack And Beverage Items'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: categoryItems.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                // _navigateToSubCategoryScreen(categories[index]);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: Center(
                  child: Text(categoryItems[index],textAlign: TextAlign.center),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
