import 'package:flutter/material.dart';
import '../../../../theme/colors.dart';
import 'donor_items_list.dart';

class DonorItemCard extends StatelessWidget {
  final DonorItem item;
  const DonorItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final qtyController = TextEditingController();

    return Container(
      
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: Offset(0, 2),
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: kTeal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.medical_services, color: kTeal),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text("Quantity Needed: ${item.needed}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 8),

                TextField(
                  controller: qtyController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Qty to donate',
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          ElevatedButton(
            onPressed: () {
              final qty = qtyController.text.trim();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        "Thank you! You offered $qty of ${item.name}")),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kTeal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
