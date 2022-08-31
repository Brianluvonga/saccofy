class LoanApplicationModel {
  String? id;
  String? dateOfApplication;
  String? loanType;
  String? purpose;
  String? repaymentDate;
  String? interestRate;
  String? amount;

  LoanApplicationModel();

  LoanApplicationModel.fromMap(Map<String, dynamic> application) {
    id = application['id'];
    dateOfApplication = application['dateOfApplication'];
    loanType = application['loanType'];
    purpose = application['purpose'];
    repaymentDate = application['repaymentDate'];
    interestRate = application['interestRate'];
    amount = application['amount'];

    Map<String, dynamic> toMap() {
      return {
        'id': id,
        'dateOfApplication': dateOfApplication,
        'loanType': loanType,
        'purpose': purpose,
        'repaymentDate': repaymentDate,
        'interestRate': interestRate,
        'amount': amount,
      };
    }
  }
}
