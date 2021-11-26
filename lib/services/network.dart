import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);

  late final String url;

  Future<String> getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      return data;
    } else {
      return throw ('Cannot get data');
    }
  }
}
