import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:core';

const api = 'api.coingecko.com';
const apiPath = 'api/v3/coins/';

Future<List<dynamic>> list(bool includePlatform) async {
  var url = Uri.https(api, '${apiPath}list', {'include_platform': includePlatform ? 'true' : 'false'});
  var resp = await http.get(url);
  return resp
      .body
      .substring(1, resp.body.length-1)
      .replaceAll('},{', '}|{')
      .split('|')
      .map((e) => json.decode(e))
      .toList();
}

Future<List<dynamic>> markets(String vsCurrency, int n) async {
  var url = Uri.https(api, '${apiPath}markets', {'vs_currency': vsCurrency, 'order': 'market_cap_desc', 'per_page': '$n', 'page': '1', 'sparkline': 'false'});
  var resp = await http.get(url);
  return resp
      .body
      .substring(1, resp.body.length-1)
      .replaceAll('},{', '}|{')
      .split('|')
      .map((e) => json.decode(e))
      .toList();
}

// Future<void> main() async {
//   print(await markets('usd', 1000));
// }