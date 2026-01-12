class DonationMedicineModel {
  final int donationMedicineId;
  final String itemName;
  final int quantity;
  final String? expiry;
  final String? image1;

  DonationMedicineModel({
    required this.donationMedicineId,
    required this.itemName,
    required this.quantity,
    this.expiry,
    this.image1,
  });

  factory DonationMedicineModel.fromJson(Map<String, dynamic> json) {
    return DonationMedicineModel(
      donationMedicineId: json['donationMedicineId'],
      itemName: json['itemName'],
      quantity: json['quantity'],
      expiry: json['expirationDate'] != null
          ? json['expirationDate'].toString().split('T').first
          : null,
      image1: json['image1'],
    );
  }
}
