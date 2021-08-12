import 'package:dart_twitter_api/twitter_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twtr/environment_config.dart';

final twtrApiProvider = Provider<TwitterApi>((ref) {
  final config = ref.watch(environmentConfigProvider);
  final twtrApi = TwitterApi(
    client: TwitterClient(
      consumerKey: config.apiKey,
      consumerSecret: config.apiKeySecret,
      token: config.accessToken,
      secret: config.accessTokenSecret,
    ),
  );

  return twtrApi;
});
