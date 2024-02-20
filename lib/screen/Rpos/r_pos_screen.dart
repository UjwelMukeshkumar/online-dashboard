import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glowrpt/screen/Rpos/daining/dainig_screen.dart';
import 'package:glowrpt/screen/Rpos/delivery/r_pos_delivery_screen.dart';
import 'package:glowrpt/screen/Rpos/take_away/take_away_screen.dart';
import 'package:glowrpt/screen/Rpos/widgets/choice_chip_row_widget.dart';

// enum SelctedChip{

// }

class RestuarentPosScreen extends StatefulWidget {
  const RestuarentPosScreen({super.key});

  @override
  State<RestuarentPosScreen> createState() => _RestuarentPosScreenState();
}

enum SelectedChip {
  Daining,
  TakeAway,
  Delivery,
}

class _RestuarentPosScreenState extends State<RestuarentPosScreen> {
  SelectedChip selectedChip = SelectedChip.Daining;
  // bool isTableSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("R Pos"),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          ChoiceChipRow(
              selectedChip: selectedChip,
              onChipSelected: (chip) {
                setState(() {
                  selectedChip = chip;
                });
              }),
          const Divider(
            endIndent: 10,
            indent: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  if (selectedChip == SelectedChip.TakeAway) TakeAwayScreen(),
                  if (selectedChip == SelectedChip.Delivery)
                    RposDeleveryScreen(),
                  if (selectedChip == SelectedChip.Daining) DainingScreen(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


