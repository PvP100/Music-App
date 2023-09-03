import 'package:music_app/config/config.dart';
import 'package:music_app/core/core.dart';

class NetWorkConfig {
  final String baseUrl;
  String? apiKey;
  int connectTimeout;
  int receiveTimeout;
  NetWorkConfig({
    this.baseUrl = EnvConfig.baseUrl,
    this.apiKey,
    this.connectTimeout = AppConstants.connectionTimeOut,
    this.receiveTimeout = AppConstants.connectionTimeOut,
  });
}
