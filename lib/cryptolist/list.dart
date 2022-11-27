import 'package:flutter/material.dart';
import 'package:garasu/values.dart' as val;
import 'dart:developer' as developer;

class CryptoList extends StatefulWidget {
  final val.Values values;
  const CryptoList({
    super.key,
    required this.values,
  });

  @override
  State<CryptoList> createState() => _CryptoListState();
}

class _CryptoListState extends State<CryptoList> {
  Future<void> _refreshList() async {
    widget.values.cryptoListFeed = val.refreshCrypto('usd', 250);
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshList,
      child: FutureBuilder<List<dynamic>> (
        future: widget.values.cryptoListFeed,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var queriedItems = snapshot.data!
                .where((item) => (item['id'].contains(widget.values.query) ||
                item['symbol'].contains(widget.values.query) ||
                item['name'].toLowerCase().contains(widget.values.query)))
                .toList();
            return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return CryptoListRow(
                    priceChangePercentage24h: queriedItems[index]['price_change_percentage_24h'],
                    marketPlace: queriedItems[index]['market_place'],
                    logo: queriedItems[index]['image'],
                    name: queriedItems[index]['name'],
                    currentPrice: queriedItems[index]['current_price'],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.white,
                    indent: 0,
                    endIndent: 0,
                  );
                },
                itemCount: queriedItems.length
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text(
                'Error',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                )
              )
            );
          }
        },
      ),
    );
  }
}

class CryptoListRow extends StatefulWidget {
  final double priceChangePercentage24h;
  final int marketPlace;
  final String logo;
  final String name;
  final double currentPrice;

  const CryptoListRow({
    super.key,
    required this.priceChangePercentage24h,
    required this.marketPlace,
    required this.logo,
    required this.name,
    required this.currentPrice,
  });

  @override
  State<CryptoListRow> createState() => _CryptoListRowState();
}

class _CryptoListRowState extends State<CryptoListRow> {
  @override
  Widget build(BuildContext context) {
    bool priceUp = false;
    String pre = '▼ ';
    var priceChangePercentage24h = widget.priceChangePercentage24h;
    if (priceChangePercentage24h >= 0.0) {
      pre = '▲ ';
      priceUp = true;
    } else {
      priceChangePercentage24h = priceChangePercentage24h * -1;
    }
    String sPriceChangePercentage24h =
        '$pre${priceChangePercentage24h.toStringAsFixed(2)}%';
    return ListTile(
      leading: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 30,
              child: Text(
                '${widget.marketPlace}',
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
              child: Image.network(widget.logo),
            ),
          ],
        ),
      ),
      title: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                widget.name,
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
                sPriceChangePercentage24h,
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
                '\$${widget.currentPrice}',
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
}
