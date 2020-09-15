import 'package:http/http.dart' as http;

class PhotoAPI {
  static final String _url = "https://api.unsplash.com";
  static final List<String> _tokens = [
    'cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0',
    'ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9',
    '896d4f52c589547b2134bd75ed48742db637fa51810b49b607e37e46ab2c0043'
  ];
  static Future<String> getPhotos({int page = 1}) {
    return http.get("$_url/photos/?page=$page&client_id=${_tokens[0]}")
        .then((response) => response.body);
  }
}