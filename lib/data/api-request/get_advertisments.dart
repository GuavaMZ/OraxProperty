import 'package:oraxproperty/main.dart';

class GetAdvertisementsRequest {
  Future getAdvertisementsForMap() async {
    List<String> tablesList = [
      "ads_apartment_for_sale",
      "ads_apartment_for_rent",
      "ads_villa_for_sale",
      "ads_villa_for_rent"
    ];
    List data = [];
    try {
      // final res = await supabase.from('advertisements').select(
      //     "ad_id,ads_apartment_for_sale (ad_id,*),ads_apartment_for_rent (ad_id,*),ads_villa_for_sale (ad_id,*),ads_villa_for_rent (ad_id,*)");
      for (var table in tablesList) {
        final res =
            await supabase.from('advertisements').select("$table!inner(*)");
        data.add(res);
      }
      print(data);
      return data;
    } catch (e) {
      return e;
    }
  }

  Future getAdDetails(adId, categoryId) async {
    switch (categoryId) {
      case 1:
        try {
          final res = await supabase
              .from('ads_apartment_for_sale')
              .select('*')
              .eq('ad_id', adId);
          return res;
        } catch (e) {
          return e;
        }

      case 2:
        try {
          final res = await supabase
              .from('ads_apartment_for_rent')
              .select('*')
              .eq('ad_id', adId);
          return res;
        } catch (e) {
          return e;
        }

      case 3:
        try {
          final res = await supabase
              .from('ads_villa_for_sale')
              .select('*')
              .eq('ad_id', adId);
          return res;
        } catch (e) {
          return e;
        }

      case 4:
        try {
          final res = await supabase
              .from('ads_villa_for_rent')
              .select('*')
              .eq('ad_id', adId);
          return res;
        } catch (e) {
          return e;
        }
      case 5:
        try {
          final res = await supabase
              .from('ads_lands_for_sale')
              .select('*')
              .eq('ad_id', adId);
          return res;
        } catch (e) {
          return e;
        }
      case 6:
        try {
          final res = await supabase
              .from('ads_lands_for_rent')
              .select('*')
              .eq('ad_id', adId);
          return res;
        } catch (e) {
          return e;
        }
      default:
        return null;
    }
  }

  Future getApartmentForSaleAdvertisments() async {
    try {
      final List<Map> res =
          await supabase.from('ads_apartment_for_sale').select();
      return res;
    } catch (e) {
      return e;
    }
  }

  Future getApartmentForRentAdvertisements() async {
    try {
      final List<Map> res =
          await supabase.from('ads_apartment_for_rent').select();
      return res;
    } catch (e) {
      return e;
    }
  }

  Future getVillaForSaleAdvertisements() async {
    try {
      final List<Map> res = await supabase.from('ads_villa_for_sale').select();
      return res;
    } catch (e) {
      return e;
    }
  }

  Future getVillaForRentAdvertisements() async {
    try {
      final List<Map> res = await supabase.from('ads_villa_for_rent').select();
      return res;
    } catch (e) {
      return e;
    }
  }

  Future getAdvertisementsForMapRPC() async {
    try {
      final res = await supabase.rpc('get_ads_for_map');
      // print(res['bucket_path']);
      return res;
    } catch (e) {
      return e;
    }
  }

  Future getApartmentsForSaleRPC() async {
    try {
      final res = await supabase.rpc('get_ads_apartment_for_sale');

      return res;
    } catch (e) {
      return e;
    }
  }

  Future getApartmentsForRentRPC() async {
    try {
      final res = await supabase.rpc('get_ads_apartment_for_rent');

      return res;
    } catch (e) {
      return e;
    }
  }

  Future getVillaForSaleRPC() async {
    try {
      final res = await supabase.rpc('get_ads_villa_for_sale');

      return res;
    } catch (e) {
      return e;
    }
  }

  Future getVillaForRentRPC() async {
    try {
      final res = await supabase.rpc('get_ads_villa_for_rent');

      return res;
    } catch (e) {
      return e;
    }
  }

  Future getLandsForSaleRPC() async {
    try {
      final res = await supabase.rpc('get_ads_lands_for_sale');

      return res;
    } catch (e) {
      return e;
    }
  }

  Future getLandsForRentRPC() async {
    try {
      final res = await supabase.rpc('get_ads_lands_for_rent');

      return res;
    } catch (e) {
      return e;
    }
  }

  Future getMyAdvertisementsRPC() async {
    try {
      final res = await supabase.rpc('get_ads_for_user',params: {'userid': supabase.auth.currentUser!.id});

      return res;
    } catch (e) {
      return e;
    }
  }
}
