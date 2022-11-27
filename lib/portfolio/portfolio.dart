import 'package:flutter/material.dart';

class Portfolio extends StatefulWidget {
  // final double currentPrice;

  const Portfolio({
    super.key,
    // required this.currentPrice,
  });

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  // do it with route
  bool _addNewCrypto = false;

  @override
  Widget build(BuildContext context) {
    if (!_addNewCrypto) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'To add new row click on the button below:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
            FilledButton(
              onPressed: () {
                setState(() {
                  _addNewCrypto = true;
                });
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.green.withOpacity(0.2),
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
              ),
              child: const Text(
              '     +     ',
              style: TextStyle(
                color: Colors.green,
              ),
            ),
      ),
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'To go back click button below: ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
            FilledButton(
                onPressed: () {
                  setState(() {
                    _addNewCrypto = false;
                  });
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.green.withOpacity(0.2),
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                ),
                child: const Text(
                  'Go back',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                )
            ),
          ],
        ),
      );
    }
  }
}
