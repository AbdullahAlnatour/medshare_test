import '../../../../core/api/api_client.dart';
import 'donation_equipment_model.dart';
import 'donation_medicine_model.dart';

class DonationsService {
  Future<List<DonationEquipmentModel>> getApprovedEquipment() async {
    final res = await ApiClient.dio.get('/donations/GetApprovedEquipment');
    return (res.data as List)
        .map((e) => DonationEquipmentModel.fromJson(e))
        .toList();
  }

  Future<List<DonationMedicineModel>> getApprovedMedicines() async {
    final res = await ApiClient.dio.get('/donations/GetApprovedMedicines');
    return (res.data as List)
        .map((e) => DonationMedicineModel.fromJson(e))
        .toList();
  }
}
