import 'package:flutter/material.dart';
import 'package:test_app/screens/Admin/admin_notification_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  bool isDonationActive = true;
  final List<MedicineItem> medicinesdonations = [
    MedicineItem(
      medicinename: 'Oxycodone',
      expiry: '26/04',
      username: "Laith Abdullah",
      email: "laith@gmail.com",
    ),
    MedicineItem(
      medicinename: 'Amoxicillin',
      expiry: '26/06',
      username: "Zaid Ali",
      email: "zaid@gmail.com",
    ),
    MedicineItem(
      medicinename: 'Oxycodone',
      expiry: '26/08',
      username: "Sara Mohammed",
      email: "sara@gmail.com",
    ),
    MedicineItem(
      medicinename: 'Amoxicillin',
      expiry: '26/06',
      username: "Musa Karam",
      email: "musa@gmail.com",
    ),
  ];
  final List<MedicineItem> medicinesrequests = [
    MedicineItem(
      medicinename: 'Oxycodone',
      expiry: '26/04',
      username: "Maria Moath",
      email: "maria@gmail.com",
    ),
    MedicineItem(
      medicinename: 'Amoxicillin',
      expiry: '26/06',
      username: "Mohammed Khaled",
      email: "mohammed@gmail.com",
    ),
    MedicineItem(
      medicinename: 'Oxycodone',
      expiry: '26/08',
      username: "Jamel Abdullah",
      email: "jamel@gmail.com",
    ),
    MedicineItem(
      medicinename: 'Amoxicillin',
      expiry: '26/06',
      username: "Tina Khaled",
      email: "tina@gmail.com",
    ),
  ];

  final List<MedicalItem> medicaldonations = [
    MedicalItem(
      medicalname: 'Wheel chair',
      image: 'assets/images/wheelchair.png',
      username: "Tina Abdullah",
      email: "tina@gmail.com",
    ),
    MedicalItem(
      medicalname: 'Patient bed',
      image: 'assets/images/patientbed.jpg',
      username: "Rama Abdullah",
      email: "Rama@gmail.com",
    ),
    MedicalItem(
      medicalname: 'Crutches',
      image: 'assets/images/crutches.jpg',
      username: "Kareem Omar",
      email: "kareem@gmail.com",
    ),
  ];
  final List<MedicalItem> medicalrequests = [
    MedicalItem(
      medicalname: 'Wheel chair',
      image: 'assets/images/wheelchair.png',
      username: "Ali Sami",
      email: "Ali@gmail.com",
    ),
    MedicalItem(
      medicalname: 'Patient bed',
      image: 'assets/images/patientbed.jpg',
      username: "Ahmad Ali",
      email: "Ahmad@gmail.com",
    ),
    MedicalItem(
      medicalname: 'Crutches',
      image: 'assets/images/crutches.jpg',
      username: "Ahmad Ali",
      email: "Ahmad01@gmail.com",
    ),
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
              _buildButtons(width, height),
              SizedBox(height: height * 0.03),
              _buildSectionTitle("Medical equipment"),
              SizedBox(height: height * 0.015),
              _buildMedicalEquipment(width, height),
              SizedBox(height: height * 0.03),
              _buildSectionTitle("Medicines donations"),
              SizedBox(height: height * 0.015),
              _buildmedicinesList(width, height),
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
                  builder: (context) => const AdminNotificationScreen(),
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
    return SizedBox(
      height: height * 0.23,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (isDonationActive)
            ? medicaldonations.length
            : medicalrequests.length,
        itemBuilder: (context, index) {
          return Container(
            width: width * 0.55,
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
                    (isDonationActive)
                        ? medicaldonations[index].image
                        : medicalrequests[index].image,
                    height: height * 0.15,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (isDonationActive)
                              ? medicaldonations[index].medicalname
                              : medicalrequests[index].medicalname,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          (isDonationActive)
                              ? medicaldonations[index].username
                              : medicalrequests[index].username,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          (isDonationActive)
                              ? medicaldonations[index].email
                              : medicalrequests[index].email,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 24),
                      ],
                    ),
                    const SizedBox(width: 10),
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
                            icon: Icon(Icons.close_rounded),
                            color: Colors.red,
                            iconSize: 20,
                            onPressed: () {
                              (isDonationActive)
                                  ? medicaldonations.removeAt(index)
                                  : medicalrequests.removeAt(index);
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(width: 6),

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
                            icon: Icon(Icons.check_circle),
                            color: Colors.green,
                            iconSize: 20,
                            onPressed: () {
                              (isDonationActive)
                                  ? medicaldonations.removeAt(index)
                                  : medicalrequests.removeAt(index);
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

  Widget _buildmedicinesList(double width, double height) {
    return Expanded(
      child: ListView.builder(
        itemCount: (isDonationActive)
            ? medicinesdonations.length
            : medicinesrequests.length,
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
                          (isDonationActive)
                              ? medicinesdonations[index].medicinename
                              : medicinesrequests[index].medicinename,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          (isDonationActive)
                              ? "Expired ${medicinesdonations[index].expiry}"
                              : "Expired ${medicinesrequests[index].expiry}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 6),

                        Text(
                          (isDonationActive)
                              ? medicinesdonations[index].username
                              : medicinesrequests[index].username,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          (isDonationActive)
                              ? medicinesdonations[index].email
                              : medicinesrequests[index].email,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                        icon: Icon(Icons.close_rounded),
                        color: Colors.red,
                        iconSize: 20,
                        onPressed: () {
                          (isDonationActive)
                              ? medicinesdonations.removeAt(index)
                              : medicinesrequests.removeAt(index);
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(width: 8),

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
                        icon: Icon(Icons.check_circle),
                        color: Colors.green,
                        iconSize: 20,
                        onPressed: () {
                          (isDonationActive)
                              ? medicinesdonations.removeAt(index)
                              : medicinesrequests.removeAt(index);
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
}

class MedicineItem {
  final String medicinename;
  final String expiry;
  final String username;
  final String email;
  bool medicineadded;

  MedicineItem({
    required this.medicinename,
    required this.expiry,
    required this.username,
    required this.email,
    this.medicineadded = false,
  });
}

class MedicalItem {
  final String medicalname;
  final String image;
  final String username;
  final String email;
  bool medicaladded;

  MedicalItem({
    required this.medicalname,
    required this.image,
    required this.username,
    required this.email,
    this.medicaladded = false,
  });
}
