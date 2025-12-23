import 'package:flutter/material.dart';
import 'package:test_app/screens/dr_DonorandRequester/dr_notification_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  bool isDonationActive = true;
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
              _buildButtons(width, height),
              SizedBox(height: height * 0.03),
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
              "Kareem Saleh",
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
                  builder: (context) => const NotificationScreen(),
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

  Widget _buildButtons(double width, double height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildActionButton("Donation", isDonationActive, () {
          setState(() {
            isDonationActive = !isDonationActive;
          });
        }),
        SizedBox(width: width * 0.04),
        _buildActionButton("Request", !isDonationActive, () {
          setState(() {
            isDonationActive = !isDonationActive;
          });
        }),
      ],
    );
  }

  Widget _buildActionButton(String text, bool isActive, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF34AFB7) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFF34AFB7), width: 1.5),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF34AFB7),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildMedicalEquipment(double width, double height) {
    final items = [
      {'name': 'Wheel chair', 'image': 'assets/images/wheelchair.png'},
      {'name': 'Patient bed', 'image': 'assets/images/patientbed.jpg'},
      {'name': 'Crutches', 'image': 'assets/images/crutches.jpg'},
    ];

    return SizedBox(
      height: height * 0.23,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
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
                    item['image']!,
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
                      item['name']!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 24),
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
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
                          child: const Icon(
                            Icons.close_rounded,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 6),

                        Container(
                          width: 32,
                          height: 32,
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
                          child: const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 20,
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
    final medicines = [
      {'name': 'Oxycodone', 'expiry': '26/04'},
      {'name': 'Amoxicillin', 'expiry': '26/06'},
      {'name': 'Oxycodone', 'expiry': '26/08'},
      {'name': 'Amoxicillin', 'expiry': '26/06'},
    ];

    return Expanded(
      child: ListView.builder(
        itemCount: medicines.length,
        padding: EdgeInsets.symmetric(horizontal: width * 0.01),
        itemBuilder: (context, index) {
          final med = medicines[index];
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
                          med['name']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Expired ${med['expiry']!}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
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
                      child: const Icon(
                        Icons.close_rounded,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 8),

                    Container(
                      width: 32,
                      height: 32,
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
                      child: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
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
}
