import 'package:flutter/material.dart';
import 'package:test_app/features/auth/data/adminhome/approved_donationdto.dart';
import 'package:test_app/screens/Admin/admin_notification_screen.dart';
import '../../core/api/api_client.dart';
import '../../core/storage/user_storage.dart';
import '../../features/auth/data/adminhome/admin_donation_request_model.dart';
import '../../features/auth/data/adminhome/admin_home_service.dart';
import '../../features/auth/data/adminhome/admin_take_donation_request_model.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  String searchQuery = "";
  String apiBase = "http://10.0.2.2:5149";

  List<AdminDonationRequestedModel> _requests = [];
  List<AdminTakeDonationRequestModel> _takerequests = [];

  List<AdminDonationRequestedModel> get equipmentDonations =>
      _requests.where((r) => r.type == 'Equipment').toList();

  List<AdminDonationRequestedModel> get medicineDonations =>
      _requests.where((r) => r.type == 'Medicine').toList();

  List<AdminTakeDonationRequestModel> get equipmentTakeRequests =>
      _takerequests.where((r) => r.type == 'Equipment').toList();

  List<AdminTakeDonationRequestModel> get medicineTakeRequests =>
      _takerequests.where((r) => r.type == 'Medicine').toList();

  bool isDonationActive = true;
  String _fullName = '';

  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    _requests.clear();
    _takerequests.clear();

    await Future.wait([
      _loadEquipmentUploadRequests(),
      _loadMedicineUploadRequests(),
      _loadEquipmentTakeRequests(),
      _loadMedicineTakeRequests(),
    ]);
  }

  Future<void> _loadEquipmentUploadRequests() async {
    final data = await AdminHomeService().getPendingEquipmentRequests();
    if (!mounted) return;
    setState(() {
      _requests.addAll(data);
    });
  }

  Future<void> _loadMedicineUploadRequests() async {
    final data = await AdminHomeService().getPendingMedicineRequests();
    if (!mounted) return;
    setState(() {
      _requests.addAll(data);
    });
  }

  Future<void> _loadEquipmentTakeRequests() async {

    final data = await AdminHomeService().getPendingTakeEquipmentRequests();
    print("TAKE EQUIPMENT RESPONSE = $data");

    if (!mounted) return;
    setState(() {
      _takerequests.addAll(data);
    });
  }

  Future<void> _loadMedicineTakeRequests() async {
    final data = await AdminHomeService().getPendingTakeMedicineRequests();
    print("TAKE MEDICINE RESPONSE = $data");
    if (!mounted) return;
    setState(() {
      _takerequests.addAll(data);
    });
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    return '${date.day}/${date.month}/${date.year}';
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
              _buildButtons(width, height),
              SizedBox(height: height * 0.03),
              _buildSectionTitle("Medical equipment"),
              SizedBox(height: height * 0.015),
              _buildMedicalEquipment(width, height),
              SizedBox(height: height * 0.03),
              _buildSectionTitle("Medicines"),
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
            const Text("☀️ Good Morning",
                style: TextStyle(fontSize: 16, color: Colors.black54)),
            Text(
              _fullName.isEmpty ? '...' : _fullName,
              style: TextStyle(
                fontSize: width * 0.065,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        /*Stack(
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
        ),*/
      ],
    );
  }

  Widget _buildSearchBar(double width, double height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                SizedBox(width: 10),
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

  Widget _buildButtons(double width, double height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildActionButton("Donation", isDonationActive, () {
          setState(() {
            isDonationActive = true;
          });
        }),
        SizedBox(width: width * 0.04),
        _buildActionButton("Request", !isDonationActive, () {
          setState(() {
            isDonationActive = false;
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

  /////////////////////////////////////////////////////////////
  /// EQUIPMENT LIST
  /////////////////////////////////////////////////////////////

  Widget _buildMedicalEquipment(double width, double height) {
    // 1️⃣ تجهيز القائمة حسب التاب
    List<dynamic> baseList = isDonationActive
        ? equipmentDonations   // List<AdminDonationRequestedModel>
        : equipmentTakeRequests; // List<AdminTakeDonationRequestModel>

    // 2️⃣ تطبيق فلترة البحث
    final filteredList = searchQuery.isEmpty
        ? baseList
        : baseList.where((item) {
      return item.itemName.toLowerCase().contains(searchQuery) ||
          item.userName.toLowerCase().contains(searchQuery);
    }).toList();

    return SizedBox(
      height: height * 0.23,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final item = filteredList[index];

          // ⭐⭐ نوع العنصر يتحدد هنا
          final String name = item.itemName;
          final int qty = item.quantity ?? 0;
          final int reqId = item.requestId ?? item.donationId ?? 0;
          final int userId = item.userId ?? 0;
          final String img = item.image1 ?? "";

          return _buildEquipmentCard(
            width,
            height,
            name,
            qty,
            item.userName,
            item.userEmail,
            reqId,
            img,
            isDonationActive,
            userId,
          );
        },
      ),
    );
  }


  Widget _buildEquipmentCard(
      double width,
      double height,
      String itemName,
      int quantity,
      String userName,
      String userEmail,
      int requestId,
      String image1,
      bool isUploadRequest,
      int userId) {

    return Container(
      width: width * 0.65,
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
            child: Image.network(
              '${apiBase}$image1',
              width: 250,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/placeholder.jpg',
                  width: 250,
                  height: 120,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 6),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(itemName,
                      style:
                      const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  Text("Quantity: $quantity",
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 13)),
                  const SizedBox(height: 5),
                  Text(userName,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 13)),
                  Text(userEmail,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 13)),
                ],
              ),

              const SizedBox(width: 10),

              Row(
                children: [
                  // REJECT
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
                            offset: Offset(0, 2))
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.close_rounded),
                      color: Colors.red,
                      iconSize: 20,
                      onPressed: () async {
                        bool success;

                        if (isUploadRequest) {
                          success = await AdminHomeService()
                              .rejectEquipmentRequest(requestId);
                        } else {
                          final dto = RequestRejectDonationDto(
                            donationId: requestId,
                            userId: userId,
                            quantity: quantity,
                          );

                          success = await AdminHomeService()
                              .rejectTakeEquipmentDonation(requestId);
                        }

                        if (success) {
                          await _loadAllData();
                          setState(() {});
                        }
                      },
                    ),
                  ),

                  const SizedBox(width: 6),

                  // APPROVE
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
                            offset: Offset(0, 2))
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.check_circle),
                      color: Colors.green,
                      iconSize: 20,
                      onPressed: () async {
                        bool success;

                        if (isUploadRequest) {
                          final dto =
                          ApproveEquipmentRequestDto(requestEquipmentId: requestId);
                          success = await AdminHomeService()
                              .approveEquipmentRequest(dto);
                        } else {
                          final dto = ApproveDonationDto(
                            donationId: requestId,
                            receiverUserId: userId,
                            quantity: quantity,
                          );

                          success = await AdminHomeService()
                              .approveTakeEquipmentDonation(dto);
                        }


                        if (success) {
                          await _loadAllData();
                          setState(() {});
                        }
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
  }

  /////////////////////////////////////////////////////////////
  /// MEDICINES LIST
  /////////////////////////////////////////////////////////////

  Widget _buildmedicinesList(double width, double height) {
    // 1️⃣ تحديد القائمة الأساسية حسب التاب الحالي
    final List<dynamic> baseList = isDonationActive
        ? medicineDonations
        : medicineTakeRequests;

    // 2️⃣ تطبيق الفلترة حسب searchQuery
    final filteredList = searchQuery.isEmpty
        ? baseList
        : baseList.where((item) {
      final name = item.itemName.toLowerCase();
      final query = searchQuery.toLowerCase().trim();
      return name.contains(query);
    }).toList();

    return Expanded(
      child: ListView.builder(
        itemCount: filteredList.length,
        padding: EdgeInsets.symmetric(horizontal: width * 0.01),
        itemBuilder: (context, index) {
          final item = filteredList[index];

          // ⭐ تجهيز القيم المشتركة للحالتين
          final name = item.itemName;
          final qty = item.quantity ?? 0;
          final userName = item.userName;
          final userEmail = item.userEmail;
          final userId = item.userId ?? 0;
          final requestId = item.requestId ?? item.donationId ?? 0;

          return _buildMedicineTile(
            width,
            height,
            name,
            qty,
            userName,
            userEmail,
            requestId,
            isDonationActive,
            userId,
          );
        },
      ),
    );
  }


  Widget _buildMedicineTile(
      double width,
      double height,
      String name,
      int quantity,
      String userName,
      String userEmail,
      int requestId,
      bool isUploadRequest,
      int userId) {
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
                  Text(name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  Text("Qty: $quantity",
                      style:
                      const TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(width: 6),
                  Text(userName,
                      style: const TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w600,
                          fontSize: 13)),
                  Text(userEmail,
                      style: const TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w600,
                          fontSize: 13)),
                ],
              ),
            ],
          ),

          Row(
            children: [
              // REJECT
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
                  icon: const Icon(Icons.close_rounded),
                  color: Colors.red,
                  iconSize: 20,
                  onPressed: () async {
                    bool success;

                    if (isUploadRequest) {
                      success = await AdminHomeService()
                          .rejectMedicineRequest(requestId);
                    } else {
                      final dto = RequestRejectDonationDto(
                        donationId: requestId,
                        userId: userId,
                        quantity: quantity,
                      );

                      success = await AdminHomeService()
                          .rejectTakeMedicineDonation(requestId);
                    }

                    if (success) {
                      await _loadAllData();
                      setState(() {});
                    }
                  },
                ),
              ),

              const SizedBox(width: 8),

              // APPROVE
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
                  icon: const Icon(Icons.check_circle),
                  color: Colors.green,
                  iconSize: 20,
                  onPressed: () async {
                    bool success;

                    if (isUploadRequest) {
                      final dto =
                      ApproveMedicineRequestDto(requestMedicineId: requestId);
                      success = await AdminHomeService()
                          .approveMedicineRequest(dto);
                    } else {
                      final dto = ApproveDonationDto(
                        donationId: requestId,
                        receiverUserId: userId,
                        quantity: quantity,
                      );

                      success = await AdminHomeService()
                          .approveTakeMedicineDonation(dto);
                    }


                    if (success) {
                      await _loadAllData();
                      setState(() {});
                    }
                  },
                ),
              ),
            ],
          ),
        ],
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
