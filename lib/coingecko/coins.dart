import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:core';

const api = 'api.coingecko.com';
const apiPath = 'api/v3/coins/';

Future<List<dynamic>> list(bool includePlatform) async {
  var url = Uri.https(api, '${apiPath}list',
      {'include_platform': includePlatform ? 'true' : 'false'});
  var resp = await http.get(url);
  return resp.body
      .substring(1, resp.body.length - 1)
      .replaceAll('},{', '}|{')
      .split('|')
      .map((e) => json.decode(e))
      .toList();
}

// https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=1h%2C24h%2C7d%2C14d%2C30d%2C200d%2C1y
Future<List<dynamic>> markets(String vsCurrency, int n) async {
  var url = Uri.https(api, '${apiPath}markets', {
    'vs_currency': vsCurrency,
    'order': 'market_cap_desc',
    'per_page': '$n',
    'sparkline': 'true',
    'page': '1',
    'price_change_percentage': '1h,24h,7d,14d,30d,200d,1y'
  });
  var resp = await http.get(url);
  var res = resp.body
      .substring(1, resp.body.length - 1)
      .replaceAll('},{', '}|{')
      .split('|')
      .map((e) => json.decode(e))
      .toList();
  for (var i = 0; i < res.length; i++) {
    res[i]['market_place'] = i + 1;
  }
  return res;
}

Future<void> main() async {
  print(await markets('usd', 1000));
}
