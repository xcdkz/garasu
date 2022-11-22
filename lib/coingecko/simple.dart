import 'package:http/http.dart' as http;
import 'dart:convert';

const api = 'api.coingecko.com';
const apiPath = 'api/v3/simple';

Future<Map<String, dynamic>> price(String id, String vsCurrency) async {
  var url = Uri.https(api, '$apiPath/price', {'ids': id, 'vs_currencies': vsCurrency, 'include_24hr_change': 'true'});
  var resp = await http.get(url);
  return jsonDecode(resp.body);
}

// Future<void> main() async {
//   print(await price('bitcoin,ethereum', 'usd'));
// }