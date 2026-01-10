import 'package:flutter/material.dart';
import '../../../core/storage/token_storage.dart';
import '../../../features/auth/data/donations/donation_request_model.dart';
import '../../../features/auth/data/donations/donation_request_service.dart';

class MyEquipmentDonationList extends StatefulWidget {
  const MyEquipmentDonationList({super.key});

  @override
  State<MyEquipmentDonationList> createState() =>
      _MyEquipmentDonationListState();
}

class _MyEquipmentDonationListState extends State<MyEquipmentDonationList> {
  final DonationRequestService _service = DonationRequestService();

  bool loading = true;
  List<AdminDonationRequest> donations = [];

  @override
  void initState() {
    super.initState();
    _loadDonations();
  }

  Future<void> _loadDonations() async {
    final token = await TokenStorage.getAccessToken();
    if (token == null) return;

    try {
      final equipment = await _service.getPendingEquipmentRequests(token);
      setState(() {
        donations = equipment;
        loading = false;
      });
    } catch (e) {
      print("Error loading donations: $e");
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (donations.isEmpty) {
      return const Center(
        child: Text(
          "You haven't donated any items yet.",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: donations.map(
              (donation) => _DonationTile(donation: donation),
        ).toList(),
      ),
    );
  }
}

class _DonationTile extends StatelessWidget {
  final AdminDonationRequest donation;

  const _DonationTile({required this.donation});

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
          /// ICON
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFF34AFB7).withOpacity(.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.medical_services, color: Color(0xFF34AFB7)),
          ),
          const SizedBox(width: 12),

          /// NAME + STATUS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  donation.itemName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Pending approval",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.orange,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          /// STATUS ICON
          const Icon(Icons.hourglass_bottom, color: Colors.orange, size: 20),
        ],
      ),
    );
  }
}
