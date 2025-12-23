import 'package:flutter/material.dart';
import 'request_new_item_sheet.dart';

class RequestItemsList extends StatelessWidget {
  RequestItemsList({super.key});

  final List<String> _requests = [
    "Wheelchair",
    "Insulin Pen",
    "Nebulizer",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const RequestNewItemCard(),
        const SizedBox(height: 16),
        ..._requests.map((r) => _buildItem(r)),
      ],
    );
  }

  Widget _buildItem(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              blurRadius: 8,
              offset: Offset(0, 3),
              color: Colors.black.withOpacity(0.05))
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.medical_information, color: Color(0xFF34AFB7)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          const Icon(Icons.hourglass_bottom, size: 18, color: Colors.grey),
        ],
      ),
    );
  }
}

class RequestNewItemCard extends StatelessWidget {
  const RequestNewItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              blurRadius: 8,
              offset: Offset(0, 3),
              color: Colors.black.withOpacity(0.05))
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF34AFB7)),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              "Can't find an item?\nRequest a new one.",
              style: TextStyle(fontSize: 13),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (_) => RequestNewItemSheet(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF34AFB7),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text("Request"),
          ),
        ],
      ),
    );
  }
}
