import 'package:flutter/material.dart';

class DepositToSacco extends StatefulWidget {
  const DepositToSacco({Key? key}) : super(key: key);

  @override
  State<DepositToSacco> createState() => _DepositToSaccoState();
}

class _DepositToSaccoState extends State<DepositToSacco> {
  TextEditingController selectpaymentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deposit'),
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

  depositToSacco() {}

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

  String? dropdownValue;
// business type widget
  Widget selectPaymentMethod() {
    return SizedBox(
        width: 310,
        height: 50,
        child: DropdownButtonFormField<String>(
          elevation: 10,
          decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
                borderSide: BorderSide(width: 1, color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                // borderRadius: BorderRadius.all(Radius.circular(32.0)),
                borderSide: BorderSide(width: 1, color: Colors.black),
              ),
              filled: true,
              fillColor: Colors.white,
              hintStyle: TextStyle(color: Colors.black),
              hintText: "Select Deposit Method",
              labelStyle: TextStyle(color: Colors.black)),
          // itemHeight: 20.0,
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down_outlined, color: Colors.black),
          style: const TextStyle(
              fontSize: 12, color: Colors.black, fontFamily: 'times'),
          // validator: (String? value) {
          //   if (value!.isEmpty) {
          //     return 'This field is required';
          //   }
          //   return null;
          // },
          // onSaved: (String? value) {
          //   _startup.category = value!;
          // },
          // elevation: 12,

          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
              selectpaymentController.text = dropdownValue!;
            });
          },
          items: <String>[
            'Mpesa',
            'Bank',
            // '15',
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
}
