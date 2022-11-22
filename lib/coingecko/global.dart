import 'package:http/http.dart' as http;
import 'dart:convert';

const api = 'api.coingecko.com';
const apiPath = 'api/v3/global';

Future<Map<String, dynamic>> global() async {
  var url = Uri.https(api, apiPath);
  var resp = await http.get(url);
  return jsonDecode(resp.body);
}

// Future<void> main() async{
//   print(await global());
// }
