class DonationMedicineModel {
  final int donationMedicineId;
  final String itemName;
  final int quantity;
  final String? image1;
  final String? expiry;

  DonationMedicineModel({
    required this.donationMedicineId,
    required this.itemName,
    required this.quantity,
    this.image1,
    this.expiry,
  });

  factory DonationMedicineModel.fromJson(Map<String, dynamic> json) {
    return DonationMedicineModel(
      donationMedicineId: json['donationMedicineId'] as int,
      itemName: json['itemName'] as String,
      quantity: json['quantity'] as int,
      image1: json['image1'] as String?,
      expiry: json['expiry'] as String?,
    );
  }
}
