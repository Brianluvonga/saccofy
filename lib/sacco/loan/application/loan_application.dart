import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/payment/mpesa/integrations.dart';
import 'package:saccofy/sacco/loan/functions/loan_functions.dart';
import 'package:saccofy/sacco/loan/models/loan_request_model.dart';
import 'package:saccofy/sacco/loan/notifier/loan_notifier.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';
import 'package:saccofy/user/account/login.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:saccofy/user/auth/firebase/user_notifier.dart';

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
  LoanService loanService = LoanService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isSubmittingLoanRequest = false;

  Future<void> saveLoanRequest() async {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      _formKey.currentState!.save();
      setState(() {
        isSubmittingLoanRequest = true;
      });
      // get current member submitting loan request
      var currentMember = FirebaseAuth.instance.currentUser;

      await loanService.submitLoanRequest(currentMember!.uid.toString(),
          saccoNotifier.currentSacco.saccoId.toString(), request);
      Navigator.pop(context);

      // ignore: use_build_context_synchronously
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => const SaccoFeed(),
      //   ),
      // );
    }
  }

  Future<void> applicationDate() async {
    DateTime? selectDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: const Color(0xff1c3751),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
            colorScheme:
                const ColorScheme.dark().copyWith(secondary: Colors.red),
          ),
          child: child!,
        );
      },
      initialDate: selectDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
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
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
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
      width: 270,
      height: 60,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: TextFormField(
          readOnly: true,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.calendar_today,
                size: 16,
                color: Colors.pink[300],
              ),
              labelText: 'Application Date',
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
              hintStyle: const TextStyle(fontFamily: 'times', fontSize: 10),
              // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              labelStyle: const TextStyle(
                  color: Colors.black, fontFamily: 'times', fontSize: 10)),
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
          onSaved: (value) {
            request.dateOfRequest = value;
          },
        ),
      ),
    );
  }

  Widget loanType() {
    return SizedBox(
      width: 130,
      height: 50,
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
          // request.loanType = value;
        },
      ),
    );
  }

  Widget repaymentDate() {
    return SizedBox(
      width: 270,
      height: 50,
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
          request.dateOfRepayment = value;
        },
      ),
    );
  }

  Widget purpose() {
    return SizedBox(
      width: 270,
      height: 50,
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
          request.loanPurpose = value;
        },
      ),
    );
  }

  Widget amountRequesting() {
    return SizedBox(
        width: 270,
        height: 50,
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
          onSaved: (value) {
            request.loanAmount = value;
          },
        ));
  }

  String? dropdownValue;
// business type widget
  Widget interestRate() {
    return SizedBox(
        width: 270,
        height: 50,
        child: TextFormField(
          decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.money,
                size: 16,
                color: Colors.pink[300],
              ),
              labelText: 'Set Interest Rate',
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
          onSaved: (value) {
            request.interestRate = value;
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Loan Application",
          style: TextStyle(fontFamily: 'times', fontSize: 12),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff1c3751),
        actions: [],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 15,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isSubmittingLoanRequest
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : form(),
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
              height: 500,
              child: Card(
                shadowColor: const Color(0xff1c3751),
                elevation: 8.0,
                // color: const Color(0xff1c3751),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 20, 32, 0),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      dateOfLoanApplication(),
                      const SizedBox(
                        height: 5,
                      ),
                      amountRequesting(),
                      const SizedBox(
                        height: 15,
                      ),
                      interestRate(),
                      const SizedBox(
                        height: 15,
                      ),
                      purpose(),
                      const SizedBox(
                        height: 15,
                      ),
                      repaymentDate(),
                      const SizedBox(
                        height: 15,
                      ),
                      Positioned(
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: const Color(0xff1c3751),
                          child: MaterialButton(
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10),
                            minWidth: 50,
                            onPressed: () => saveLoanRequest(),
                            child: const Text(
                              'Request Loan',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
