class Deposit {
  String? depositID; //A unique identifier for the deposit
  String? userId; //uid for user depositing to sacco
  String? saccoID; // uid for sacco
  double? depositAmount; //The depositAmount of the deposit
  DateTime? depositDate;
  String? referenceNumber;
  String? depositMethod;

  Deposit(
      {this.depositID,
      this.saccoID,
      this.userId,
      this.depositAmount,
      this.depositDate,
      this.referenceNumber,
      this.depositMethod});

  factory Deposit.fromMap(Map<String, dynamic> data) {
    return Deposit(
      depositID: data['depositID'],
      userId: data['userId'],
      saccoID: data['saccoID'],
      depositAmount: data['depositAmount'],
      depositDate: data['depositDate'],
      referenceNumber: data['referenceNumber'],
      depositMethod: data['depositMethod'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'depositID': depositID,
      'userId': userId,
      'saccoID': saccoID,
      'depositAmount': depositAmount,
      'depositDate': depositDate,
      'referenceNumber': referenceNumber,
      'depositMethod': depositMethod
    };
  }
}
