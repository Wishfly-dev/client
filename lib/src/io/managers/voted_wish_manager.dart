import 'package:shared_preferences/shared_preferences.dart';

abstract class VotedWishManager {
  final _prefKey = 'wishfly_voted_wishes';

  Future<List<String>> getVotedWishes();
  Future<void> addVotedWish(int wishId);
}

class PrefVotedWishManager extends VotedWishManager {
  @override
  Future<List<String>> getVotedWishes() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(_prefKey) ?? [];
  }

  @override
  Future<void> addVotedWish(int wishId) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final votedWishes = await getVotedWishes();
    votedWishes.add(wishId.toString());
    sharedPreferences.setStringList(_prefKey, votedWishes);
  }
}
