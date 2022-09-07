import 'package:saccofy/sacco/models/create_sacco_model.dart';
import 'package:saccofy/user/models/user_model.dart';

class DepositFundsToSacco {
  String? id;
  UserModel? member;
  String? saccoId;
  double? amountDeposited;
  String? dateDeposited;
  String? referenceNumber;
  String? modeOfPayment;

  DepositFundsToSacco();

  DepositFundsToSacco.fromMap(Map<String, dynamic> payment) {
    id = payment["id"];
    member = payment["member"];
    saccoId = payment["saccoId"];
    amountDeposited = payment["amountDeposited"];
    dateDeposited = payment["dateDeposited"];
    referenceNumber = payment["referenceNumber"];
    modeOfPayment = payment["modeOfPayment"];

    Map<String, dynamic> toMap() {
      return {
        "id": id,
        "member": member,
        "saccoId": saccoId,
        "amountDeposited": amountDeposited,
        "dateDeposited": dateDeposited,
        "referenceNumber": referenceNumber,
        "modeOfPayment": modeOfPayment
      };
    }
  }
}
