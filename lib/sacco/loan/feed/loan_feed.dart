import 'package:flutter/material.dart';

class SaccoLoanFeed extends StatefulWidget {
  const SaccoLoanFeed({super.key});

  @override
  State<SaccoLoanFeed> createState() => _SaccoLoanFeedState();
}

class _SaccoLoanFeedState extends State<SaccoLoanFeed> {
  Future refreshList() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'Loan History',
      //     style: TextStyle(fontFamily: 'times', fontSize: 14),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: const Color(0xff1c3751),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(
      //         Icons.search,
      //         size: 20,
      //       ),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder(
            // future: fetchSacco(saccoNotifier, currentMember!.uid),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Color(0xff1c3751),
                  ),
                );
              }
              // check if snapshot.data is null
              if (snapshot.hasData && snapshot.data != null) {
                return const Center(
                    // child: saccoGrid(),
                    );
              } else {
                return const Center(
                  child: Text('No Loan Records At The Moment'),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
