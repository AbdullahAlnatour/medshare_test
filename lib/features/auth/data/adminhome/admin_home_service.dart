import '../../../../core/api/api_client.dart';
import 'admin_donation_request_model.dart';
import 'admin_take_donation_request_model.dart';

class ApproveEquipmentRequestDto {
  final int requestEquipmentId;

  ApproveEquipmentRequestDto({required this.requestEquipmentId});

  Map<String, dynamic> toJson() => {
    "requestEquipmentId": requestEquipmentId,
  };
}
class ApproveMedicineRequestDto {
  final int requestMedicineId;

  ApproveMedicineRequestDto({required this.requestMedicineId});

  Map<String, dynamic> toJson() => {
    "requestMedicineId": requestMedicineId,
  };
}

class AdminHomeService {
  // 📌 1) Get pending equipment upload requests
  Future<List<AdminDonationRequestModel>> getPendingEquipmentRequests() async {
    final res =
    await ApiClient.dio.get('/requests/getPendingEquipmentRequests');

    return (res.data as List)
        .map((e) => AdminDonationRequestModel.fromJson(e))
        .toList();
  }

  // 📌 2) Get pending medicine upload requests
  Future<List<AdminDonationRequestModel>> getPendingMedicineRequests() async {
    final res =
    await ApiClient.dio.get('/requests/getPendingMedicineRequests');

    return (res.data as List)
        .map((e) => AdminDonationRequestModel.fromJson(e))
        .toList();
  }

  // 📌 3) Get pending take equipment requests (requests for taking donations)
  Future<List<AdminTakeDonationRequestModel>>
  getPendingTakeEquipmentRequests() async {
    final res =
    await ApiClient.dio.get('/donations/admin/pendingMedicineTake');

    return (res.data as List)
        .map((e) => AdminTakeDonationRequestModel.fromJson(e))
        .toList();
  }

  // 📌 4) Get pending take medicine requests
  Future<List<AdminTakeDonationRequestModel>>
  getPendingTakeMedicineRequests() async {
    final res =
    await ApiClient.dio.get('/donations/admin/pendingEquipmentTake');

    return (res.data as List)
        .map((e) => AdminTakeDonationRequestModel.fromJson(e))
        .toList();
  }

  // -------------------------------------------------------------
  // 🟢 APPROVE REQUESTS
  // -------------------------------------------------------------

  // ✔ Approve Equipment Upload Request
  Future<bool> approveEquipmentRequest(ApproveEquipmentRequestDto dto) async {
    final res = await ApiClient.dio.put(
      '/Requests/approveEquipmentRequest',
      data: dto.toJson(),
    );

    return res.statusCode == 200;
  }


  Future<bool> approveMedicineRequest(ApproveMedicineRequestDto dto) async {
    final res = await ApiClient.dio.put(
      '/Requests/approveMedicineRequest',
      data: dto.toJson(),
    );

    return res.statusCode == 200;
  }


  // -------------------------------------------------------------
  // 🔴 REJECT REQUESTS
  // -------------------------------------------------------------

  // ❌ Reject Equipment Upload Request
  Future<bool> rejectEquipmentRequest(int requestId) async {
    final body = {"requestEquipmentId": requestId};

    final res = await ApiClient.dio.put(
      '/Requests/rejectEquipmentRequest',
      data: body,
    );

    return res.statusCode == 200;
  }

  // ❌ Reject Medicine Upload Request
  Future<bool> rejectMedicineRequest(int requestId) async {
    final body = {"requestMedicineId": requestId};

    final res = await ApiClient.dio.put(
      '/Requests/rejectMedicineRequest',
      data: body,
    );

    return res.statusCode == 200;
  }
}