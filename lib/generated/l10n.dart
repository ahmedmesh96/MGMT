// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Write your Full Name`
  String get write_your_fullname {
    return Intl.message(
      'Write your Full Name',
      name: 'write_your_fullname',
      desc: '',
      args: [],
    );
  }

  /// `Write your Phone Number`
  String get write_your_phonenumber {
    return Intl.message(
      'Write your Phone Number',
      name: 'write_your_phonenumber',
      desc: '',
      args: [],
    );
  }

  /// `Write your Email`
  String get write_your_email {
    return Intl.message(
      'Write your Email',
      name: 'write_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personal_information {
    return Intl.message(
      'Personal Information',
      name: 'personal_information',
      desc: '',
      args: [],
    );
  }

  /// `Reservation Information`
  String get reservation_information {
    return Intl.message(
      'Reservation Information',
      name: 'reservation_information',
      desc: '',
      args: [],
    );
  }

  /// `Reservation occasion`
  String get reservation_occasion {
    return Intl.message(
      'Reservation occasion',
      name: 'reservation_occasion',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get birthday {
    return Intl.message(
      'Birthday',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `Graduation event`
  String get graduation_event {
    return Intl.message(
      'Graduation event',
      name: 'graduation_event',
      desc: '',
      args: [],
    );
  }

  /// `Marriage`
  String get marriage {
    return Intl.message(
      'Marriage',
      name: 'marriage',
      desc: '',
      args: [],
    );
  }

  /// `Engagement`
  String get engagement {
    return Intl.message(
      'Engagement',
      name: 'engagement',
      desc: '',
      args: [],
    );
  }

  /// `Birth`
  String get birth {
    return Intl.message(
      'Birth',
      name: 'birth',
      desc: '',
      args: [],
    );
  }

  /// `Receive a position`
  String get Receive_position {
    return Intl.message(
      'Receive a position',
      name: 'Receive_position',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get Other {
    return Intl.message(
      'Other',
      name: 'Other',
      desc: '',
      args: [],
    );
  }

  /// `Pick Your Time!`
  String get pick_your_time {
    return Intl.message(
      'Pick Your Time!',
      name: 'pick_your_time',
      desc: '',
      args: [],
    );
  }

  /// `AM`
  String get am {
    return Intl.message(
      'AM',
      name: 'am',
      desc: '',
      args: [],
    );
  }

  /// `PM`
  String get pm {
    return Intl.message(
      'PM',
      name: 'pm',
      desc: '',
      args: [],
    );
  }

  /// `How many guests?`
  String get how_many_guests {
    return Intl.message(
      'How many guests?',
      name: 'how_many_guests',
      desc: '',
      args: [],
    );
  }

  /// `Any special requests`
  String get any_special_requests {
    return Intl.message(
      'Any special requests',
      name: 'any_special_requests',
      desc: '',
      args: [],
    );
  }

  /// `If you are late for a reservation, your reservation will be automatically cancelled`
  String get late {
    return Intl.message(
      'If you are late for a reservation, your reservation will be automatically cancelled',
      name: 'late',
      desc: '',
      args: [],
    );
  }

  /// `Book A Table`
  String get book_a_table {
    return Intl.message(
      'Book A Table',
      name: 'book_a_table',
      desc: '',
      args: [],
    );
  }

  /// `You will soon be sent a reservation card`
  String get thanks {
    return Intl.message(
      'You will soon be sent a reservation card',
      name: 'thanks',
      desc: '',
      args: [],
    );
  }

  /// `Visit Us`
  String get visit_us {
    return Intl.message(
      'Visit Us',
      name: 'visit_us',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Dijlah Village, Baghdad,\n10075 Iraq`
  String get location_address {
    return Intl.message(
      'Dijlah Village, Baghdad,\n10075 Iraq',
      name: 'location_address',
      desc: '',
      args: [],
    );
  }

  /// `Reserve A Table`
  String get reserve_a_table {
    return Intl.message(
      'Reserve A Table',
      name: 'reserve_a_table',
      desc: '',
      args: [],
    );
  }

  /// `Menus`
  String get menus {
    return Intl.message(
      'Menus',
      name: 'menus',
      desc: '',
      args: [],
    );
  }

  /// `Cold Appetizers`
  String get cold_appetizers {
    return Intl.message(
      'Cold Appetizers',
      name: 'cold_appetizers',
      desc: '',
      args: [],
    );
  }

  /// `Morning Breakfast`
  String get morning_breakfast {
    return Intl.message(
      'Morning Breakfast',
      name: 'morning_breakfast',
      desc: '',
      args: [],
    );
  }

  /// `Salads`
  String get salads {
    return Intl.message(
      'Salads',
      name: 'salads',
      desc: '',
      args: [],
    );
  }

  /// `Hot Appetizers`
  String get hot_apetizers {
    return Intl.message(
      'Hot Appetizers',
      name: 'hot_apetizers',
      desc: '',
      args: [],
    );
  }

  /// `Soups`
  String get soups {
    return Intl.message(
      'Soups',
      name: 'soups',
      desc: '',
      args: [],
    );
  }

  /// `Turkish Pide`
  String get turkish_pide {
    return Intl.message(
      'Turkish Pide',
      name: 'turkish_pide',
      desc: '',
      args: [],
    );
  }

  /// `Our Signature`
  String get our_signature {
    return Intl.message(
      'Our Signature',
      name: 'our_signature',
      desc: '',
      args: [],
    );
  }

  /// `Dürüm`
  String get durum {
    return Intl.message(
      'Dürüm',
      name: 'durum',
      desc: '',
      args: [],
    );
  }

  /// `Turkish Grill`
  String get turkish_grill {
    return Intl.message(
      'Turkish Grill',
      name: 'turkish_grill',
      desc: '',
      args: [],
    );
  }

  /// `Side Dishes`
  String get side_dishes {
    return Intl.message(
      'Side Dishes',
      name: 'side_dishes',
      desc: '',
      args: [],
    );
  }

  /// `Diet Food`
  String get diet_food {
    return Intl.message(
      'Diet Food',
      name: 'diet_food',
      desc: '',
      args: [],
    );
  }

  /// `Hot Beverages`
  String get hot_beverages {
    return Intl.message(
      'Hot Beverages',
      name: 'hot_beverages',
      desc: '',
      args: [],
    );
  }

  /// `Hot Tea`
  String get hot_tea {
    return Intl.message(
      'Hot Tea',
      name: 'hot_tea',
      desc: '',
      args: [],
    );
  }

  /// `Hot Coffee`
  String get hot_coffee {
    return Intl.message(
      'Hot Coffee',
      name: 'hot_coffee',
      desc: '',
      args: [],
    );
  }

  /// `Cold Beverages`
  String get cold_beverages {
    return Intl.message(
      'Cold Beverages',
      name: 'cold_beverages',
      desc: '',
      args: [],
    );
  }

  /// `Cocktails`
  String get cocktails {
    return Intl.message(
      'Cocktails',
      name: 'cocktails',
      desc: '',
      args: [],
    );
  }

  /// `Şerbet`
  String get serbet {
    return Intl.message(
      'Şerbet',
      name: 'serbet',
      desc: '',
      args: [],
    );
  }

  /// `Fresh Juice`
  String get fresh_juice {
    return Intl.message(
      'Fresh Juice',
      name: 'fresh_juice',
      desc: '',
      args: [],
    );
  }

  /// `Iced Tea And Coffee`
  String get iced_tea_and_coffee {
    return Intl.message(
      'Iced Tea And Coffee',
      name: 'iced_tea_and_coffee',
      desc: '',
      args: [],
    );
  }

  /// `Mevlana Shak`
  String get mevlana_shak {
    return Intl.message(
      'Mevlana Shak',
      name: 'mevlana_shak',
      desc: '',
      args: [],
    );
  }

  /// `Soft Drink`
  String get soft_drink {
    return Intl.message(
      'Soft Drink',
      name: 'soft_drink',
      desc: '',
      args: [],
    );
  }

  /// `Dessert`
  String get dessert {
    return Intl.message(
      'Dessert',
      name: 'dessert',
      desc: '',
      args: [],
    );
  }

  /// `Shisha`
  String get shisha {
    return Intl.message(
      'Shisha',
      name: 'shisha',
      desc: '',
      args: [],
    );
  }

  /// `Classic Shisha`
  String get classic_shisha {
    return Intl.message(
      'Classic Shisha',
      name: 'classic_shisha',
      desc: '',
      args: [],
    );
  }

  /// `Premium Shisha`
  String get premium_shisha {
    return Intl.message(
      'Premium Shisha',
      name: 'premium_shisha',
      desc: '',
      args: [],
    );
  }

  /// `Natural Shisha`
  String get natural_shisha {
    return Intl.message(
      'Natural Shisha',
      name: 'natural_shisha',
      desc: '',
      args: [],
    );
  }

  /// `Baklawa`
  String get Baklawa {
    return Intl.message(
      'Baklawa',
      name: 'Baklawa',
      desc: '',
      args: [],
    );
  }

  /// `Fill in all fields`
  String get fill_all_feild {
    return Intl.message(
      'Fill in all fields',
      name: 'fill_all_feild',
      desc: '',
      args: [],
    );
  }

  /// `Save the card to the Gallery`
  String get save_the_card_to_the_gallery {
    return Intl.message(
      'Save the card to the Gallery',
      name: 'save_the_card_to_the_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Table No`
  String get table_no {
    return Intl.message(
      'Table No',
      name: 'table_no',
      desc: '',
      args: [],
    );
  }

  /// `Date of reservation`
  String get date_of_reservation {
    return Intl.message(
      'Date of reservation',
      name: 'date_of_reservation',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete?`
  String get are_you_sure {
    return Intl.message(
      'Are you sure you want to delete?',
      name: 'are_you_sure',
      desc: '',
      args: [],
    );
  }

  /// `Search by phone number`
  String get search_by_phone_number {
    return Intl.message(
      'Search by phone number',
      name: 'search_by_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `New Reservation`
  String get new_reservation {
    return Intl.message(
      'New Reservation',
      name: 'new_reservation',
      desc: '',
      args: [],
    );
  }

  /// `New A reservation request was made for a table`
  String get a_reservation_request_was_made_for_a_table {
    return Intl.message(
      'New A reservation request was made for a table',
      name: 'a_reservation_request_was_made_for_a_table',
      desc: '',
      args: [],
    );
  }

  /// `The table has not been reserved`
  String get the_table_has_not_been_reserved {
    return Intl.message(
      'The table has not been reserved',
      name: 'the_table_has_not_been_reserved',
      desc: '',
      args: [],
    );
  }

  /// `All tables have been reserved`
  String get sorry_all_tables_have_been_reserved {
    return Intl.message(
      'All tables have been reserved',
      name: 'sorry_all_tables_have_been_reserved',
      desc: '',
      args: [],
    );
  }

  /// `We apologize to `
  String get sorry {
    return Intl.message(
      'We apologize to ',
      name: 'sorry',
      desc: '',
      args: [],
    );
  }

  /// `Your reservation has been fixed on a date `
  String get confirme {
    return Intl.message(
      'Your reservation has been fixed on a date ',
      name: 'confirme',
      desc: '',
      args: [],
    );
  }

  /// `New Reservations`
  String get new_reservations {
    return Intl.message(
      'New Reservations',
      name: 'new_reservations',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Pinned Reservations`
  String get pinned_reservations {
    return Intl.message(
      'Pinned Reservations',
      name: 'pinned_reservations',
      desc: '',
      args: [],
    );
  }

  /// `Archive`
  String get archive {
    return Intl.message(
      'Archive',
      name: 'archive',
      desc: '',
      args: [],
    );
  }

  /// `Reserve Now`
  String get reserve_now {
    return Intl.message(
      'Reserve Now',
      name: 'reserve_now',
      desc: '',
      args: [],
    );
  }

  /// `Hour`
  String get hour {
    return Intl.message(
      'Hour',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `Minute`
  String get minute {
    return Intl.message(
      'Minute',
      name: 'minute',
      desc: '',
      args: [],
    );
  }

  /// `Here`
  String get here {
    return Intl.message(
      'Here',
      name: 'here',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'fa'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
