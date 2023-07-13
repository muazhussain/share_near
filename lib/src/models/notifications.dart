class Notifications {
  String user;
  String productName;
  DateTime date;
  String receiver;

  Notifications({
    required this.user,
    required this.productName,
    required this.date,
    required this.receiver,
  });

  Map<String, dynamic> toJSON() {
    return {
      'user': user,
      'productName': productName,
      'date': date,
      'receiver': receiver,
    };
  }
}
