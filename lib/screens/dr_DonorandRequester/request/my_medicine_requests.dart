import 'package:flutter/material.dart';

import '../../../features/auth/data/unavailable donation/reqeust_service.dart';
import '../../../features/auth/data/unavailable donation/unavailable_reqeust_model.dart';

class MyMedicineReqeustList extends StatefulWidget {
  const MyMedicineReqeustList({super.key});

  @override
  State<MyMedicineReqeustList> createState() =>
      _MyMedicineReqeustListState();
}

class _MyMedicineReqeustListState
    extends State<MyMedicineReqeustList> {
  final RequestService _service = RequestService();

  bool loading = true;
  List<UnavailableRequest> items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    try {
      final data = await _service.getMyPendingTakeMedicineDonationRequestsAsync();

      setState(() {
        items = data;
        loading = false;
      });
    } catch (e) {
      print("Error loading unavailable medicine: $e");
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (items.isEmpty) {
      return const Center(
        child: Text(
          "No medicines requests.",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return SingleChildScrollView(
        child: Column(
        children: items
            .map((r) => UnavailableMedicineTile(
      name: r.itemName,
      icon: Icons.medical_services,
    ))
    .toList(),
    ),
    );
  }
}
class UnavailableMedicineTile extends StatelessWidget {
  final String name;
  final IconData icon;

  const UnavailableMedicineTile({
    required this.name,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: const Offset(0, 2),
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFF34AFB7).withOpacity(.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF34AFB7)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Pending approval",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.orange,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.hourglass_bottom,
              color: Colors.orange, size: 20),
        ],
      ),
    );
  }
}

