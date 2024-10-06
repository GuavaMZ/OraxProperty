import 'package:oraxproperty/main.dart';

class AdDetailsRequests {
  Future getApartmentForSaleAdDetails(int adId) async {
    try {
      final res = await supabase
          .from('ads_apartment_for_sale')
          .select('*,property_categories!inner(category_name)')
          .eq('ad_id', adId);
      return res;
    } catch (e) {
      return e;
    }
  }

  Future getApartmentForRentAdDetails(int adId) async {
    try {
      final res = await supabase
          .from('ads_apartment_for_rent')
          .select('*,property_categories!inner(category_name)')
          .eq('ad_id', adId);
      return res;
    } catch (e) {
      return e;
    }
  }

  Future getVillaForSaleAdDetails(int adId) async {
    try {
      final res = await supabase
          .from('ads_villa_for_sale')
          .select('*,property_categories!inner(category_name)')
          .eq('ad_id', adId);
      return res;
    } catch (e) {
      return e;
    }
  }

  Future getVillaForRentAdDetails(int adId) async {
    try {
      final res = await supabase
          .from('ads_villa_for_rent')
          .select('*,property_categories!inner(category_name)')
          .eq('ad_id', adId);
      return res;
    } catch (e) {
      return e;
    }
  }

  Future getLandForSaleAdDetails(int adId) async {
    try {
      final res = await supabase
          .from('ads_lands_for_sale')
          .select('*,property_categories!inner(category_name)')
          .eq('ad_id', adId);
      return res;
    } catch (e) {
      return e;
    }
  }

  Future getLandForRentAdDetails(int adId) async {
    try {
      final res = await supabase
          .from('ads_lands_for_rent')
          .select('*,property_categories!inner(category_name)')
          .eq('ad_id', adId);
      return res;
    } catch (e) {
      return e;
    }
  }
}
