import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  static const api = 'https://api.github.com';
  static var token = dotenv.get('GITHUB_TOKEN');
}
