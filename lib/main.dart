import 'package:flutter/material.dart';
import 'list.dart' as list;
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
  final Future<List<dynamic>> _loadCrypto = cng_coins.markets('usd', 1000);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: FutureBuilder<List<dynamic>>(
          future: _loadCrypto,
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              ListView cryptoList;
              if(snapshot.hasData) {
                cryptoList = ListView.separated(
                  itemCount: 1000,
                  separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.white, indent: 40, endIndent: 40,),
                  itemBuilder: (BuildContext context, int index) => list.generateList(index, snapshot.data![index]),
                );
              } else if(snapshot.hasError) {
                cryptoList = ListView.separated(
                    itemCount: 10,
                    separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.white, indent: 40, endIndent: 40,),
                    itemBuilder: (BuildContext context, int index) => const Text("Error fetching prices"),
                );
              } else {
                cryptoList = ListView.separated(
                  itemCount: 10,
                  separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.white, indent: 40, endIndent: 40,),
                  itemBuilder: (BuildContext context, int index) => const Text("fetching..."),
                );
              }
            return cryptoList;
          },
        )
      ),
    );
  }
}
