import 'package:flutter/material.dart';

import 'iluminar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedIluminarContainer(
        builder: (context) => const _HomeContent(),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        const SizedBox(height: 64),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'cordea',
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Colors.black,
                ),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Yoshihiro Tanaka',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Android/Flutter applications engineer',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.black54,
                ),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'SNS',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.black,
                ),
          ),
        ),
        const SizedBox(height: 8),
        ListTile(
          title: Text('GitHub'),
          onTap: () {},
        ),
        ListTile(
          title: Text('LinkedIn'),
          onTap: () {},
        ),
        ListTile(
          title: Text('Medium'),
          onTap: () {},
        ),
      ],
    );
  }
}
