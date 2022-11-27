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
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Hello Portfolio',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
        ),
      ),
    );
  }
}
