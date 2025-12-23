import 'package:flutter/material.dart';
import 'package:test_app/screens/dr_DonorandRequester/donor/donate_button_to_form.dart';
import 'donor_item_card.dart';

class DonorItemsList extends StatelessWidget {
  const DonorItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      DonorItem(name: 'Patient bed', needed: '2'),
      DonorItem(name: 'Crutch', needed: '4'),
      DonorItem(name: 'Oxycodone 500mg', needed: '60 tablets'),
    ];

    return ListView(
      children: [
        DonateHintCard(),
        const SizedBox(height: 14),
        ...List.generate(items.length, (i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: DonorItemCard(item: items[i]),
          );
        }),
      ],
    );
  }
}

class DonorItem {
  final String name;
  final String needed;

  DonorItem({required this.name, required this.needed});
}
