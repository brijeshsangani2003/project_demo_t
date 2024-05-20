import 'package:flutter/cupertino.dart';

import '../model/anime_model.dart';
import '../services/services_1.dart';

class UserProvider extends ChangeNotifier {
  AnimeModel? animeList;
  AnimeModel? get animeData => animeList;

  bool loading = false;

  Future<void> getAnimeData() async {
    loading = true;

    final animeResponse = await ApiServices().anime();
    animeResponse.fold(
      (failure) {
        print('Error: $failure');
      },
      (animeModel) {
        animeList = animeModel;
        print('animeList====${animeList}');
      },
    );

    loading = false;
    notifyListeners();
  }
}
