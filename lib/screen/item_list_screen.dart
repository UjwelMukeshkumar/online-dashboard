import 'package:flutter/material.dart';
import 'package:glowrpt/screen/tabs/item_tab.dart';

class ItemListScreen extends StatefulWidget {
  String title;
  String id;
  String type;
  String apiKey;
  ItemListScreen({
  required this.title,
  required this.id,
  required this.type,
  required this.apiKey,
  });

  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ItemTabs(
        type: "C",
        value: widget.id,
      ),
    );
  }
}
