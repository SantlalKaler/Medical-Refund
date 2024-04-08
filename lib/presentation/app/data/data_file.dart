import 'package:flutter/material.dart';

import '../models/intro_model.dart';
import '../models/model_bottom_nav.dart';
import '../models/model_chat.dart';
import '../models/model_country.dart';
import '../models/model_home_visit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/model_latest_report.dart';
import '../models/model_nearby_lab.dart';
import '../models/model_notification.dart';
import '../models/model_payment_method.dart';
import '../models/model_payment_type.dart';
import '../models/model_profile.dart';
import '../models/model_recent_search.dart';
import '../models/model_reminder.dart';
import '../models/model_reviews.dart';
import '../models/model_test_panel.dart';
import '../models/model_top_specialist.dart';

class DataFile {

  static List<ModelIntro> introList (BuildContext context) => [
    ModelIntro("intro1.png", AppLocalizations.of(context)!.intro1Title,
        AppLocalizations.of(context)!.intro1Description),
    ModelIntro("intro2.png", AppLocalizations.of(context)!.intro2Title,
        AppLocalizations.of(context)!.intro2Description),
    ModelIntro("intro3.png",  AppLocalizations.of(context)!.intro3Title,
        AppLocalizations.of(context)!.intro3Description),
    ModelIntro(
        "intro4.png",  AppLocalizations.of(context)!.intro4Title,
        AppLocalizations.of(context)!.intro4Description)
  ];

  static List<ModelCountry> countryList = [
    ModelCountry("image_fghanistan.png", "Afghanistan (AF)", "+93"),
    ModelCountry("image_ax.png", "Aland Islands (AX)", "+358"),
    ModelCountry("image_albania.png", "Albania (AL)", "+355"),
    ModelCountry("image_andora.png", "Austria (AT)", "+93"),
    ModelCountry("image_islands.png", "USA (U)", "+1"),
    ModelCountry("image_angulia.png", "Andorra(AD)", "+1"),
    ModelCountry("image_armenia.png", "Anguillia (AN)", "+1"),
    ModelCountry("image_austia.png", "India (IN)", "+91"),
  ];

  static List<ModelBottomNav> bottomList = [
    ModelBottomNav("home.svg", "home_active.svg"),
    ModelBottomNav("list_lab.svg", "list_lab_active.svg"),
    ModelBottomNav("", ""),
    ModelBottomNav("chat.svg", "chat_active.svg"),
    ModelBottomNav("profile.svg", "profile_active.svg"),
  ];

  static List<ModelBottomNav> bottomListForSpecialist = [
    ModelBottomNav("list_lab.svg", "list_lab_active.svg"),
    ModelBottomNav("", ""),
    ModelBottomNav("chat.svg", "chat_active.svg"),
  ];

  static List<ModelTestPanel> testPanelList = [
    ModelTestPanel('test_panel1.png', 'CheckUp Panel', '27 tests'),
    ModelTestPanel('test_panel2.png', 'Hormonal Panel', '24 tests'),
    ModelTestPanel('test_panel3.png', 'Hematology Panel', '24 tests'),
  ];

  static List<ModelNearbyLab> nearbyLabList = [
    ModelNearbyLab('lab1.png', 'Julianne Laboratory', 'Nature Park, Silvana'),
    ModelNearbyLab('lab2.png', 'Montela Laboratory', 'Shivam Road, Lakone'),
    ModelNearbyLab('lab3.png', 'Rilvama Laboratory', 'Royal Ln.Mesa,New jersy'),
    ModelNearbyLab('lab4.png', 'Lanses Laboratory', 'Celina, Delaware'),
  ];

  static List<ModelTopSpecialist> topSpecialistList = [
    ModelTopSpecialist('Dr. Vina', 'Cardiologist', 'specialist1.png'),
    ModelTopSpecialist('Dr. John', 'Scientist', 'specialist2.png'),
    ModelTopSpecialist('Dr. Bella', 'Dentist', 'specialist3.png'),
    ModelTopSpecialist('Dr. Jenny', 'Cardiologist', 'specialist4.png'),
    ModelTopSpecialist('Dr. Krina Patil', 'Cardiologist', 'specialist5.png'),
    ModelTopSpecialist('Dr. Robert Winget', 'Scientist', 'specialist6.png'),
  ];

  static List<ModelRecentSearch> recentSearchList = [
    ModelRecentSearch('Jivame Lab'),
    ModelRecentSearch('Tulianne Laboratory'),
    ModelRecentSearch('Warome Bell Laboratory'),
    ModelRecentSearch('Lenelia Renolt Lab'),
    ModelRecentSearch('Fruzila Wandor Laboratory'),
  ];

  static List<String> colorList = [
    'EEEBFF',
    'EFFCDB',
    'FFEBEB',
    'E2FBE4',
    'FBF9CB',
    'DFF5FF',
    'FFF1E4',
    'FFE4FB',
    'FFF4DF',
    'DEE7FF',
    'E7FADF',
    'FFE3F1',
  ];

