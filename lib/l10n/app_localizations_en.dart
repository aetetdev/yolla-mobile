// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Yolla';

  @override
  String get appTagline => 'Swipe the cards, build your trip.';

  @override
  String get loading => 'Loading';

  @override
  String get navDiscover => 'Discover';

  @override
  String get navTrips => 'My trips';

  @override
  String get navProfile => 'Profile';

  @override
  String get modeCityTitle => 'Explore a city';

  @override
  String get modeCityDetail =>
      'Pick a city, browse places card by card, and get a walking route for the ones you like.';

  @override
  String get modeRouteTitle => 'I\'m hitting the road';

  @override
  String get modeRouteDetail =>
      'Tell us where you\'re going, and we\'ll show what\'s along the way in order.';

  @override
  String get cityPickerTitle => 'Where to?';

  @override
  String get cityPickerSubtitle => 'Pick a city and swipe your way to a plan.';

  @override
  String get citySearchHint => 'Search cities';

  @override
  String get cityNotFoundTitle => 'No city found';

  @override
  String get cityNotFoundEmpty => 'No city with ready content could be listed.';

  @override
  String cityNotFoundQuery(String query) {
    return 'No results for \"$query\".';
  }

  @override
  String get cityNoContent => 'No content yet';

  @override
  String cityPlaceCount(int count) {
    return '$count places';
  }

  @override
  String get citiesLoadFailed => 'Couldn\'t load cities';

  @override
  String get deckStampLike => 'ADD';

  @override
  String get deckStampPass => 'SKIP';

  @override
  String get deckStampLater => 'LATER';

  @override
  String get deckActionUndo => 'Undo';

  @override
  String get deckActionPass => 'Skip';

  @override
  String get deckActionLater => 'Maybe later';

  @override
  String get deckActionLike => 'Add to plan';

  @override
  String get deckDetail => 'Details';

  @override
  String get deckDetailSemantics => 'See details';

  @override
  String deckLikedSemantics(int count) {
    return '$count liked places, go to plan';
  }

  @override
  String get deckAlreadySent => 'This swipe was already sent';

  @override
  String get deckUndoFailed => 'Couldn\'t undo — check your connection';

  @override
  String get deckFinishedTitle => 'That\'s the whole deck';

  @override
  String deckFinishedDetail(int count) {
    return 'You liked $count places. Ready to build your plan.';
  }

  @override
  String get deckEmptyTitle => 'Nothing here yet';

  @override
  String get deckEmptyDetail =>
      'We couldn\'t find places to show for this city. Try another one.';

  @override
  String get deckCreatePlan => 'Build the plan';

  @override
  String deckDetourLabel(String distance) {
    return '$distance detour';
  }

  @override
  String get corridorTitle => 'Hitting the road';

  @override
  String get corridorIntro =>
      'We\'ll show places along your route, in the order you\'ll pass them.';

  @override
  String get corridorFrom => 'From';

  @override
  String get corridorTo => 'To';

  @override
  String get corridorPickCity => 'Pick a city';

  @override
  String get corridorUseMyLocation => 'Start from my location';

  @override
  String get corridorMyLocation => 'Where I am';

  @override
  String get corridorLocationDenied =>
      'Location permission denied; you can pick a city instead.';

  @override
  String get corridorLocationFailed =>
      'Could not get your location, try again.';

  @override
  String get corridorSameCity => 'Start and destination can\'t be the same.';

  @override
  String get corridorBufferTitle => 'Detour allowance';

  @override
  String corridorBufferDetail(int km) {
    return 'Show places at most $km km off the main road.';
  }

  @override
  String get corridorStart => 'Show what\'s on the way';

  @override
  String get corridorCitiesTitle => 'Which cities should we stop in?';

  @override
  String get corridorCitiesIntro =>
      'Cities along your route, in the order you\'ll pass them. Uncheck the ones you\'d skip.';

  @override
  String corridorCitiesPlaces(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count places',
      one: '1 place',
    );
    return '$_temp0';
  }

  @override
  String get corridorCitiesSelectAll => 'Select all';

  @override
  String get corridorCitiesClear => 'None';

  @override
  String corridorCitiesSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cities selected',
      one: '1 city selected',
      zero: 'No cities selected',
    );
    return '$_temp0';
  }

  @override
  String get corridorCitiesEmptyTitle => 'No cities to show on this route';

  @override
  String get corridorCitiesEmptyDetail =>
      'Try raising the detour allowance so more places fall inside the corridor.';

  @override
  String get corridorCitiesContinue => 'Continue';

  @override
  String get likedTitle => 'Your likes';

  @override
  String get likedEmptyTitle => 'You haven\'t liked anything yet';

  @override
  String get likedEmptyDetail => 'Places you swipe right land here.';

  @override
  String get likedSelectAtLeastOne => 'Select at least one place';

  @override
  String get likedSelectAtLeastTwo => 'Pick at least two places for a route';

  @override
  String likedCreateWith(int count) {
    return 'Create a plan with $count places';
  }

  @override
  String get likedNeedCity => 'To build a plan, start from a city deck.';

  @override
  String likedRowSemantics(String name, String state) {
    return '$name, $state';
  }

  @override
  String get likedInPlan => 'in plan';

  @override
  String get likedNotInPlan => 'not in plan';

  @override
  String get tripNameDialogTitle => 'Name your plan';

  @override
  String get tripNameHint => 'Plan name';

  @override
  String get tripDefaultName => 'My trip';

  @override
  String tripCityName(String city) {
    return '$city trip';
  }

  @override
  String get tripsTitle => 'My trips';

  @override
  String get tripsEmptyTitle => 'No plans yet';

  @override
  String get tripsEmptyDetail =>
      'Pick a city and start swiping; you can build a plan from what you like.';

  @override
  String get tripsEmptyAction => 'Pick a city';

  @override
  String tripStopCount(int count) {
    return '$count stops';
  }

  @override
  String get tripRouteNotComputed => 'route not calculated';

  @override
  String get tripFallbackTitle => 'Plan';

  @override
  String get tripRename => 'Rename';

  @override
  String get tripRenameTitle => 'Rename plan';

  @override
  String get tripDelete => 'Delete plan';

  @override
  String get tripDeleteTitle => 'Delete this plan?';

  @override
  String get tripDeleteDetail => 'This can\'t be undone.';

  @override
  String get tripNoStopsTitle => 'No stops left';

  @override
  String get tripNoStopsDetail => 'Head back to the deck and like some places.';

  @override
  String get tripRouteHint =>
      'Route not calculated yet. Stops will be ordered for the shortest trip.';

  @override
  String get tripMetricDistance => 'Distance';

  @override
  String get tripMetricTravel => 'Travel time';

  @override
  String get tripMetricVisit => 'Visiting';

  @override
  String get tripTooLongOnFoot =>
      'Stops are far apart — walking takes a while, a car is recommended.';

  @override
  String get tripStopsTitle => 'Stops';

  @override
  String get tripRemoveStop => 'Remove from plan';

  @override
  String get tripNeedTwoStops =>
      'A route needs at least two stops in the plan.';

  @override
  String get tripOptimize => 'Calculate route';

  @override
  String get tripReoptimize => 'Recalculate route';

  @override
  String get tripMapNoLocation => 'No location to show';

  @override
  String get tripMapStopsOnly => 'Stops — route not calculated';

  @override
  String get placeDirections => 'Get directions';

  @override
  String get placeWebsite => 'Website';

  @override
  String get placeWikipedia => 'Wikipedia';

  @override
  String get placeAddress => 'Address';

  @override
  String get placeOpeningHours => 'Opening hours';

  @override
  String get placeAverageVisit => 'Average visit';

  @override
  String placeAverageVisitValue(int minutes) {
    return '$minutes minutes';
  }

  @override
  String get placeNearby => 'Nearby';

  @override
  String get placeLinkFailed => 'Couldn\'t open the link';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileAnonymousTitle => 'You\'re using Yolla without an account';

  @override
  String get profileAnonymousDetail =>
      'Your plans and likes live on this device. Create an account to reach them from other devices — and to keep them if you delete the app.';

  @override
  String get profileSignedInTitle => 'You\'re signed in';

  @override
  String get profileSignedInDetail =>
      'Your plans are tied to your account; sign in on another device to pick up where you left off.';

  @override
  String get profileVersion => 'Version';

  @override
  String get profileSources => 'Sources and licences';

  @override
  String get profileSourcesDetail =>
      'OpenStreetMap, Wikimedia Commons, Wikipedia';

  @override
  String get mapPreparing => 'Preparing the map';

  @override
  String get mapAttribution => '© OpenStreetMap contributors';

  @override
  String get mapPinNoPhoto => 'This place has no photo';

  @override
  String get mapPinDetail => 'See details';

  @override
  String get mapPinLike => 'Like';

  @override
  String get mapPinLikedShort => 'Liked';

  @override
  String mapPinLiked(String name) {
    return '$name added to your likes';
  }

  @override
  String get mapPinGoToLiked => 'Your likes';

  @override
  String get contributePhotoTitle => 'This place has no photo';

  @override
  String get contributePhotoDetail =>
      'If you have been here, add a photo; it goes live once approved.';

  @override
  String contributePhotoDetailWithCoins(int coins) {
    return 'If you have been here, add a photo. You earn $coins coins once it is approved.';
  }

  @override
  String get contributePhotoAction => 'Add a photo';

  @override
  String get contributePhotoCamera => 'Take a photo';

  @override
  String get contributePhotoGallery => 'Pick from gallery';

  @override
  String get contributePhotoRules =>
      'Use a clear photo of the place itself. Do not submit someone else\'s photo.';

  @override
  String get contributePhotoModeration =>
      'Submissions are reviewed by hand before going live. Location data is stripped from the photo.';

  @override
  String get contributePhotoSent =>
      'Photo sent — it will go live after review.';

  @override
  String get premiumTitle => 'Coins and Premium';

  @override
  String premiumCoinBalance(int count) {
    return '$count coins';
  }

  @override
  String premiumCoinHowTo(int coins) {
    return 'You earn $coins coins for every photo of yours that gets approved.';
  }

  @override
  String premiumPendingPhotos(int count) {
    return '$count of your photos are under review';
  }

  @override
  String premiumTripQuota(int left, int limit) {
    return 'You have $left plans left this month (out of $limit).';
  }

  @override
  String get premiumBenefitsTitle => 'What premium gives you';

  @override
  String get premiumBenefitOfflineTitle => 'Offline map and plans';

  @override
  String get premiumBenefitOfflineDetail =>
      'Download a city map and your plan, use them without data.';

  @override
  String get premiumBenefitTripsTitle => 'Unlimited plans';

  @override
  String premiumBenefitTripsDetail(int limit) {
    return 'Free accounts save $limit plans a month; premium has no limit.';
  }

  @override
  String get premiumBenefitAdsTitle => 'No ads';

  @override
  String get premiumBenefitAdsDetail => 'No advertising is shown in the app.';

  @override
  String get premiumWithCoinsTitle => 'Buy with coins';

  @override
  String premiumWithCoinsDetail(int coins) {
    return 'Turn the coins you earned from photo contributions into premium time. Each approved photo is $coins coins.';
  }

  @override
  String get premiumOneMonth => '1 month of premium';

  @override
  String get premiumTwoMonths => '2 months of premium';

  @override
  String get premiumUnlimited => 'Lifetime premium';

  @override
  String premiumPackageCost(int cost) {
    return '$cost coins';
  }

  @override
  String premiumPackageShort(int missing) {
    return '$missing more coins needed';
  }

  @override
  String get premiumWithMoneyTitle => 'Buy with money';

  @override
  String get premiumWithMoneyDetail =>
      'If you would rather not collect coins, you will be able to buy premium directly.';

  @override
  String get premiumWithMoneySoon => 'Store purchases are not enabled yet';

  @override
  String get premiumConfirmTitle => 'Buy premium?';

  @override
  String premiumConfirmDetail(int cost) {
    return '$cost coins will be spent.';
  }

  @override
  String get premiumConfirmAction => 'Buy';

  @override
  String get premiumRedeemed => 'Your premium is active.';

  @override
  String get premiumActiveTitle => 'Premium is on';

  @override
  String get premiumActiveUnlimited => 'You have lifetime premium.';

  @override
  String premiumActiveUntil(String date) {
    return 'Valid until $date.';
  }

  @override
  String get premiumCoinHistory => 'Coin activity';

  @override
  String get premiumReasonPhoto => 'Photo approved';

  @override
  String get premiumReasonRedeem => 'Premium purchased';

  @override
  String get premiumReasonAdjustment => 'Adjustment';

  @override
  String get profilePremium => 'Coins and Premium';

  @override
  String get profilePremiumDetail =>
      'Your balance, the perks, and buying premium';

  @override
  String get mapEnter => 'Enter';

  @override
  String get commonClose => 'Close';

  @override
  String get navHandoffOpen => 'Open in navigation';

  @override
  String get navHandoffTitle => 'Open in navigation';

  @override
  String get navHandoffDetail =>
      'We hand the route to a navigation app on your phone; turn-by-turn directions come from there.';

  @override
  String get navHandoffNone =>
      'No supported navigation app was found on your phone.';

  @override
  String get navHandoffFailed => 'The navigation app could not be opened.';

  @override
  String navHandoffDropped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'This app cannot carry $count stops; the first and last are kept.',
      one: 'This app cannot carry $count stop; the first and last are kept.',
    );
    return '$_temp0';
  }

  @override
  String get navAppGoogleMaps => 'Google Maps';

  @override
  String get navAppYandexMaps => 'Yandex Maps';

  @override
  String get navAppYandexNavi => 'Yandex Navigator';

  @override
  String get navAppAppleMaps => 'Apple Maps';

  @override
  String get authWallSubtitle =>
      'Swipe the cards, build your trip. Sign in to get started.';

  @override
  String get authWallFootnote =>
      'Your trips and likes are tied to your account, so they survive a new phone.';

  @override
  String get authPasswordShow => 'Show password';

  @override
  String get authPasswordHide => 'Hide password';

  @override
  String get authRegister => 'Create account';

  @override
  String get authLogin => 'Sign in';

  @override
  String get authSignOut => 'Sign out';

  @override
  String get authDeleteAccount => 'Delete my account';

  @override
  String get authRegisterDetail =>
      'The plans and likes on this device will move to your account.';

  @override
  String get authLoginDetail => 'Reach your plans from any device.';

  @override
  String get authEmail => 'Email';

  @override
  String get authPassword => 'Password';

  @override
  String get authPasswordHelper => 'At least 8 characters';

  @override
  String get authEmailRequired => 'Email is required';

  @override
  String get authEmailInvalid => 'Enter a valid email';

  @override
  String get authPasswordRequired => 'Password is required';

  @override
  String get authPasswordTooShort => 'Must be at least 8 characters';

  @override
  String get authSwitchToLogin => 'Already have an account? Sign in';

  @override
  String get authSwitchToRegister => 'No account yet? Create one';

  @override
  String get authDeleteTitle => 'Delete your account';

  @override
  String get authDeleteDetail =>
      'Your account, plans and swipe history will be permanently deleted. This can\'t be undone.';

  @override
  String get authDeletePasswordLabel => 'Your password';

  @override
  String get authDeleted => 'Your account has been deleted.';

  @override
  String get attributionsTitle => 'Sources and licences';

  @override
  String get attributionsIntro =>
      'Yolla runs on open data. Everything we show comes from somewhere, and we\'re required to say where.';

  @override
  String get attributionsSeen => 'Data used in this session';

  @override
  String get attributionOsmTitle => 'Place data — OpenStreetMap';

  @override
  String get attributionOsmDetail =>
      'Location, names and tags come from OpenStreetMap contributors, used under the ODbL licence.';

  @override
  String get attributionCommonsTitle => 'Photos — Wikimedia Commons';

  @override
  String get attributionCommonsDetail =>
      'Photos come from Wikimedia Commons, mostly CC BY-SA. The photographer and licence are shown next to every photo.';

  @override
  String get attributionWikipediaTitle => 'Descriptions — Wikipedia';

  @override
  String get attributionWikipediaDetail =>
      'Place descriptions come from Wikipedia summaries, CC BY-SA licensed.';

  @override
  String get attributionOsrmTitle => 'Routing — OSRM';

  @override
  String get attributionOsrmDetail =>
      'Walking and driving routes are calculated with the open-source OSRM engine over the OpenStreetMap road network.';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonCreate => 'Create';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonRetry => 'Try again';

  @override
  String get commonBack => 'Back';

  @override
  String get commonLoading => 'Loading';

  @override
  String get commonLoadFailed => 'Couldn\'t load';

  @override
  String get commonSomethingWrong => 'Something went wrong';

  @override
  String get durationLessThanMinute => 'less than a minute';

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String durationHours(int hours) {
    return '$hours h';
  }

  @override
  String durationHoursMinutes(int hours, int minutes) {
    return '$hours h $minutes min';
  }
}
