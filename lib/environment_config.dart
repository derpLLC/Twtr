import 'package:hooks_riverpod/hooks_riverpod.dart';

class EnvironmentConfig {
  final apiKey =  const String.fromEnvironment("apiKey");
  final apiKeySecret = const String.fromEnvironment("apiKeySecret");
  final accessToken = const String.fromEnvironment("accessToken");
  final accessTokenSecret = const String.fromEnvironment("accessTokenSecret");
}