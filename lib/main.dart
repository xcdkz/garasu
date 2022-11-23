import 'package:flutter/material.dart';
import 'cryptolist/list.dart' as list;
import 'coingecko/coins.dart' as cng_coins;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Garasu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black12
      ),
      home: const MyHomePage(title: 'Garasu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Future<List<dynamic>> _loadCrypto = cng_coins.markets('usd', 250);
  var searchIcon = Icons.search;
  Widget barTitle = const Text('Garasu');
  String query = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: barTitle,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if(searchIcon == Icons.search) {
                  searchIcon = Icons.clear;
                  barTitle = ListTile(
                    leading: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    title: TextField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Search for Cryptocurrency...',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          query = value;
                        });
                      },
                    ),
                  );
                } else {
                  searchIcon = Icons.search;
                  barTitle = const Text('Garasu');
                }
              });
            },
            icon: Icon(searchIcon),
          )
        ],
      ),
      body: Container(
        color: Colors.black,
        child: FutureBuilder<List<dynamic>>(
          future: _loadCrypto,
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              ListView cryptoList;
              if(snapshot.hasData) {
                var items = snapshot.data!
                    .where((item) => (item['id'].contains(query) || item['symbol'].contains(query)))
                    .toList();
                cryptoList = ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.white, indent: 0, endIndent: 0,),
                  itemBuilder: (BuildContext context, int index) => list.generateList(items[index]),
                );
              } else if(snapshot.hasError) {
                cryptoList = ListView.separated(
                    itemCount: 1,
                    separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.white, indent: 0, endIndent: 0,),
                    itemBuilder: (BuildContext context, int index) => Text(
                        "Error fetching prices: ${snapshot.error!}" ,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                    ),
                );
              } else {
                cryptoList = ListView.separated(
                  itemCount: 1,
                  separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.white, indent: 0, endIndent: 0,),
                  itemBuilder: (BuildContext context, int index) => const Text(
                      "fetching...",
                      style: TextStyle(
                        color: Colors.white
                      )
                  ),
                );
              }
            return cryptoList;
          },
        )
      ),
    );
  }
}
