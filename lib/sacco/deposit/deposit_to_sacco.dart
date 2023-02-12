import 'package:flutter/material.dart';
import 'package:mpesa/mpesa.dart';
import 'package:saccofy/payment/mpesa/functions/mpesa.dart';
import 'package:saccofy/sacco/deposit/functions/functions.dart';
import 'package:saccofy/sacco/deposit/model/member_contributions.dart';
import 'package:saccofy/sacco/models/create_sacco_model.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:saccofy/user/models/user_model.dart';

class DepositToSacco extends StatefulWidget {
  const DepositToSacco({Key? key}) : super(key: key);

  @override
  State<DepositToSacco> createState() => _DepositToSaccoState();
}

class _DepositToSaccoState extends State<DepositToSacco> {
  TextEditingController selectpaymentController = TextEditingController();
  DepositService depositService =
      DepositService(); //initialization of deposit service to sacco

  Deposit? deposit;
  Sacco sacco = Sacco();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Deposit To Sacco',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // handle the press
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: 120,
            top: 200,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          depositButton(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 50,
            top: 50,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          depositDetails(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 140,
            top: 80,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          depositDetails2(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 50,
            top: 150,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          // selectPaymentMethod(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  depositToSacco() {
    AuthNotifier authNotifier = AuthNotifier();
    GetMpesaSTK getMpesa = GetMpesaSTK();
    getMpesa.deposit();
  }

  Widget depositButton() {
    return Center(
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10),
          minWidth: 200,
          onPressed: () => depositToSacco(),
          child: const Text(
            'Deposit',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget depositDetails() {
    return Row(
      children: const [
        Text(
          'Make A Deposit',
          style: TextStyle(fontSize: 25, color: Colors.pinkAccent),
        ),
      ],
    );
  }

  Widget depositDetails2() {
    return Row(
      children: const [
        Text(
          'To Sacco',
          style: TextStyle(fontSize: 25),
        ),
      ],
    );
  }

  UserModel user = UserModel();

// How It Should Look Lile
// MPESA SECTION
  Future<void> performMpesaTransaction() async {
    // Perform the MPESA transaction here and retrieve the transaction ID
    Mpesa pesa = Mpesa(
        clientKey: 'clientKey',
        clientSecret: 'clientSecret',
        environment: 'environment',
        passKey: 'passKey');

    // Assign the transaction ID as the reference number for the deposit
    pesa.lipaNaMpesa(
        phoneNumber: user.phonenumber.toString(),
        amount: deposit!.depositAmount!.toDouble(),
        accountReference: deposit!.referenceNumber.toString(),
        callbackUrl: 'callbackUrl') as String?;

    // Add the deposit to the Firestore
    // await depositService.addDeposit(sacco.saccoId, deposit!);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}
