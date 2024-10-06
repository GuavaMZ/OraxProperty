import 'package:oraxproperty/domain/model/favourites.dart';
import 'package:oraxproperty/main.dart';

class FavouritesRequests {
  Future makeAdFav(int adId, String uID) async {
    Map<String, dynamic> favouritesModel =
        FavouritesModel(uid: uID, ad_id: adId).toJson();
    String? requestResult;
    try {
      await supabase
          .from('users_favourites')
          .insert(favouritesModel)
          .select()
          .then((value) {
        if (value[0]['id'] != null) {
          print(value);
          requestResult = 'Success';
        }
      });
    } catch (e) {
      requestResult = 'Failed';
    }
    return requestResult;
  }

  Future checkFav(int adId, String uID) async {
    try {
      final requestResults = await supabase
          .rpc('check_if_fav', params: {'userid': uID, 'adid': adId}).select();
      return requestResults;
    } catch (e) {
      return e;
    }
  }

  Future removeFav(int adId, String uID) async {

    String? requestResult;
    try {
      await supabase
          .from('users_favourites')
          .delete()
          .match({'ad_id': adId, 'uid': uID})
          .select()
          .then((value) {
            print(value);
            requestResult = 'Success';
          });
    } catch (e) {
      requestResult = 'Failed';
    }
    return requestResult;
  }

    Future getFavAds(String uID) async {
    try {
      final requestResults = await supabase
          .rpc('get_user_favs', params: {'userid': uID}).select();
      return requestResults;
    } catch (e) {
      return e;
    }
  }
}
