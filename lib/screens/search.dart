import 'package:flutter/material.dart';

import '../shared/color.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const TextField(
          decoration: InputDecoration(
            label: Text(
              'Search for a user...'
            )
          ),
        ),
      ),
    );
  }
}
