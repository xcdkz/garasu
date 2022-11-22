import 'package:flutter/material.dart';

ListTile generateList(int index, Map<String, dynamic> crypto) {
  bool priceUp = false;
  String pre = '-';
  if(crypto['price_change_percentage_24h'] > 0.0) {
    pre = '+';
    priceUp = true;
  }
  var price_change_percentage_24h = '${pre + crypto['price_change_percentage_24h'].toStringAsFixed(3)}%';
    return ListTile(
      leading:
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [
                Text(
                  '${index+1}',
                  style: const TextStyle(color: Colors.white70)
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  color: Colors.white,
                  child: Image.network(crypto['image']),
                ),
              ],
            ),
          ),
      title: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                crypto['id'],
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Text(
                '$price_change_percentage_24h',
                style: TextStyle(color: priceUp ? Colors.green : Colors.red),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Text(
                '\$${crypto['current_price']}',
                style: TextStyle(color: priceUp ? Colors.green : Colors.red),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
}
