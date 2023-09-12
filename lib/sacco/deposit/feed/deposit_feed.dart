import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/deposit/functions/functions.dart';
import 'package:saccofy/sacco/deposit/notifier/deposit_notifier.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';

class SaccoDepositFeed extends StatefulWidget {
  const SaccoDepositFeed({super.key});

  @override
  State<SaccoDepositFeed> createState() => _SaccoDepositFeedState();
}

class _SaccoDepositFeedState extends State<SaccoDepositFeed> {
  //

  DepositService depositService = DepositService();

  //

  Future refreshList() async {}
  @override
  Widget build(BuildContext context) {
    DepositNotifier depositNotifier =
        Provider.of<DepositNotifier>(context, listen: false);
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    return RefreshIndicator(
      onRefresh: refreshList,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: depositService.getSaccoDeposits(
              depositNotifier, saccoNotifier.currentSacco.saccoId.toString()),
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
              return Center(
                child: depostFeed(),
              );
            } else {
              return const Center(
                child: Text('No Deposit Made At The Moment'),
              );
            }
          }),
        ),
      ),
    );
  }

  Widget depostFeed() {
    DepositNotifier depositNotifier =
        Provider.of<DepositNotifier>(context, listen: false);

    return ListView.builder(
      itemCount: depositNotifier.depositList.length,
      itemBuilder: (BuildContext ctx, index) {
        return Container(
          alignment: Alignment.center,
          // decoration: BoxDecoration(
          //     color: Color.fromARGB(255, 249, 251, 253),
          //     borderRadius: BorderRadius.circular(15),
          //     border: Border.all(color: Color.fromARGB(255, 146, 175, 202))),
          child: ListTile(
            title: Text(depositNotifier.depositList[index].userId.toString(),
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            subtitle: Text(
              depositNotifier.depositList[index].depositMethod.toString(),
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            trailing: Stack(
              children: [
                Text(
                  depositNotifier.depositList[index].depositDate.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  depositNotifier.depositList[index].depositAmount.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                )
              ],
            ),
            leading: Stack(
              children: const [
                Icon(
                  Icons.account_circle,
                  size: 30,
                  color: Color(0xff1c3751),
                ),
                Positioned(
                  child: Text('Member Name'),
                ),
              ],
            ),
            onTap: () {
              depositNotifier.currentDeposit =
                  depositNotifier.depositList[index];
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (BuildContext context) {
              //       return const SaccoHomePage();
              //     },
              //   ),
              // );
            },
          ),
        );
      },
    );
  }
}
