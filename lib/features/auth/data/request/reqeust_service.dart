import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_app/features/auth/data/request/unavailable_reqeust_model.dart';
import '../../../../core/storage/token_storage.dart';

class RequestService {
  final String baseUrl = "http://10.0.2.2:5149/api/Requests";

  // 🔹 Get unavailable equipment
  Future<List<UnavailableRequest>> getUnavailableEquipment() async {
    final token = await TokenStorage.getAccessToken();

    final res = await http.get(
      Uri.parse("$baseUrl/getUnavailableEquipmentRequests"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => UnavailableRequest.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load unavailable equipment");
    }
  }

  // 🔹 Get unavailable medicine
  Future<List<UnavailableRequest>> getUnavailableMedicine() async {
    final token = await TokenStorage.getAccessToken();

    final res = await http.get(
      Uri.parse("$baseUrl/getUnavailableMedicineRequests"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => UnavailableRequest.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load unavailable medicine");
    }
  }
  Future<List<UnavailableRequest>> getMyUnavailableEquipment() async {
    final token = await TokenStorage.getAccessToken();

    final res = await http.get(
      Uri.parse("$baseUrl/getMyUnavailableEquipmentRequests"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => UnavailableRequest.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load unavailable equipment request");
    }
  }
  Future<List<UnavailableRequest>> getMyUnavailableMedicine() async {
    final token = await TokenStorage.getAccessToken();

    final res = await http.get(
      Uri.parse("$baseUrl/getMyUnavailableMedicineRequests"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => UnavailableRequest.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load unavailable medicine request");
    }
  }
  Future<List<UnavailableRequest>> getMyPendingTakeEquipmentDonationRequestsAsync() async {
    final token = await TokenStorage.getAccessToken();

    final res = await http.get(
      Uri.parse("http://10.0.2.2:5149/api/donations/my/pending-take-equipment"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => UnavailableRequest.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load unavailable medicine request");
    }
  }
  Future<List<UnavailableRequest>> getMyPendingTakeMedicineDonationRequestsAsync() async {
    final token = await TokenStorage.getAccessToken();

    final res = await http.get(
      Uri.parse("http://10.0.2.2:5149/api/donations/my/pending-take-medicine"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => UnavailableRequest.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load unavailable medicine request");
    }
  }
  Future<void> createUnavailableEquipment({
    required String itemName,
    required String description,
  }) async {
    final token = await TokenStorage.getAccessToken();

    final res = await http.post(
      Uri.parse("$baseUrl/createUnavailableEquipment"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "itemName": itemName,
        "itemDesc": description,
      }),
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to create unavailable equipment");
    }
  }

  Future<void> createUnavailableMedicine({
    required String itemName,
    required String description,
  }) async {
    final token = await TokenStorage.getAccessToken();

    final res = await http.post(
      Uri.parse("$baseUrl/createUnavailableMedicine"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "itemName": itemName,
        "itemDesc": description,
      }),
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to create unavailable medicine");
    }
  }


}
