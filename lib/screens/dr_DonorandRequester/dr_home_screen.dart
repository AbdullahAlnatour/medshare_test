import 'package:flutter/material.dart';
import 'package:test_app/screens/dr_DonorandRequester/dr_notification_screen.dart';

import '../../core/storage/user_storage.dart';

class DrHomeScreen extends StatefulWidget {
  const DrHomeScreen({super.key});

  @override
  State<DrHomeScreen> createState() => _DrHomeScreenState();
}

class _DrHomeScreenState extends State<DrHomeScreen> {
  bool isDonationActive = true;
  String _fullName = '';

  final List<MedicineItem> medicines = [
    MedicineItem(medicinename: 'Oxycodone', expiry: '26/04'),
    MedicineItem(medicinename: 'Amoxicillin', expiry: '26/06'),
    MedicineItem(medicinename: 'Oxycodone', expiry: '26/08'),
    MedicineItem(medicinename: 'Amoxicillin', expiry: '26/06'),
  ];

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  final List<MedicalItem> medicalitems = [
    MedicalItem(
      medicalname: 'Wheel chair',
      image: 'assets/images/wheelchair.png',
    ),
    MedicalItem(
      medicalname: 'Patient bed',
      image: 'assets/images/patientbed.jpg',
    ),
    MedicalItem(medicalname: 'Crutches', image: 'assets/images/crutches.jpg'),
  ];

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
        Stack(
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
        ),
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
            child: const Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 2),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                      filled: false,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: width * 0.03),
        Container(
          height: height * 0.06,
          width: height * 0.06,
          decoration: BoxDecoration(
            color: const Color(0xFF34AFB7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.filter_list, color: Colors.white),
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
    return SizedBox(
      height: height * 0.23,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: medicalitems.length,
        itemBuilder: (context, index) {
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
                  child: Image.asset(
                    medicalitems[index].image,
                    height: height * 0.15,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const SizedBox(width: 6),
                    Text(
                      medicalitems[index].medicalname,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 55),
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
                          child: IconButton(
                            icon: Icon(Icons.add_circle_outlined),
                            color: Color(0xFF34AFB7),
                            iconSize: 20,
                            onPressed: () {
                              medicalitems.removeAt(index);
                              setState(() {});
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
    return Expanded(
      child: ListView.builder(
        itemCount: medicines.length,
        padding: EdgeInsets.symmetric(horizontal: width * 0.01),
        itemBuilder: (context, index) {
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
                          medicines[index].medicinename,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Expired ${medicines[index].expiry}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
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
                      child: IconButton(
                        icon: Icon(Icons.add_circle_outlined),
                        color: Color(0xFF34AFB7),
                        iconSize: 20,
                        onPressed: () {
                          medicines.removeAt(index);
                          setState(() {});
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
