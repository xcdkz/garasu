import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
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
          primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.black),
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
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  // void _onRefresh() {
  //   _loadCrypto = cng_coins.markets('usd', 250);
  // }
  final Future<List<dynamic>> _loadCrypto = cng_coins.markets('usd', 250);
  var topBarIcon = Icons.search;
  int activePageIndex = 0;
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
            icon: Icon(topBarIcon),
            onPressed: () {
              setState(() {
                if (topBarIcon == Icons.search) {
                  topBarIcon = Icons.clear;
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
                        query = value;
                        setState(() {});
                      },
                    ),
                  );
                } else if (topBarIcon == Icons.clear) {
                  topBarIcon = Icons.search;
                  barTitle = const Text('Garasu');
                  query = '';
                }
              });
            },
          )
        ],
      ),
      body: Container(
        color: Colors.black,
        child: FutureBuilder<List<dynamic>>(
          future: _loadCrypto,
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              var items = snapshot.data!
                  .where((item) => (item['id'].contains(query) ||
                      item['symbol'].contains(query)))
                  .toList();
              return PageView(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index) {
                    setState(() {
                      activePageIndex = index;
                      barTitle = const Text('Garasu');
                      if (index == 0) {
                        topBarIcon = Icons.search;
                      } else if (index == 1) {
                        topBarIcon = Icons.add;
                      }
                    });
                  },
                  children: [

                    ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        color: Colors.white,
                        indent: 0,
                        endIndent: 0,
                      ),
                      itemBuilder: (BuildContext context, int index) =>
                          list.generateList(items[index]),
                    ),
                    const Center(
                      child: Text(
                        'There will be user\'s wallet',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Center(
                      child: Text(
                        'More coming soon...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]);
            } else if (snapshot.hasError) {
              return ListView.separated(
                itemCount: 1,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  color: Colors.white,
                  indent: 0,
                  endIndent: 0,
                ),
                itemBuilder: (BuildContext context, int index) => Text(
                  "Error fetching prices: ${snapshot.error!}",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            } else {
              return ListView.separated(
                itemCount: 1,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  color: Colors.white,
                  indent: 0,
                  endIndent: 0,
                ),
                itemBuilder: (BuildContext context, int index) => const Text(
                    "fetching...",
                    style: TextStyle(color: Colors.white)),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: activePageIndex,
        onTap: (index) {
          setState(() {
            _pageController.animateToPage(index, duration: const Duration(milliseconds: 600), curve: Curves.decelerate);
          });
        },
        // unselectedItemColor: Colors.black,
        // selectedItemColor: Colors.green,
        selectedColorOpacity: 0.2,
        margin: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
        items: [
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.area_chart_outlined,
              ),
              title: const Text('Main'),
              selectedColor: Colors.green,
              unselectedColor: Colors.grey,
            ),
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.monetization_on_outlined,
              ),
              title: const Text('Portfolio'),
              selectedColor: Colors.green,
              unselectedColor: Colors.grey,
            ),
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.more_horiz,
              ),
              title: const Text('More'),
              selectedColor: Colors.green,
              unselectedColor: Colors.grey,
            ),
        ],
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
