import 'package:flutter/material.dart';
import 'package:test_app/screens/dr_DonorandRequester/request/my_equipment_requests.dart';
import 'package:test_app/screens/dr_DonorandRequester/request/my_medicine_requests.dart';
import 'request_new_item_sheet.dart';

class RequestItemsList extends StatelessWidget {
  RequestItemsList({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //const RequestNewItemCard(),
        //const SizedBox(height: 8),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "My Equipment Requests",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(child: MyEquipmentRequestList()),
        const SizedBox(height: 18),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "My Medicine Requests",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15),
        Expanded(child: MyMedicineReqeustList()),
      ],
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
            color: Colors.black.withOpacity(0.05),
          ),
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
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            child: const Text("Request"),
          ),
        ],
      ),
    );
  }
}
