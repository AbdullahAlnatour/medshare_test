import 'package:flutter/material.dart';
import 'package:test_app/features/auth/data/drhome/dr_home_service.dart';
import 'package:test_app/screens/dr_DonorandRequester/dr_notification_screen.dart';
import '../../core/storage/user_storage.dart';
import '../../features/auth/data/Cart/cart_service.dart';
import '../../features/auth/data/Cart/add_to_cart_dto.dart';
import '../../features/auth/data/drhome/donation_equipment_model.dart';
import '../../features/auth/data/drhome/donation_medicine_model.dart';

class DrHomeScreen extends StatefulWidget {
  const DrHomeScreen({super.key});

  @override
  State<DrHomeScreen> createState() => _DrHomeScreenState();
}

class _DrHomeScreenState extends State<DrHomeScreen> {
  String searchQuery = "";
  bool isDonationActive = true;
  String _fullName = '';

  // Fetched from backend
  List<DonationMedicineModel> medicines = [];
  bool _medicinesLoading = false;

  List<DonationEquipmentModel> equipment = [];
  bool _equipmentLoading = false;
  String dosageFormToText(int value) {
    switch (value) {
      case 1:
        return "Capsules";
      case 2:
        return "Syrup";
      case 3:
        return "Injection";
      case 4:
        return "Cream";
      case 5:
        return "Other";
      default:
        return "Unknown";
    }
  }
  String equStatusToText(int value) {
    switch (value) {
      case 1:
        return "New";
      case 2:
        return "Like New";
      case 3:
        return "Used";
      default:
        return "Unknown";
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadApprovedEquipment();
    _loadApprovedMedicines();
  }

  final _cartService = CartService();
  final _donationsService = DRHomeService();

  Future<void> _loadApprovedEquipment() async {
    setState(() => _equipmentLoading = true);
    try {
      final data = await _donationsService.getApprovedEquipment();
      setState(() => equipment = data);
    } catch (e) {
      // ignore errors for now; keep UI stable
      print('Failed to load equipment: $e');
    } finally {
      if (mounted) setState(() => _equipmentLoading = false);
    }
  }

  Future<void> _loadApprovedMedicines() async {
    setState(() => _medicinesLoading = true);
    try {
      final data = await _donationsService.getApprovedMedicines();
      setState(() => medicines = data);
    } catch (e) {
      print('Failed to load medicines: $e');
    } finally {
      if (mounted) setState(() => _medicinesLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(width),
              SizedBox(height: height * 0.02),
              _buildSearchBar(width, height),
              SizedBox(height: height * 0.02),
              _buildSectionTitle("Medical equipment"),
              SizedBox(height: height * 0.015),
              _buildMedicalEquipment(width, height),
              SizedBox(height: height * 0.03),
              _buildSectionTitle("Medicines"),
              SizedBox(height: height * 0.015),
              _buildMedicinesList(width, height),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "☀️ Good Morning",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            Text(
              _fullName.isEmpty ? '...' : _fullName,
              style: TextStyle(
                fontSize: width * 0.065,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
       /* Stack(
          children: [
            InkWell(
              child: const Icon(Icons.notifications_none_rounded, size: 30),
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const DrNotificationScreen(),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 2,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),*/
      ],
    );
  }

  Widget _buildSearchBar(double width, double height) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: height * 0.06,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 2),
                Expanded(child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase().trim();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildMedicalEquipment(double width, double height) {
    final displayedEquipment = searchQuery.isEmpty
        ? equipment
        : equipment.where((item) {
      return item.itemName.toLowerCase().contains(searchQuery);
    }).toList();

    const String apiBase = "http://10.0.2.2:5149";
    if (_equipmentLoading) {
      return SizedBox(
        height: height * 0.23,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    return SizedBox(
      height: height * 0.23,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: displayedEquipment.length,
        itemBuilder: (context, index) {
          final item = displayedEquipment[index];
          return Container(
            width: width * 0.45,
            margin: EdgeInsets.only(right: width * 0.02),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: item.image1 != null && item.image1!.isNotEmpty
                      ? Image.network(
                    "$apiBase${item.image1}",
                    height: height * 0.15,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Image.asset(
                      'assets/images/wheelchair.png',
                      height: height * 0.15,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                      : Image.asset(
                    'assets/images/wheelchair.png',
                    height: height * 0.15,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 15),
                Row(
                  children: [
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.itemName,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Quantity ${item.quantity}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Condition ${equStatusToText(item.condition)}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 1),
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 34,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: StatefulBuilder(
                            builder: (context, setLocalState) {
                              bool adding = false;
                              return Builder(
                                builder: (ctx) {
                                  return IconButton(
                                    icon: const Icon(Icons.add_circle_outlined),
                                    color: const Color(0xFF34AFB7),
                                    iconSize: 20,
                                    onPressed: adding
                                        ? null
                                        : () async {
                                            setLocalState(() => adding = true);
                                            final ok = await _cartService
                                                .addToCart(
                                                  AddToCartDto(
                                                    donationId: item
                                                        .donationEquipmentId,
                                                    quantity: 1,
                                                    cartType: 1,
                                                    itemName: item.itemName,
                                                  ),
                                                );
                                            setLocalState(() => adding = false);

                                            if (!mounted) return;
                                            if (ok) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Added to cart',
                                                  ),
                                                  backgroundColor: Colors.green,
                                                ),
                                              );
                                              // remove only on confirmed success
                                              setState(
                                                () => equipment.removeAt(index),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Failed to add to cart. Try again later.',
                                                  ),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMedicinesList(double width, double height) {
    final displayedMedicine = searchQuery.isEmpty
        ? medicines
        : medicines.where((item) {
      return item.itemName.toLowerCase().contains(searchQuery);
    }).toList();

    if (_medicinesLoading) {
      return const Expanded(child: Center(child: CircularProgressIndicator()));
    }

    return Expanded(
      child: ListView.builder(
        itemCount: displayedMedicine.length,
        padding: EdgeInsets.symmetric(horizontal: width * 0.01),
        itemBuilder: (context, index) {
          final item = displayedMedicine[index];
          return Container(
            margin: EdgeInsets.only(bottom: height * 0.015),
            padding: EdgeInsets.all(width * 0.04),
            decoration: BoxDecoration(
              color: const Color(0xFF34AFB7),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.medication_liquid, color: Colors.white),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.itemName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              "Quantity ${item.quantity}",
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 2),

                            if (item.expiry != null && item.expiry!.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                '-Expired ${item.expiry}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              'Strength ${item.strength}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '- Dosageform ${dosageFormToText(item.dosageform)}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 34,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: StatefulBuilder(
                        builder: (context, setLocalState) {
                          bool adding = false;
                          return Builder(
                            builder: (ctx) {
                              return IconButton(
                                icon: const Icon(Icons.add_circle_outlined),
                                color: const Color(0xFF34AFB7),
                                iconSize: 20,
                                onPressed: adding
                                    ? null
                                    : () async {
                                        setLocalState(() => adding = true);
                                        final ok = await _cartService.addToCart(
                                          AddToCartDto(
                                            donationId: item.donationMedicineId,
                                            quantity: 1,
                                            cartType: 2,
                                            itemName: item.itemName,
                                          ),
                                        );
                                        setLocalState(() => adding = false);

                                        if (!mounted) return;
                                        if (ok) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text('Added to cart'),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                          setState(
                                            () => medicines.removeAt(index),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Failed to add to cart. Try again later.',
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _loadUser() async {
    final name = await UserStorage.getFullName();
    if (!mounted) return;
    setState(() {
      _fullName = name ?? '';
    });
  }
}

class MedicineItem {
  final String medicinename;
  final String expiry;
  bool medicineadded;

  MedicineItem({
    required this.medicinename,
    required this.expiry,
    this.medicineadded = false,
  });
}

class MedicalItem {
  final String medicalname;
  final String image;
  bool medicaladded;

  MedicalItem({
    required this.medicalname,
    required this.image,
    this.medicaladded = false,
  });
}
