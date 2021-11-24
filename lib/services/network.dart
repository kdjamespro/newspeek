import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  late final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;

      var decodeData = jsonDecode(data);

      return decodeData;
    } else {
      print(response.statusCode);
    }
  }
}
