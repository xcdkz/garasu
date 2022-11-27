# garasu

FOSS Cryptocurrency Tracker
# TODO
- [ ] Smooth Refresh with blur overlay on existing cache data

child: FutureBuilder<List<dynamic>>(
future: val.loadCrypto,
builder:
  (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
if (snapshot.connectionState == ConnectionState.done) {
  var items = snapshot.data!
      .where((item) => (item['id'].contains(val.query) ||
          item['symbol'].contains(val.query) ||
          item['name'].toLowerCase().contains(val.query)))
      .toList();
  return PageView(
      controller: val.pageController,
      scrollDirection: Axis.horizontal,
      onPageChanged: (index) {
        setState(() {
          val.activePageIndex = index;
          val.barTitle = const Text('Garasu');
          if (val.activePageIndex == 0) {
            val.topBarIcon = Icons.search;
          } else if (val.activePageIndex == 1) {
            val.topBarIcon = Icons.add;
          } else if (val.activePageIndex == 2) {
            val.topBarIcon = Icons.more_vert;
          }
        });
      },
      children: [
        list.CryptoList(
          items: items,
          values: val,
        ),
        const portfolio.Portfolio(),
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
}
if (snapshot.hasError) {
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
}
return const Text('No Data');
},
