import 'package:flutter/material.dart';

import 'iluminar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedIluminarContainer(
        builder: (context) => Center(
          child: Text(
            'Iluminar',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
      ),
    );
  }
}
