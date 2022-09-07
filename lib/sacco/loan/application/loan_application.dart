import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/payment/mpesa/integrations.dart';
import 'package:saccofy/sacco/loan/models/loan_request_model.dart';
import 'package:saccofy/sacco/loan/notifier/loan_notifier.dart';
import 'package:saccofy/user/account/login.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';

class LoanApplicationForm extends StatefulWidget {
  const LoanApplicationForm({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoanApplicationFormState createState() => _LoanApplicationFormState();
}

class _LoanApplicationFormState extends State<LoanApplicationForm> {
  TextEditingController businessCategoryController = TextEditingController();
  TextEditingController appdateController = TextEditingController();
  TextEditingController repaydateController = TextEditingController();

  LoanRequest request = LoanRequest();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> applicationDate() async {
    DateTime? selectDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2023),
    );

    if (picked != null && picked != selectDate) {
      setState(
        () {
          selectDate = picked;
          var date =
              "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
          appdateController.text = date;
        },
      );
    }
  }

  Future repayDate() async {
    DateTime? selectDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2023),
    );
    if (picked != null && picked != selectDate) {
      setState(
        () {
          selectDate = picked;
          var date =
              "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
          repaydateController.text = date;
        },
      );
    }
  }

  // ignore: non_constant_identifier_names
  Widget dateOfLoanApplication() {
    return SizedBox(
      width: 130,
      height: 45,
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.calendar_today,
              size: 16,
              color: Colors.pink[300],
            ),
            labelText: 'Apply Date',
            enabledBorder: const OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            focusedBorder: const OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            hintText: 'Date Of Application',
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelStyle: const TextStyle(color: Colors.black)),
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 10, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        controller: appdateController,
        onTap: () {
          applicationDate();
          FocusScope.of(context).requestFocus(FocusNode());
        },
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        onSaved: (String? value) {
          request.dateOfRequest = value as Timestamp;
        },
      ),
    );
  }

  Widget loanType() {
    return SizedBox(
      width: 130,
      height: 45,
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.merge_type,
              size: 16,
              color: Colors.pink[300],
            ),
            labelText: 'Loan Type',
            enabledBorder: const OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            focusedBorder: const OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            hintText: 'Loan Type',
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelStyle: const TextStyle(color: Colors.black)),
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 10, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        onSaved: (String? value) {
          request.loanType = value;
        },
      ),
    );
  }

  Widget repaymentDate() {
    return SizedBox(
      width: 270,
      height: 45,
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.calendar_today,
              size: 16,
              color: Colors.pink[300],
            ),
            labelText: 'Repayment Date',
            enabledBorder: const OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            focusedBorder: const OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            hintText: 'Repayment Date',
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelStyle: const TextStyle(color: Colors.black)),
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 10, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        controller: repaydateController,
        onTap: () {
          repayDate();
          FocusScope.of(context).requestFocus(FocusNode());
        },
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        onSaved: (String? value) {
          request.dateOfRepayment = value as Timestamp;
        },
      ),
    );
  }

  Widget purpose() {
    return SizedBox(
      width: 270,
      height: 45,
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.info_outline,
              size: 16,
              color: Colors.pink[300],
            ),
            labelText: 'Purpose',
            enabledBorder: const OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            focusedBorder: const OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            hintText: 'Purpose',
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelStyle: const TextStyle(color: Colors.black)),
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 10, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        onSaved: (String? value) {
          request.purpose = value;
        },
      ),
    );
  }

  Widget amountRequesting() {
    return SizedBox(
        width: 130,
        height: 45,
        child: TextFormField(
          decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.money,
                size: 16,
                color: Colors.pink[300],
              ),
              labelText: 'Amount',
              enabledBorder: const OutlineInputBorder(
                // borderRadius: BorderRadius.all(Radius.circular(32.0)),
                borderSide: BorderSide(width: 1, color: Colors.black),
              ),
              focusedBorder: const OutlineInputBorder(
                // borderRadius: BorderRadius.all(Radius.circular(32.0)),
                borderSide: BorderSide(width: 1, color: Colors.black),
              ),
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              filled: true,
              // hintText: 'Email',
              // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              labelStyle: const TextStyle(color: Colors.black)),
          keyboardType: TextInputType.name,
          style: const TextStyle(
              fontSize: 10, color: Colors.black, fontFamily: 'times'),
          cursorColor: Colors.black,
          validator: (String? value) {
            if (value!.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          onSaved: (String? value) {
            request.amount = value!;
          },
        ));
  }

  String? dropdownValue;
// business type widget
  Widget interestRate() {
    return SizedBox(
        width: 130,
        height: 45,
        child: DropdownButtonFormField<String>(
          decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                // borderRadius: BorderRadius.all(Radius.circular(32.0)),
                borderSide: BorderSide(width: 1, color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                // borderRadius: BorderRadius.all(Radius.circular(32.0)),
                borderSide: BorderSide(width: 1, color: Colors.black),
              ),
              filled: true,
              fillColor: Colors.white,
              hintStyle: TextStyle(color: Colors.black, fontSize: 10),
              hintText: "Interest Rate",
              labelStyle: TextStyle(color: Colors.black)),
          // itemHeight: 20.0,
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down_outlined, color: Colors.black),
          style: const TextStyle(
              fontSize: 10, color: Colors.black, fontFamily: 'times'),
          validator: (String? value) {
            if (value!.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          onSaved: (String? value) {
            request.interestRate = value! as int;
          },
          elevation: 12,

          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
              businessCategoryController.text = dropdownValue!;
            });
          },
          items: <String>[
            '5',
            '10',
            '15',
          ].map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            },
          ).toList(),
        ));
  }

  _onLoanRequest(LoanRequest request) {
    LoanNotifier loanNotifier =
        Provider.of<LoanNotifier>(context, listen: false);

    loanNotifier.addLoan(request);
    Navigator.pop(context);
  }

  PaymentFunctions pay = PaymentFunctions();

  Future<void> requestLoanFunc() async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      _formKey.currentState!.save();
      AuthNotifier authNotifier =
          Provider.of<AuthNotifier>(context, listen: false);
      pay.requestLoan(authNotifier.user!.uid, request, _onLoanRequest);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Loan Application",
          // style: TextStyle(color: Colors.pink),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink[300],
      ),
      body: form(),
    );
  }

  Widget form() {
    return Center(
      child: Form(
        // ignore: deprecated_member_use
        autovalidateMode: AutovalidateMode.always, key: _formKey,
        child: SingleChildScrollView(
          child: SizedBox(
              width: 350,
              height: 600,
              child: Card(
                shadowColor: Colors.pink[100],
                elevation: 8.0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 20, 32, 0),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 120,
                        top: 0,
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    children: const <Widget>[
                                      // profileImage(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 50,
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      dateOfLoanApplication(),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      loanType(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 120,
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  amountRequesting(),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  interestRate(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 192,
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      purpose(),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 265,
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      repaymentDate(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 335,
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    children: const <Widget>[
                                      // password(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 65,
                        top: 380,
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.pink[300],
                          child: MaterialButton(
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10),
                            minWidth: 150,
                            onPressed: () => requestLoanFunc(),
                            child: const Text(
                              'Request Loan',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Positioned(
                      //   left: 50,
                      //   top: 490,
                      //   child: Column(
                      //     children: <Widget>[
                      //       GestureDetector(
                      //         behavior: HitTestBehavior.translucent,
                      //         child: Row(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceEvenly,
                      //           children: <Widget>[
                      //             Row(
                      //               children: <Widget>[
                      //                 notAccomplished(),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Widget notAccomplished() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginUserForm()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
