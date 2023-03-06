import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'cryptolist/list.dart' as list;
import 'values.dart' as values;
import 'portfolio/portfolio.dart' as portfolio;
import 'bottombar/bar.dart' as bar;
import 'package:flutter_donation_buttons/flutter_donation_buttons.dart';

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
  var val = values.Values('usd', 250);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: val.barTitle,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(val.topBarIcon),
            onPressed: () {
              setState(() {
                if (val.topBarIcon == Icons.search) {
                  val.topBarIcon = Icons.clear;
                  val.barTitle = ListTile(
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
                        val.query = value.toLowerCase();
                        setState(() {});
                      },
                    ),
                  );
                } else if (val.topBarIcon == Icons.clear) {
                  val.topBarIcon = Icons.search;
                  val.barTitle = const Text('Garasu');
                  val.query = '';
                }
              });
            },
          )
        ],
      ),
      body: Container(
          color: Colors.black,
          child: PageView(
            controller: val.pageController,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index) {
              setState(() {
                val.activePageIndex = index;
                val.barTitle = const Text('Garasu');
                switch (val.activePageIndex) {
                  case 0:
                    {
                      val.topBarIcon = Icons.search;
                    }
                    break;
                  case 1:
                    {
                      val.topBarIcon = Icons.add;
                    }
                    break;
                  case 2:
                    {
                      val.topBarIcon = Icons.more_vert;
                    }
                    break;
                }
              });
            },
            children: [
              list.CryptoList(
                values: val,
              ),
              const portfolio.Portfolio(),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    PatreonButton(
                      patreonName: '1plus1equals13',
                    ),
                  ],
                ),
              )
            ],
          )),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: val.activePageIndex,
        onTap: (index) {
          setState(() {
            val.pageController.animateToPage(index,
                duration: const Duration(milliseconds: 600),
                curve: Curves.decelerate);
          });
        },
        selectedColorOpacity: 0.2,
        margin: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
        items: bar.bottomBarItems(),
      ),
    );
  }
}
