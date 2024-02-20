import 'package:flutter/material.dart';

class DinnerScreen extends StatelessWidget {
  final List<String> categoryItems = [
    "Western Dinner",
    "Chinese Dinner",
    "Kerala Dinner"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dinner Items'),
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
                  child: Text(categoryItems[index],textAlign: TextAlign.center,),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
