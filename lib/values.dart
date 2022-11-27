import 'package:flutter/material.dart';
import 'coingecko/coins.dart' as cng_coins;

class Values {
  final PageController pageController = PageController(
    initialPage: 0,
  );
  Future<List<dynamic>> cryptoListFeed = refreshCrypto('usd', 250);
  String query = '';
  var topBarIcon = Icons.search;
  int activePageIndex = 0;
  Widget barTitle = const Text('Garasu');


  Values(String vsCurrencies, int n) {
    cryptoListFeed = refreshCrypto(vsCurrencies, n);
  }
}

Future<List<dynamic>> refreshCrypto(String vsCurrencies, int n) async {
  return cng_coins.markets(vsCurrencies, n);
}