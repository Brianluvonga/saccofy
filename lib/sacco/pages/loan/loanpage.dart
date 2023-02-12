// This page displays loan activities

import 'package:flutter/material.dart';

class LoanPage extends StatefulWidget {
  const LoanPage({super.key});

  @override
  State<LoanPage> createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Center(
          child: Text(
            "Loan Section",
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert_sharp,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              // handle the press
            },
          ),
        ],
      ),
      backgroundColor: Colors.teal[50],
      body: SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          height: size.height,
          child: Stack(
            children: [
              Container(
                height: size.height * 0.25,
                color: Colors.white,
                // decoration: BoxDecoration(
                //   boxShadow: [
                //     BoxShadow(color: Colors.white, spreadRadius: 7),
                //   ],
                // ),
              ),
              Positioned(
                top: 60.0,
                left: 70,
                width: size.width,
                child: Row(
                  children: [
                    titleCounts(),
                  ],
                ),
              ),
              Positioned(
                top: 220.0,
                left: 35,
                width: size.width,
                child: loansAwaitingProcessingTitle(),
              ),
              Positioned(
                top: 250.0,
                left: 30,
                child: loansAwaitingProcessing(),
              ),
              Positioned(
                top: 360.0,
                left: 35,
                child: loansRequestedTitle(),
              ),
              Positioned(
                top: 380.0,
                left: 30,
                child: loansRequested(),
              ),
              Positioned(
                top: 480.0,
                left: 35,
                child: loansPaidTitle(),
              ),
              Positioned(
                top: 500.0,
                left: 30,
                child: loansPaid(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleCounts() {
    return Container(
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Column(
            children: const [
              Text(
                "Total Loans Given",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text('Kshs. 35,000',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(
            width: 30,
          ),
          Column(
            children: const [
              Text(
                "Total Loans Requested",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Kshs. 35,000',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Loan Widgets Section

  //  title widgets

  Widget loansAwaitingProcessingTitle() {
    return const Text(
      "Loans Awaiting Processig",
      style: TextStyle(
        color: Color.fromARGB(255, 121, 119, 119),
      ),
    );
  }

  Widget loansRequestedTitle() {
    return const Text(
      "Loans Requested",
      style: TextStyle(
        color: Color.fromARGB(255, 121, 119, 119),
      ),
    );
  }

  Widget loansPaidTitle() {
    return const Text(
      "Loans Paid",
      style: TextStyle(
        color: Color.fromARGB(255, 121, 119, 119),
      ),
    );
  }

  Widget loansAwaitingProcessing() {
    return const Card(
      elevation: 10,
      child: SizedBox(
        height: 80,
        width: 100,
        child: Center(
          child: Text('Loan Details'),
        ),
      ),
    );
  }

  Widget loansRequested() {
    return Card(
      elevation: 10,
      child: Container(
        height: 80,
        width: 100,
        child: const Center(
          child: Text("Loan Details"),
        ),
      ),
    );
  }

  Widget loansPaid() {
    return Card(
      elevation: 10,
      child: Container(
        height: 80,
        width: 100,
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Text("Loans Paid Details In Horizontal Scroll"),
          ),
        ),
      ),
    );
  }
}
