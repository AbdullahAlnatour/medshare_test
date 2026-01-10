class DonationEquipmentModel {
  final int donationEquipmentId;
  final String itemName;
  final int quantity;
  final String? image1;

  DonationEquipmentModel({
    required this.donationEquipmentId,
    required this.itemName,
    required this.quantity,
    this.image1,
  });

  factory DonationEquipmentModel.fromJson(Map<String, dynamic> json) {
    return DonationEquipmentModel(
      donationEquipmentId: json['donationEquipmentId'] as int,
      itemName: json['itemName'] as String,
      quantity: json['quantity'] as int,
      image1: json['image1'] as String?,
    );
  }
}
