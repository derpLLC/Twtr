import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twtr/twtr_repository.dart';
import 'package:dartz/dartz.dart';

final twitterControllerProvider = StateNotifierProvider<TwitterController, dynamic>((ref) {
  final twitterRepository = ref.watch(twitterRepositoryProvider);

  return TwitterController(twitterRepository);
});

class TwitterController extends StateNotifier<AsyncValue<String>> {
  TwitterController(
    this._twitterRepository, [
    AsyncValue<String>? state,
  ]) : super(state ?? AsyncValue.data(''));
  final TwitterRepository _twitterRepository;

  Future<Either<Failure, String>> postTweet(String status) async {
    state = AsyncValue.loading();

    final result = await _twitterRepository.post(status);

    result.fold(
      (failure) => state = AsyncValue.error(failure),
      (message) => state = AsyncValue.data(message),
    );

    return result;
  }
}
