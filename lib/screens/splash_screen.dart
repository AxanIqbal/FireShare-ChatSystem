import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                backgroundColor: Theme.of(context).accentColor,
              ),
              const Text("Splash")
            ],
          ),
        ));
  }
}
