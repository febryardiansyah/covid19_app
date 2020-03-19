import 'package:http/http.dart';

class ApiService{
  final String baseUrl = 'https://covid19.mathdro.id';
  final String countryUrl = 'https://corona.lmao.ninja';

  Client client = Client();
}