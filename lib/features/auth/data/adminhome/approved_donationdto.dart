class ApproveDonationDto {
  final int donationId;
  final int receiverUserId;
  final int quantity;

  ApproveDonationDto({
    required this.donationId,
    required this.receiverUserId,
    required this.quantity
  });

  Map<String, dynamic> toJson() => {
    "donationId": donationId,
    "receiverUserId": receiverUserId,
    "quantity": quantity,
  };
}

class RequestRejectDonationDto {
  final int donationId;
  final int userId;
  final int quantity;

  RequestRejectDonationDto({
    required this.donationId,
    required this.userId,
    required this.quantity
  });

  Map<String, dynamic> toJson() => {
    "donationId": donationId,
    "userId": userId,
    "quantity": quantity,
  };
}
