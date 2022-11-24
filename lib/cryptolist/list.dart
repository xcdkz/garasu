import 'package:flutter/material.dart';

ListTile generateList(Map<String, dynamic> crypto) {
  bool priceUp = false;
  String pre = '▼ ';
  var priceChangePercentage24h = crypto['price_change_percentage_24h'];
  if(crypto['price_change_percentage_24h'] >= 0.0) {
    pre = '▲ ';
    priceUp = true;
  } else {
    priceChangePercentage24h = priceChangePercentage24h * -1;
  }
  priceChangePercentage24h = '$pre${priceChangePercentage24h.toStringAsFixed(3)}%';
    return ListTile(
      leading:
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [
                SizedBox(
                  width: 30,
                  child: Text(
                    '${crypto['market_place']}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.15),
                  ),
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
                '${crypto['id']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Text(
                priceChangePercentage24h,
                style: TextStyle(
                  color: priceUp ? Colors.green : Colors.red,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Text(
                '\$${crypto['current_price']}',
                style: TextStyle(
                  color: priceUp ? Colors.green : Colors.red,
                  fontSize: 14,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
}
