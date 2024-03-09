import 'package:flutter/material.dart';
import 'package:lab_test_app/presentation/app/screen/home/home_screen_specialist.dart';
import 'package:lab_test_app/presentation/app/screen/lists/boooking/my_bookings.dart';
import 'package:lab_test_app/presentation/app/screen/lists/contact_us_screen.dart';
import 'package:lab_test_app/presentation/app/screen/lists/privacy_policy_n_terms.dart';
import 'package:lab_test_app/presentation/app/screen/lists/wallet/wallet_screen.dart';
import '../screen/home/home_screen.dart';
import '../screen/intro/intro_screen.dart';
import '../screen/lists/chat/chat_screen.dart';
import '../screen/lists/home_visit/home_visit_screen.dart';
import '../screen/lists/home_visit/my_home_visit_screen.dart';
import '../screen/lists/labDetail/about_lab_screen.dart';
import '../screen/lists/labDetail/lab_detail_screen.dart';
import '../screen/lists/labDetail/lab_location_screen.dart';
import '../screen/lists/review/reviews_screen.dart';
import '../screen/lists/mycard/add_new_card_screen.dart';
import '../screen/lists/mycard/edit_card_screen.dart';
import '../screen/lists/mycard/my_card_screen.dart';
import '../screen/lists/nearby_lab_screen.dart';
import '../screen/lists/profile/edit_profile_screen.dart';
import '../screen/lists/profile/my_profile_screen.dart';
import '../screen/lists/search/search_screen.dart';
import '../screen/lists/settings/notification_screen.dart';
import '../screen/lists/settings/reminder_screen.dart';
import '../screen/lists/settings/settings_screen.dart';
import '../screen/lists/specialist/specialist_detail_screen.dart';
import '../screen/lists/test_report/test_report_Screen.dart';
import '../screen/lists/tests/payment_gateway_screen.dart';
import '../screen/lists/tests/payment_method_screen.dart';
import '../screen/lists/tests/payment_screen.dart';
import '../screen/lists/add_booking/add_booking_screen.dart';
import '../screen/lists/tests/test_detail_screen.dart';
import '../screen/lists/tests/tests_lists_screen.dart';
import '../screen/lists/tests_panel_screen.dart';
import '../screen/lists/top_specialist_screen.dart';
import '../screen/login/forgot_screen.dart';
import '../screen/login/login_screen.dart';
import '../screen/login/reset_password_screen.dart';
import '../screen/my_networks/my_networks.dart';
import '../screen/sign_up/select_country_screen.dart';
import '../screen/sign_up/sign_up_screen.dart';
import '../screen/sign_up/verification_screen.dart';
import '../screen/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const initialRoute = Routes.homeRoute;
  static Map<String, WidgetBuilder> routes = {
    Routes.homeRoute: (context) => const SplashScreen(),
    Routes.introRoute: (context) => const IntroScreen(),
    Routes.loginRoute: (context) => const LoginScreen(),
    Routes.forgotRoute: (context) => const ForgotScreen(),
    Routes.resetPasswordRoute: (context) => const ResetPasswordScreen(),
    Routes.signUpRoute: (context) => const SignUpScreen(),
    Routes.selectCountryRoute: (context) => const SelectCountryScreen(),
    Routes.verificationRoute: (context) => const VerificationScreen(),
    Routes.homeScreenRoute: (context) => const HomeScreen(),
    Routes.homeSpecialistScreenRoute: (context) => const HomeScreenSpecialist(),
    Routes.searchScreenRoute: (context) => const SearchScreen(),
    Routes.nearbyLabScreenRoute: (context) => const NearbyLabScreen(),
    Routes.topSpecialistScreenRoute: (context) => const TopSpecialistScreen(),
    Routes.specialistDetailScreenRoute: (context) =>
        const SpecialistDetailScreen(),
    Routes.testsListsScreenRoute: (context) => const TestsListsScreen(),
    Routes.labDetailScreenRoute: (context) => const LabDetailScreen(),
    Routes.aboutLabScreenRoute: (context) => const AboutLabScreen(),
    Routes.labLocationScreenRoute: (context) => const LabLocationScreen(),
    Routes.labReviewsScreenRoute: (context) => const ReviewsScreen(),
    Routes.testReportScreenRoute: (context) => const TestReportScreen(),
    Routes.homeVisitScreenRoute: (context) => const HomeVisitScreen(),
    Routes.chatScreenRoute: (context) => const ChatScreen(),
    Routes.myProfileScreenRoute: (context) => const MyProfileScreen(),
    Routes.myWalletScreenRoute: (context) => const MyWalletScreen(),
    Routes.editProfileScreenRoute: (context) => const EditProfileScreen(),
    Routes.testDetailScreenRoute: (context) => const TestDetailScreen(),
    Routes.addBookingScreenRoute: (context) => const AddBookingScreen(),
    Routes.paymentMethodScreenRoute: (context) => const PaymentMethodScreen(),
    Routes.paymentScreenRoute: (context) => const PaymentScreen(),
    Routes.paymentGatewayScreenRoute: (context) => const PaymentGatewayScreen(),
    Routes.myCardScreenRoute: (context) => const MyCardScreen(),
    Routes.addNewCardScreenRoute: (context) => const AddNewCardScreen(),
    Routes.myBookingScreenRoute: (context) => const MyBookingScreen(),
    Routes.editCardScreenRoute: (context) => const EditCardScreen(),
    Routes.myHomeVisitScreenRoute: (context) => const MyHomeVisitScreen(),
    Routes.settingsScreenRoute: (context) => const SettingsScreen(),
    Routes.notificationScreenRoute: (context) => const NotificationScreen(),
    Routes.privacyPolicyNTerms: (context) => const PrivacyPolicyNTermsScreen(),
    Routes.contactUs: (context) => const ContactUsScreen(),
    Routes.reminderScreenRoute: (context) => const ReminderScreen(),
    Routes.testsPanelScreenRoute: (context) => const TestsPanelScreen(),
    Routes.myNetworksScreenRoute: (context) => const MyNetworkScreen(),
  };
}
