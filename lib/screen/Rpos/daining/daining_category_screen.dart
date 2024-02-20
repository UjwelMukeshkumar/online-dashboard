import 'package:flutter/material.dart';
import 'package:glowrpt/screen/Rpos/daining/dainig_screen.dart';
import 'package:glowrpt/screen/Rpos/sub_categories/break_fast_screen.dart';
import 'package:glowrpt/screen/Rpos/sub_categories/dessert_screen.dart';
import 'package:glowrpt/screen/Rpos/sub_categories/dinner_screen.dart';
import 'package:glowrpt/screen/Rpos/sub_categories/lunch_screen.dart';
import 'package:glowrpt/screen/Rpos/sub_categories/shakes_and%20_juice_screen.dart';
import 'package:glowrpt/screen/Rpos/sub_categories/snack_and_beverage_screen.dart';

class DainingCategory extends StatefulWidget {
  final int tableNumber;
  final int numberOfPersons;

  const DainingCategory({
    // super.key,
    required this.tableNumber,
    required this.numberOfPersons,
  });

  @override
  State<DainingCategory> createState() => _DainingCategoryState();
}

class _DainingCategoryState extends State<DainingCategory> {
  @override
  Widget build(BuildContext context) {
    print("Table No ${widget.tableNumber}");
    print("Number of person: ${widget.numberOfPersons}");

    final List<String> categories = [
      "Break Fast",
      "Lunch",
      "Dinner",
      "Snacks & Beverages",
      "Shakes & Juices",
      "Dessert"
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => DainingScreen()));
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Table No:${widget.tableNumber}",
                  style: TextStyle(color: Colors.black),
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.person,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${widget.numberOfPersons}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                _navigateToSubCategoryScreen(categories[index]);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: Center(
                  child: Text(categories[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigateToSubCategoryScreen(String categoryName) {
    switch (categoryName) {
      case "Break Fast":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BreakfastScreen()));

        break;
      case "Lunch":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LunchScreen()));
        break;
      case "Dinner":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DinnerScreen()));
        break;
      case "Snacks & Beverages":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SnacksAndBeverage()));
        break;
      case "Shakes & Juices":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShakesAndJuice()));
        break;
      case "Dessert":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DessertScreen()));

      default:
    }
  }
}