  static List<ModelReviews> reviewsList = [
    ModelReviews('profile1.png', 'Jenny Winget', '12 June, 2022',
        'Research labs featuring energy-intensive equipment, use up to three to five times more energy per square meter than office areas.'),
    ModelReviews('profile2.png', 'Robert Fox', '10 June, 2022',
        'Research labs featuring energy-intensive equipment, use up to three to five times more energy per square meter than office areas.'),
    ModelReviews('profile3.png', 'Liona Benny', '08 June, 2022',
        'Research labs featuring energy-intensive equipment, use up to three to five times more energy per square meter than office areas.'),
    ModelReviews('profile4.png', 'Darton Marker', '06 June, 2022',
        'Research labs featuring energy-intensive equipment, use up to three to five times more energy per square meter than office areas.'),
  ];

  static List<ModelLatestReport> latestReportList = [
    ModelLatestReport(
        'Thyroid', 'Merry Fernandez', '20 June, 2022,', '05:26 AM'),
    ModelLatestReport(
        'Hormonal', 'Merry Fernandez', '19 June, 2022,', '05:26 AM'),
  ];

  static List<ModelChat> getChattingList() {
    List<ModelChat> chatList = [];

    chatList.add(ModelChat("Hi", "08:00 am", true, true));
    chatList
        .add(ModelChat("Hey, How can we help you?", "08:20 am", false, false));
    chatList.add(ModelChat("Duis aute irure dolor", "8:21 am", true, true));
    chatList.add(ModelChat(
        "Lorem ipsum dolor sit amet, consectetur", "08:22 PM", false, false));
    chatList.add(ModelChat(
        "Excepteur sint\noccaecat cupidatat", "08:24 PM", true, true));
    chatList.add(ModelChat(
        "Lorem ipsum dolor sit amet, consectetur", "08:27 PM", false, false));

    return chatList;
  }

  static List<ModelProfile> getAllProfileList() {
    List<ModelProfile> profileList = [];

    profileList.add(ModelProfile("Genelia Laboratory", "lab1.png", '2'));
    profileList.add(ModelProfile("Montela Laboratory", "lab2.png", '18'));
    profileList.add(ModelProfile("Dr. Bella", "specialist3.png", '0'));
    profileList.add(ModelProfile("Rilvama Laboratory", "lab3.png", '0'));
    profileList.add(ModelProfile("Sergenic Laboratory", "lab4.png", '0'));

    return profileList;
  }

  static List<ModelPaymentMethod> paymentMethodList = [
    ModelPaymentMethod('E-Wallet'),
    ModelPaymentMethod('Credit / Debit Card'),
    ModelPaymentMethod('Net Banking'),
    ModelPaymentMethod('Other UPI Apps'),
    ModelPaymentMethod('Cash on Sample Collection'),
  ];

  static List<ModelPaymentCard> paymentCardList = [
    ModelPaymentCard('paypal.svg', 'Paypal', 'XXXX XXXX XXXX 2563'),
    ModelPaymentCard('mastercard.svg', 'Master Card', 'XXXX XXXX XXXX 2563'),
    ModelPaymentCard('visa.svg', 'Visa', 'XXXX XXXX XXXX 5863'),
  ];

  static List<ModelHomeVisit> homeVisitList = [
    ModelHomeVisit(
        'Dr. Vina Longe', 'Cardiologist', '20 June, 2022,', '05:26 AM'),
    ModelHomeVisit(
        'Dr. Vina Longe', 'Cardiologist', '18 June, 2022,', '05:26 AM'),
  ];

  static List<ModelNotification> notificationList = [
    ModelNotification('lab1.png', 'Genelia Laboratory',
        'Lorem ipsum dolor sit con...', '24 min ago'),
    ModelNotification('specialist3.png', 'Dr. Bella',
        'Lorem ipsum dolor sit con...', '30 min ago'),
    ModelNotification('lab2.png', 'Montela Laboratory',
        'Lorem ipsum dolor sit con...', '2 h ago'),
  ];

  static List<NotificationCat> notificationCatList = [
    NotificationCat('Today'),
    NotificationCat('This Week'),
  ];

  static List<ModelReminder> reminderList = [
    ModelReminder('Lab Report Acchive', 'Thu 25/07/2022', '10:30 pm'),
    ModelReminder('Checkup', 'Fri 26/07/2022', '02:30 pm'),
    ModelReminder('Home Visit', 'Sat 27/07/2022', '02:30 pm'),
    ModelReminder('Hematology Checkup', 'Mon 29/07/2022', '04:00 pm'),
    ModelReminder('Montela Laboratory Visit', 'Tue 30/07/2022', '09:00 am'),
  ];
}
