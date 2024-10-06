import 'package:go_router/go_router.dart';

import 'package:oraxproperty/presentation/ad_details/view/ad_details_view.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/add_new_order/view/add_new_order_view.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/categories_pages/view/apartment_for_rent_view.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/categories_pages/view/apartment_for_sale_view.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/categories_pages/view/lands_for_rent_view.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/categories_pages/view/lands_for_sale_view.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/categories_pages/view/villas_for_rent_view.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/categories_pages/view/villas_for_sale_view.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/choose_ad_category/view/choose_ad_category_view.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/choose_location/view/choose_location_view.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/choosing_media/view/choosing_media_view.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/confirm_before_seding/view/confirm_before_send_view.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/discription_page/view/discription_page_view.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/property_request_details/view/property_request_details_view.dart';
import 'package:oraxproperty/presentation/ads_based_categories/view/ads_based_category_view.dart';
import 'package:oraxproperty/presentation/all_categories/view/all_categories_view.dart';
import 'package:oraxproperty/presentation/change_password/view/change_password.dart';
import 'package:oraxproperty/presentation/chat/conversation_page/view/conversation_view.dart';

import 'package:oraxproperty/presentation/login/view/login_view.dart';
import 'package:oraxproperty/presentation/mainpage/view/mainpage_view.dart';
import 'package:oraxproperty/presentation/my_ads/edit_my_ads/categories_pages/view/edit_apartment_for_sale_view.dart';
import 'package:oraxproperty/presentation/my_ads/edit_my_ads/choose_location/view/edit_choose_location_view.dart';
import 'package:oraxproperty/presentation/my_ads/edit_my_ads/choosing_media/view/edit_choosing_media_view.dart';
import 'package:oraxproperty/presentation/my_ads/edit_my_ads/confirm_before_seding/view/edit_confirm_before_send_view.dart';
import 'package:oraxproperty/presentation/my_ads/edit_my_ads/discription_page/view/edit_discription_page_view.dart';
import 'package:oraxproperty/presentation/my_ads/edit_my_ads/view/edit_my_ads_view.dart';
import 'package:oraxproperty/presentation/my_ads/view/my_ads_view.dart';
import 'package:oraxproperty/presentation/my_requests/view/my_requests_view.dart';
import 'package:oraxproperty/presentation/onboarding/view/onboarding_view.dart';
import 'package:oraxproperty/presentation/register/view/register_second_view.dart';
import 'package:oraxproperty/presentation/register/view/register_view.dart';
import 'package:oraxproperty/presentation/search/view/search_view.dart';
import 'package:oraxproperty/presentation/splash_screen/view/splash_view.dart';
import 'package:oraxproperty/presentation/update_profile/view/update_profile.dart';
import 'package:oraxproperty/presentation/verify_account/view/verify_account.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: '/onboarding/view',
      // path: '/',
      builder: (context, state) => const OnBoardingView(),
    ),
    GoRoute(
      path: '/login/view',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(
      path: '/register/details',
      builder: (context, state) => const RegisterSecondView(),
    ),
    GoRoute(
      path: '/homepage',
      builder: (context, state) => const MainPageView(),
    ),
    GoRoute(
      path: '/add_new_order/view',
      builder: (context, state) => const AddNewOrderView(),
    ),
    GoRoute(
      path: '/ad_details/view',
      builder: (context, state) => AdDetailsView(
        adDetails: state.extra,
      ),
    ),
    GoRoute(
      path: '/all_categories/view',
      builder: (context, state) => const AllCategoriesView(),
    ),
    GoRoute(
      path: '/my_requests/view',
      builder: (context, state) => const MyRequestsView(),
    ),
    GoRoute(
      path: '/verify_account/view',
      builder: (context, state) => const VerifyAccountView(),
    ),
    GoRoute(
      path: '/choose_ad_category/view',
      builder: (context, state) => const ChooseAdCategoryView(),
    ),
    GoRoute(
      path: '/categories_pages/apartments_for_sale',
      builder: (context, state) => const AppartmentForSaleView(),
    ),
    GoRoute(
      path: '/categories_pages/apartments_for_rent',
      builder: (context, state) => const AppartmentForRentView(),
    ),
    GoRoute(
      path: '/categories_pages/villas_for_sale',
      builder: (context, state) => const VillasForSaleView(),
    ),
    GoRoute(
      path: '/categories_pages/villas_for_rent',
      builder: (context, state) => const VillasForRentView(),
    ),
    GoRoute(
      path: '/categories_pages/lands_for_sale',
      builder: (context, state) => const LandsForSaleView(),
    ),
    GoRoute(
      path: '/categories_pages/lands_for_rent',
      builder: (context, state) => const LandsForRentView(),
    ),
    GoRoute(
      path: '/my_ads/edit_my_ads/edit_apartment_for_sale',
      builder: (context, state) => const EditAppartmentForSaleView(),
    ),
    GoRoute(
      path: '/add_ad_or_req/choosing_media/view',
      builder: (context, state) => const ChoosingMediaView(),
    ),
    GoRoute(
      path: '/edit_my_ads/choosing_media/view',
      builder: (context, state) =>
          EditChoosingMediaView(data: state.extra as List),
    ),
    GoRoute(
      path: '/add_ad_or_req/discription/view',
      builder: (context, state) => const DiscriptionPageView(),
    ),
    GoRoute(
      path: '/edit_my_ads/discription/view',
      builder: (context, state) =>
          EditDiscriptionPageView(data: state.extra as List),
    ),
    GoRoute(
      path: '/edit_my_ads/confirm_before_sending/view',
      builder: (context, state) => const EditConfirmBeforeSendView(),
    ),
    GoRoute(
      path: '/add_ad_or_req/confirm_before_sending/view',
      builder: (context, state) => const ConfirmBeforeSendView(),
    ),
    GoRoute(
      path: '/add_ad_or_req/choose_location/view',
      builder: (context, state) => const ChooseLocationView(),
    ),
    GoRoute(
      path: '/edit_my_ads/choose_location/view',
      builder: (context, state) =>
          EditChooseLocationView(data: state.extra as List),
    ),
    GoRoute(
      path: '/update_profile/view',
      builder: (context, state) => const UpdateProfileView(),
    ),
    GoRoute(
      path: '/change_password/view',
      builder: (context, state) => const ChangePasswordView(),
    ),
    GoRoute(
      path: '/my_ads/view',
      builder: (context, state) => const MyAdsView(),
    ),
    GoRoute(
      path: '/edit_my_ads/view',
      builder: (context, state) => EditMyAdsView(
        data: state.extra as Map<String, dynamic>,
      ),
    ),
    GoRoute(
      path: '/search/view',
      builder: (context, state) => SearchView(
        query: state.extra as String,
      ),
    ),
    GoRoute(
      path: '/ads_based_category/view',
      builder: (context, state) {
        return AdsBasedCategoryView(
          categoryName: state.extra as String,
        );
      },
    ),
    GoRoute(
      path: '/chats/conversations/view',
      builder: (context, state) => ConversationView(
        userToChatWithData: state.extra as Map<String, dynamic>,
      ),
    ),
    GoRoute(
      path: '/add_ad_or_req/property_request_details/view',
      builder: (context, state) => const PropertyRequestDetailsView(),
    ),
  ],
);
