class AdminDonationRequestedModel {
  final int requestId;
  final String itemName;
  final int quantity;
  final String? expirationDate;
  final int userId;
  final String userName;
  final String userEmail;
  final String type;
  final String image1;


  AdminDonationRequestedModel({
    required this.requestId,
    required this.itemName,
    required this.quantity,
    required this.expirationDate,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.type,
    required this.image1
  });

  factory AdminDonationRequestedModel.fromJson(Map<String, dynamic> json) {
    return AdminDonationRequestedModel(
      requestId: json["requestId"],
      itemName: json["itemName"],
      quantity: json["quantity"],
      expirationDate: json["expirationDate"],
      userId: json["userId"],
      userName: json["userName"],
      userEmail: json["userEmail"],
      type: json["type"],
      image1: json['image1'],

    );
  }
}