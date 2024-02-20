import 'package:flutter/material.dart';
import 'package:glowrpt/screen/Rpos/r_pos_screen.dart';

class ChoiceChipRow extends StatelessWidget {
  final SelectedChip selectedChip;
  final ValueChanged<SelectedChip> onChipSelected;

  ChoiceChipRow({required this.selectedChip, required this.onChipSelected});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double chipWidth = (screenWidth - 48) / 3;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          
          child: ChoiceChip(
            padding: EdgeInsets.all(8),
            labelPadding: EdgeInsets.all(4),
            label: Text("Daining"),
            selected: selectedChip == SelectedChip.Daining,
            selectedColor: Colors.green,
            elevation: 10,
            pressElevation: 5,
            shadowColor: Colors.teal,
            onSelected: (isSelected) {
              if (isSelected) {
                onChipSelected(SelectedChip.Daining);
              }
            },
          ),
        ),
        ChoiceChip(
          
          padding: EdgeInsets.all(8),
          labelPadding: EdgeInsets.all(4),
          label: Text("Take Away"),
          selected: selectedChip == SelectedChip.TakeAway,
          selectedColor: Colors.green,
          elevation: 10,
          pressElevation: 5,
          shadowColor: Colors.teal,
          onSelected: (isSelected) {
            if (isSelected) {
              onChipSelected(SelectedChip.TakeAway);
            }
          },
        ),
        ChoiceChip(
          
          padding: EdgeInsets.all(8),
          labelPadding: EdgeInsets.all(4),
          label: Text("Delivery"),
          selected: selectedChip == SelectedChip.Delivery,
          selectedColor: Colors.green,
          elevation: 10,
          pressElevation: 5,
          shadowColor: Colors.teal,
          onSelected: (isSelected) {
            if (isSelected) {
              onChipSelected(SelectedChip.Delivery);
            }
          },
        ),
      ],
    );
  }
}
