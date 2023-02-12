import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/models/create_sacco_model.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';
import 'package:saccofy/sacco/pages/home/home.dart';

class SaccoSearchDelegate extends SearchDelegate {
  final List<Sacco> saccos;

  SaccoSearchDelegate({required this.saccos});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestionList = query.isEmpty
        ? []
        : saccos
            .where((sacco) =>
                sacco.saccoName!.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.business),
        title: Text(suggestionList[index].saccoName.toString()),
        onTap: () {
          // Handle the tap
        },
      ),
      itemCount: suggestionList.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    final suggestionList = query.isEmpty
        ? saccos
        : saccos
            .where((sacco) =>
                sacco.saccoName!.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.change_circle_outlined),
        title: Text(suggestionList[index].saccoName.toString()),
        onTap: () {
          // Handle the tap
          saccoNotifier.currentSacco = saccoNotifier.saccoList[index];
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const SaccoHomePage();
              },
            ),
          );
        },
      ),
      itemCount: suggestionList.length,
    );
  }
}
