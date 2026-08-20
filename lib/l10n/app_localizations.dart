import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n)!;
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @appName.
  ///
  /// In tr, this message translates to:
  /// **'Yolla'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In tr, this message translates to:
  /// **'Kaydır, keşfet, yola çık.'**
  String get appTagline;

  /// Yükleniyor göstergesinin ekran okuyucuya bildirilen adı.
  ///
  /// In tr, this message translates to:
  /// **'Yükleniyor'**
  String get loading;

  /// No description provided for @navDiscover.
  ///
  /// In tr, this message translates to:
  /// **'Keşfet'**
  String get navDiscover;

  /// No description provided for @navTrips.
  ///
  /// In tr, this message translates to:
  /// **'Planlarım'**
  String get navTrips;

  /// No description provided for @navProfile.
  ///
  /// In tr, this message translates to:
  /// **'Profil'**
  String get navProfile;

  /// No description provided for @modeCityTitle.
  ///
  /// In tr, this message translates to:
  /// **'Şehir gez'**
  String get modeCityTitle;

  /// No description provided for @modeCityDetail.
  ///
  /// In tr, this message translates to:
  /// **'Bir şehir seç, gezilecek yerleri kart kart gör, beğendiklerin için yürüme rotası çıkar.'**
  String get modeCityDetail;

  /// No description provided for @modeRouteTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yola çıkıyorum'**
  String get modeRouteTitle;

  /// No description provided for @modeRouteDetail.
  ///
  /// In tr, this message translates to:
  /// **'Nereden nereye gittiğini söyle, yol üstündeki yerleri sırayla göster.'**
  String get modeRouteDetail;

  /// No description provided for @modeLikedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Beğendiğim yerler'**
  String get modeLikedTitle;

  /// No description provided for @modeLikedDetail.
  ///
  /// In tr, this message translates to:
  /// **'Daha önce beğendiklerinden seç, onlarla ayrı bir plan kur.'**
  String get modeLikedDetail;

  /// No description provided for @cityPickerTitle.
  ///
  /// In tr, this message translates to:
  /// **'Nereyi gezeceksin?'**
  String get cityPickerTitle;

  /// No description provided for @cityPickerSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Şehri seç, kartları kaydırarak planını çıkar.'**
  String get cityPickerSubtitle;

  /// No description provided for @citySearchHint.
  ///
  /// In tr, this message translates to:
  /// **'Şehir ara'**
  String get citySearchHint;

  /// No description provided for @cityNotFoundTitle.
  ///
  /// In tr, this message translates to:
  /// **'Şehir bulunamadı'**
  String get cityNotFoundTitle;

  /// No description provided for @cityNotFoundEmpty.
  ///
  /// In tr, this message translates to:
  /// **'İçeriği hazır şehir listelenemedi.'**
  String get cityNotFoundEmpty;

  /// No description provided for @cityNotFoundQuery.
  ///
  /// In tr, this message translates to:
  /// **'\"{query}\" için sonuç yok.'**
  String cityNotFoundQuery(String query);

  /// No description provided for @cityNoContent.
  ///
  /// In tr, this message translates to:
  /// **'Henüz içerik yok'**
  String get cityNoContent;

  /// No description provided for @cityPlaceCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} yer'**
  String cityPlaceCount(int count);

  /// No description provided for @citiesLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Şehirler yüklenemedi'**
  String get citiesLoadFailed;

  /// No description provided for @deckStampLike.
  ///
  /// In tr, this message translates to:
  /// **'PLANA EKLE'**
  String get deckStampLike;

  /// No description provided for @deckStampPass.
  ///
  /// In tr, this message translates to:
  /// **'GEÇ'**
  String get deckStampPass;

  /// No description provided for @deckStampLater.
  ///
  /// In tr, this message translates to:
  /// **'SONRA'**
  String get deckStampLater;

  /// No description provided for @deckActionUndo.
  ///
  /// In tr, this message translates to:
  /// **'Geri al'**
  String get deckActionUndo;

  /// No description provided for @deckActionPass.
  ///
  /// In tr, this message translates to:
  /// **'Geç'**
  String get deckActionPass;

  /// No description provided for @deckActionLater.
  ///
  /// In tr, this message translates to:
  /// **'Sonra bakarım'**
  String get deckActionLater;

  /// No description provided for @deckActionLike.
  ///
  /// In tr, this message translates to:
  /// **'Plana ekle'**
  String get deckActionLike;

  /// No description provided for @deckDetail.
  ///
  /// In tr, this message translates to:
  /// **'Ayrıntı'**
  String get deckDetail;

  /// No description provided for @deckDetailSemantics.
  ///
  /// In tr, this message translates to:
  /// **'Ayrıntıları gör'**
  String get deckDetailSemantics;

  /// No description provided for @deckAlreadySent.
  ///
  /// In tr, this message translates to:
  /// **'Bu kaydırma zaten gönderildi'**
  String get deckAlreadySent;

  /// No description provided for @deckUndoFailed.
  ///
  /// In tr, this message translates to:
  /// **'Geri alınamadı, bağlantını kontrol et'**
  String get deckUndoFailed;

  /// No description provided for @deckFinishedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Deste bitti'**
  String get deckFinishedTitle;

  /// No description provided for @deckFinishedDetail.
  ///
  /// In tr, this message translates to:
  /// **'{count} yer beğendin. Planını oluşturmaya hazırsın.'**
  String deckFinishedDetail(int count);

  /// No description provided for @deckEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Burada henüz içerik yok'**
  String get deckEmptyTitle;

  /// No description provided for @deckEmptyDetail.
  ///
  /// In tr, this message translates to:
  /// **'Bu şehir için gösterilebilecek yer bulunamadı. Başka bir şehir seçebilirsin.'**
  String get deckEmptyDetail;

  /// No description provided for @deckCreatePlan.
  ///
  /// In tr, this message translates to:
  /// **'Planı oluştur'**
  String get deckCreatePlan;

  /// Deste ekranının üstündeki plan kurma düğmesi; sayı bu destede beğenilen yer sayısı.
  ///
  /// In tr, this message translates to:
  /// **'{count, plural, =1{Plan kur · 1} other{Plan kur · {count}}}'**
  String deckCreateTripPill(int count);

  /// No description provided for @deckDetourLabel.
  ///
  /// In tr, this message translates to:
  /// **'{distance} sapma'**
  String deckDetourLabel(String distance);

  /// No description provided for @corridorTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yola çıkıyorum'**
  String get corridorTitle;

  /// No description provided for @corridorIntro.
  ///
  /// In tr, this message translates to:
  /// **'Yol boyunca uğrayabileceğin yerleri, geçiş sırasına göre göstereceğiz.'**
  String get corridorIntro;

  /// No description provided for @corridorFrom.
  ///
  /// In tr, this message translates to:
  /// **'Nereden'**
  String get corridorFrom;

  /// No description provided for @corridorTo.
  ///
  /// In tr, this message translates to:
  /// **'Nereye'**
  String get corridorTo;

  /// No description provided for @corridorPickCity.
  ///
  /// In tr, this message translates to:
  /// **'Şehir seç'**
  String get corridorPickCity;

  /// No description provided for @corridorUseMyLocation.
  ///
  /// In tr, this message translates to:
  /// **'Konumumdan başla'**
  String get corridorUseMyLocation;

  /// No description provided for @corridorMyLocation.
  ///
  /// In tr, this message translates to:
  /// **'Bulunduğum yer'**
  String get corridorMyLocation;

  /// No description provided for @corridorLocationDenied.
  ///
  /// In tr, this message translates to:
  /// **'Konum izni verilmedi; başlangıç için şehir seçebilirsin.'**
  String get corridorLocationDenied;

  /// No description provided for @corridorLocationFailed.
  ///
  /// In tr, this message translates to:
  /// **'Konumun alınamadı, tekrar dene.'**
  String get corridorLocationFailed;

  /// No description provided for @corridorSameCity.
  ///
  /// In tr, this message translates to:
  /// **'Başlangıç ve varış aynı olamaz.'**
  String get corridorSameCity;

  /// No description provided for @corridorBufferTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yoldan sapma payı'**
  String get corridorBufferTitle;

  /// No description provided for @corridorBufferDetail.
  ///
  /// In tr, this message translates to:
  /// **'Ana yoldan en fazla {km} km uzaktaki yerler gösterilsin.'**
  String corridorBufferDetail(int km);

  /// No description provided for @corridorStart.
  ///
  /// In tr, this message translates to:
  /// **'Yol üstünü göster'**
  String get corridorStart;

  /// No description provided for @corridorCitiesTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hangi şehirlere uğrayalım?'**
  String get corridorCitiesTitle;

  /// No description provided for @corridorCitiesIntro.
  ///
  /// In tr, this message translates to:
  /// **'Yolun geçtiği şehirler, geçiş sırasına göre. İstemediklerinin işaretini kaldır.'**
  String get corridorCitiesIntro;

  /// No description provided for @corridorCitiesPlaces.
  ///
  /// In tr, this message translates to:
  /// **'{count, plural, =1{1 yer} other{{count} yer}}'**
  String corridorCitiesPlaces(int count);

  /// No description provided for @corridorCitiesSelectAll.
  ///
  /// In tr, this message translates to:
  /// **'Hepsini seç'**
  String get corridorCitiesSelectAll;

  /// No description provided for @corridorCitiesClear.
  ///
  /// In tr, this message translates to:
  /// **'Hiçbiri'**
  String get corridorCitiesClear;

  /// No description provided for @corridorCitiesSelected.
  ///
  /// In tr, this message translates to:
  /// **'{count, plural, =0{Şehir seçilmedi} =1{1 şehir seçildi} other{{count} şehir seçildi}}'**
  String corridorCitiesSelected(int count);

  /// No description provided for @corridorCitiesEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bu yolda gösterilecek şehir yok'**
  String get corridorCitiesEmptyTitle;

  /// No description provided for @corridorCitiesEmptyDetail.
  ///
  /// In tr, this message translates to:
  /// **'Sapma payını artırmayı dene; koridora daha çok yer girer.'**
  String get corridorCitiesEmptyDetail;

  /// No description provided for @corridorCitiesContinue.
  ///
  /// In tr, this message translates to:
  /// **'Devam et'**
  String get corridorCitiesContinue;

  /// No description provided for @likedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Beğendiklerin'**
  String get likedTitle;

  /// No description provided for @likedEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henüz bir yer beğenmedin'**
  String get likedEmptyTitle;

  /// No description provided for @likedEmptyDetail.
  ///
  /// In tr, this message translates to:
  /// **'Kartları sağa kaydırdığın yerler burada birikir.'**
  String get likedEmptyDetail;

  /// No description provided for @likedSelectAtLeastOne.
  ///
  /// In tr, this message translates to:
  /// **'En az bir yer seç'**
  String get likedSelectAtLeastOne;

  /// No description provided for @likedSelectAtLeastTwo.
  ///
  /// In tr, this message translates to:
  /// **'Rota için en az iki yer seç'**
  String get likedSelectAtLeastTwo;

  /// No description provided for @likedCreateWith.
  ///
  /// In tr, this message translates to:
  /// **'{count} yerle plan oluştur'**
  String likedCreateWith(int count);

  /// No description provided for @likedRowSemantics.
  ///
  /// In tr, this message translates to:
  /// **'{name}, {state}'**
  String likedRowSemantics(String name, String state);

  /// No description provided for @likedInPlan.
  ///
  /// In tr, this message translates to:
  /// **'planda'**
  String get likedInPlan;

  /// No description provided for @likedNotInPlan.
  ///
  /// In tr, this message translates to:
  /// **'planda değil'**
  String get likedNotInPlan;

  /// No description provided for @tripNameDialogTitle.
  ///
  /// In tr, this message translates to:
  /// **'Plana bir ad ver'**
  String get tripNameDialogTitle;

  /// No description provided for @tripNameHint.
  ///
  /// In tr, this message translates to:
  /// **'Plan adı'**
  String get tripNameHint;

  /// No description provided for @tripDefaultName.
  ///
  /// In tr, this message translates to:
  /// **'Gezi planım'**
  String get tripDefaultName;

  /// No description provided for @tripCityName.
  ///
  /// In tr, this message translates to:
  /// **'{city} gezisi'**
  String tripCityName(String city);

  /// No description provided for @tripsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Planlarım'**
  String get tripsTitle;

  /// No description provided for @tripsEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henüz planın yok'**
  String get tripsEmptyTitle;

  /// No description provided for @tripsEmptyDetail.
  ///
  /// In tr, this message translates to:
  /// **'Bir şehir seçip kartları kaydırmaya başla; beğendiklerinle plan kurabilirsin.'**
  String get tripsEmptyDetail;

  /// No description provided for @tripsEmptyAction.
  ///
  /// In tr, this message translates to:
  /// **'Şehir seç'**
  String get tripsEmptyAction;

  /// No description provided for @tripStopCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} durak'**
  String tripStopCount(int count);

  /// No description provided for @tripRouteNotComputed.
  ///
  /// In tr, this message translates to:
  /// **'rota hesaplanmadı'**
  String get tripRouteNotComputed;

  /// No description provided for @tripFallbackTitle.
  ///
  /// In tr, this message translates to:
  /// **'Plan'**
  String get tripFallbackTitle;

  /// No description provided for @tripRename.
  ///
  /// In tr, this message translates to:
  /// **'Yeniden adlandır'**
  String get tripRename;

  /// No description provided for @tripRenameTitle.
  ///
  /// In tr, this message translates to:
  /// **'Planı yeniden adlandır'**
  String get tripRenameTitle;

  /// No description provided for @tripDelete.
  ///
  /// In tr, this message translates to:
  /// **'Planı sil'**
  String get tripDelete;

  /// No description provided for @tripDeleteTitle.
  ///
  /// In tr, this message translates to:
  /// **'Plan silinsin mi?'**
  String get tripDeleteTitle;

  /// No description provided for @tripDeleteDetail.
  ///
  /// In tr, this message translates to:
  /// **'Bu işlem geri alınamaz.'**
  String get tripDeleteDetail;

  /// No description provided for @tripNoStopsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Planda durak kalmadı'**
  String get tripNoStopsTitle;

  /// No description provided for @tripNoStopsDetail.
  ///
  /// In tr, this message translates to:
  /// **'Kart destesine dönüp yeni yerler beğenebilirsin.'**
  String get tripNoStopsDetail;

  /// No description provided for @tripRouteHint.
  ///
  /// In tr, this message translates to:
  /// **'Rota henüz hesaplanmadı. Duraklar en kısa sıraya dizilecek.'**
  String get tripRouteHint;

  /// No description provided for @tripMetricDistance.
  ///
  /// In tr, this message translates to:
  /// **'Mesafe'**
  String get tripMetricDistance;

  /// No description provided for @tripMetricTravel.
  ///
  /// In tr, this message translates to:
  /// **'Yol süresi'**
  String get tripMetricTravel;

  /// No description provided for @tripMetricVisit.
  ///
  /// In tr, this message translates to:
  /// **'Gezme'**
  String get tripMetricVisit;

  /// No description provided for @tripTooLongOnFoot.
  ///
  /// In tr, this message translates to:
  /// **'Duraklar birbirinden uzak — yürüyerek uzun sürer, araç önerilir.'**
  String get tripTooLongOnFoot;

  /// No description provided for @tripStopsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Duraklar'**
  String get tripStopsTitle;

  /// No description provided for @tripRemoveStop.
  ///
  /// In tr, this message translates to:
  /// **'Plandan çıkar'**
  String get tripRemoveStop;

  /// No description provided for @tripNeedTwoStops.
  ///
  /// In tr, this message translates to:
  /// **'Rota hesaplamak için planda en az iki durak olmalı.'**
  String get tripNeedTwoStops;

  /// No description provided for @tripOptimize.
  ///
  /// In tr, this message translates to:
  /// **'Rotayı hesapla'**
  String get tripOptimize;

  /// No description provided for @tripReoptimize.
  ///
  /// In tr, this message translates to:
  /// **'Rotayı yeniden hesapla'**
  String get tripReoptimize;

  /// No description provided for @tripMapNoLocation.
  ///
  /// In tr, this message translates to:
  /// **'Gösterilecek konum yok'**
  String get tripMapNoLocation;

  /// No description provided for @tripMapStopsOnly.
  ///
  /// In tr, this message translates to:
  /// **'Duraklar — rota hesaplanmadı'**
  String get tripMapStopsOnly;

  /// No description provided for @placeDirections.
  ///
  /// In tr, this message translates to:
  /// **'Yol tarifi al'**
  String get placeDirections;

  /// No description provided for @placeWebsite.
  ///
  /// In tr, this message translates to:
  /// **'Web sitesi'**
  String get placeWebsite;

  /// No description provided for @placeWikipedia.
  ///
  /// In tr, this message translates to:
  /// **'Wikipedia'**
  String get placeWikipedia;

  /// No description provided for @placeAddress.
  ///
  /// In tr, this message translates to:
  /// **'Adres'**
  String get placeAddress;

  /// No description provided for @placeOpeningHours.
  ///
  /// In tr, this message translates to:
  /// **'Çalışma saatleri'**
  String get placeOpeningHours;

  /// No description provided for @placeAverageVisit.
  ///
  /// In tr, this message translates to:
  /// **'Ortalama süre'**
  String get placeAverageVisit;

  /// No description provided for @placeAverageVisitValue.
  ///
  /// In tr, this message translates to:
  /// **'{minutes} dakika'**
  String placeAverageVisitValue(int minutes);

  /// No description provided for @placeNearby.
  ///
  /// In tr, this message translates to:
  /// **'Yakında'**
  String get placeNearby;

  /// No description provided for @placeLinkFailed.
  ///
  /// In tr, this message translates to:
  /// **'Bağlantı açılamadı'**
  String get placeLinkFailed;

  /// No description provided for @profileTitle.
  ///
  /// In tr, this message translates to:
  /// **'Profil'**
  String get profileTitle;

  /// No description provided for @profileAnonymousTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hesapsız kullanıyorsun'**
  String get profileAnonymousTitle;

  /// No description provided for @profileAnonymousDetail.
  ///
  /// In tr, this message translates to:
  /// **'Planların ve beğendiklerin bu cihazda tutuluyor. Hesap açarsan başka cihazlarda da açabilirsin — uygulamayı silersen kaybolmazlar.'**
  String get profileAnonymousDetail;

  /// No description provided for @profileSignedInTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hesabın açık'**
  String get profileSignedInTitle;

  /// No description provided for @profileSignedInDetail.
  ///
  /// In tr, this message translates to:
  /// **'Planların hesabına bağlı; başka bir cihazda giriş yaparak aynı yerden devam edebilirsin.'**
  String get profileSignedInDetail;

  /// No description provided for @profileVersion.
  ///
  /// In tr, this message translates to:
  /// **'Sürüm'**
  String get profileVersion;

  /// No description provided for @profileSources.
  ///
  /// In tr, this message translates to:
  /// **'Kaynaklar ve lisanslar'**
  String get profileSources;

  /// No description provided for @profileSourcesDetail.
  ///
  /// In tr, this message translates to:
  /// **'OpenStreetMap, Wikimedia Commons, Wikipedia'**
  String get profileSourcesDetail;

  /// No description provided for @mapPreparing.
  ///
  /// In tr, this message translates to:
  /// **'Harita hazırlanıyor'**
  String get mapPreparing;

  /// No description provided for @mapAttribution.
  ///
  /// In tr, this message translates to:
  /// **'© OpenStreetMap katkıcıları'**
  String get mapAttribution;

  /// No description provided for @mapPinNoPhoto.
  ///
  /// In tr, this message translates to:
  /// **'Bu yerin fotoğrafı yok'**
  String get mapPinNoPhoto;

  /// No description provided for @mapPinDetail.
  ///
  /// In tr, this message translates to:
  /// **'Detayına bak'**
  String get mapPinDetail;

  /// No description provided for @mapPinLike.
  ///
  /// In tr, this message translates to:
  /// **'Beğendim'**
  String get mapPinLike;

  /// No description provided for @mapPinLikedShort.
  ///
  /// In tr, this message translates to:
  /// **'Beğenildi'**
  String get mapPinLikedShort;

  /// No description provided for @mapPinLiked.
  ///
  /// In tr, this message translates to:
  /// **'{name} beğenilenlere eklendi'**
  String mapPinLiked(String name);

  /// No description provided for @mapPinCreateTrip.
  ///
  /// In tr, this message translates to:
  /// **'Plan kur'**
  String get mapPinCreateTrip;

  /// No description provided for @contributePhotoTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bu yerin fotoğrafı yok'**
  String get contributePhotoTitle;

  /// No description provided for @contributePhotoDetail.
  ///
  /// In tr, this message translates to:
  /// **'Buraya gittiysen bir fotoğraf ekle; onaylandığında yayına girer.'**
  String get contributePhotoDetail;

  /// No description provided for @contributePhotoDetailWithCoins.
  ///
  /// In tr, this message translates to:
  /// **'Buraya gittiysen bir fotoğraf ekle. Onaylanırsa {coins} coin kazanırsın.'**
  String contributePhotoDetailWithCoins(int coins);

  /// No description provided for @contributePhotoAction.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraf ekle'**
  String get contributePhotoAction;

  /// No description provided for @contributePhotoCamera.
  ///
  /// In tr, this message translates to:
  /// **'Kamerayla çek'**
  String get contributePhotoCamera;

  /// No description provided for @contributePhotoGallery.
  ///
  /// In tr, this message translates to:
  /// **'Galeriden seç'**
  String get contributePhotoGallery;

  /// No description provided for @contributePhotoRules.
  ///
  /// In tr, this message translates to:
  /// **'Yerin kendisini gösteren, net bir fotoğraf olsun. Başkasının fotoğrafını gönderme.'**
  String get contributePhotoRules;

  /// No description provided for @contributePhotoModeration.
  ///
  /// In tr, this message translates to:
  /// **'Gönderiler yayına girmeden önce elle inceleniyor. Fotoğraftaki konum bilgisi kaldırılır.'**
  String get contributePhotoModeration;

  /// No description provided for @contributePhotoSent.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğrafın gönderildi, inceleme sonrası yayına girecek.'**
  String get contributePhotoSent;

  /// No description provided for @premiumTitle.
  ///
  /// In tr, this message translates to:
  /// **'Coin ve Premium'**
  String get premiumTitle;

  /// No description provided for @premiumCoinBalance.
  ///
  /// In tr, this message translates to:
  /// **'{count} coin'**
  String premiumCoinBalance(int count);

  /// No description provided for @premiumCoinHowTo.
  ///
  /// In tr, this message translates to:
  /// **'Gönderdiğin her fotoğraf onaylandığında {coins} coin kazanırsın.'**
  String premiumCoinHowTo(int coins);

  /// No description provided for @premiumPendingPhotos.
  ///
  /// In tr, this message translates to:
  /// **'{count} fotoğrafın inceleniyor'**
  String premiumPendingPhotos(int count);

  /// No description provided for @premiumTripQuota.
  ///
  /// In tr, this message translates to:
  /// **'Bu ay {left} plan hakkın kaldı ({limit} üzerinden).'**
  String premiumTripQuota(int left, int limit);

  /// No description provided for @premiumBenefitsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Premium ne veriyor?'**
  String get premiumBenefitsTitle;

  /// No description provided for @premiumBenefitOfflineTitle.
  ///
  /// In tr, this message translates to:
  /// **'Çevrimdışı harita ve plan'**
  String get premiumBenefitOfflineTitle;

  /// No description provided for @premiumBenefitOfflineDetail.
  ///
  /// In tr, this message translates to:
  /// **'Şehir haritasını ve planını indir, veri olmadan kullan.'**
  String get premiumBenefitOfflineDetail;

  /// No description provided for @premiumBenefitTripsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Sınırsız plan'**
  String get premiumBenefitTripsTitle;

  /// No description provided for @premiumBenefitTripsDetail.
  ///
  /// In tr, this message translates to:
  /// **'Ücretsiz hesap ayda {limit} plan kaydedebiliyor; premiumda sınır yok.'**
  String premiumBenefitTripsDetail(int limit);

  /// No description provided for @premiumBenefitAdsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Reklamsız'**
  String get premiumBenefitAdsTitle;

  /// No description provided for @premiumBenefitAdsDetail.
  ///
  /// In tr, this message translates to:
  /// **'Uygulamada reklam gösterilmez.'**
  String get premiumBenefitAdsDetail;

  /// No description provided for @premiumWithCoinsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Coinle al'**
  String get premiumWithCoinsTitle;

  /// No description provided for @premiumWithCoinsDetail.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraf katkısıyla kazandığın coinleri premium süresine çevir. Onaylanan her fotoğraf {coins} coin.'**
  String premiumWithCoinsDetail(int coins);

  /// No description provided for @premiumOneMonth.
  ///
  /// In tr, this message translates to:
  /// **'1 ay premium'**
  String get premiumOneMonth;

  /// No description provided for @premiumTwoMonths.
  ///
  /// In tr, this message translates to:
  /// **'2 ay premium'**
  String get premiumTwoMonths;

  /// No description provided for @premiumUnlimited.
  ///
  /// In tr, this message translates to:
  /// **'Süresiz premium'**
  String get premiumUnlimited;

  /// No description provided for @premiumPackageCost.
  ///
  /// In tr, this message translates to:
  /// **'{cost} coin'**
  String premiumPackageCost(int cost);

  /// No description provided for @premiumPackageShort.
  ///
  /// In tr, this message translates to:
  /// **'{missing} coin daha gerekiyor'**
  String premiumPackageShort(int missing);

  /// No description provided for @premiumWithMoneyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Parayla al'**
  String get premiumWithMoneyTitle;

  /// No description provided for @premiumWithMoneyDetail.
  ///
  /// In tr, this message translates to:
  /// **'Coin biriktirmek istemiyorsan doğrudan satın alabileceksin.'**
  String get premiumWithMoneyDetail;

  /// No description provided for @premiumWithMoneySoon.
  ///
  /// In tr, this message translates to:
  /// **'Mağaza satın alması henüz açık değil'**
  String get premiumWithMoneySoon;

  /// No description provided for @premiumConfirmTitle.
  ///
  /// In tr, this message translates to:
  /// **'Premium alınsın mı?'**
  String get premiumConfirmTitle;

  /// No description provided for @premiumConfirmDetail.
  ///
  /// In tr, this message translates to:
  /// **'{cost} coin harcanacak.'**
  String premiumConfirmDetail(int cost);

  /// No description provided for @premiumConfirmAction.
  ///
  /// In tr, this message translates to:
  /// **'Al'**
  String get premiumConfirmAction;

  /// No description provided for @premiumRedeemed.
  ///
  /// In tr, this message translates to:
  /// **'Premium hakkın tanımlandı.'**
  String get premiumRedeemed;

  /// No description provided for @premiumActiveTitle.
  ///
  /// In tr, this message translates to:
  /// **'Premium açık'**
  String get premiumActiveTitle;

  /// No description provided for @premiumActiveUnlimited.
  ///
  /// In tr, this message translates to:
  /// **'Süresiz premium hakkın var.'**
  String get premiumActiveUnlimited;

  /// No description provided for @premiumActiveUntil.
  ///
  /// In tr, this message translates to:
  /// **'{date} tarihine kadar geçerli.'**
  String premiumActiveUntil(String date);

  /// No description provided for @premiumCoinHistory.
  ///
  /// In tr, this message translates to:
  /// **'Coin hareketleri'**
  String get premiumCoinHistory;

  /// No description provided for @premiumReasonPhoto.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraf onaylandı'**
  String get premiumReasonPhoto;

  /// No description provided for @premiumReasonRedeem.
  ///
  /// In tr, this message translates to:
  /// **'Premium alındı'**
  String get premiumReasonRedeem;

  /// No description provided for @premiumReasonAdjustment.
  ///
  /// In tr, this message translates to:
  /// **'Düzeltme'**
  String get premiumReasonAdjustment;

  /// No description provided for @profilePremium.
  ///
  /// In tr, this message translates to:
  /// **'Coin ve Premium'**
  String get profilePremium;

  /// No description provided for @profilePremiumDetail.
  ///
  /// In tr, this message translates to:
  /// **'Bakiyen, avantajlar ve premium alma'**
  String get profilePremiumDetail;

  /// No description provided for @mapEnter.
  ///
  /// In tr, this message translates to:
  /// **'Gir'**
  String get mapEnter;

  /// Haritada beğenilen yer varken alt şeridin yazısı.
  ///
  /// In tr, this message translates to:
  /// **'{count, plural, =1{1 yerle plan kur} other{{count} yerle plan kur}}'**
  String mapPlanWithLiked(int count);

  /// No description provided for @commonClose.
  ///
  /// In tr, this message translates to:
  /// **'Kapat'**
  String get commonClose;

  /// No description provided for @navHandoffOpen.
  ///
  /// In tr, this message translates to:
  /// **'Navigasyonda aç'**
  String get navHandoffOpen;

  /// No description provided for @navHandoffTitle.
  ///
  /// In tr, this message translates to:
  /// **'Navigasyonda aç'**
  String get navHandoffTitle;

  /// No description provided for @navHandoffDetail.
  ///
  /// In tr, this message translates to:
  /// **'Rotayı telefonundaki navigasyon uygulamasına gönderiyoruz; yol tarifini oradan alacaksın.'**
  String get navHandoffDetail;

  /// No description provided for @navHandoffNone.
  ///
  /// In tr, this message translates to:
  /// **'Telefonunda desteklenen bir navigasyon uygulaması bulunamadı.'**
  String get navHandoffNone;

  /// No description provided for @navHandoffFailed.
  ///
  /// In tr, this message translates to:
  /// **'Navigasyon uygulaması açılamadı.'**
  String get navHandoffFailed;

  /// Hedef uygulamanın durak sınırı yüzünden aktarılamayan durak sayısı.
  ///
  /// In tr, this message translates to:
  /// **'{count, plural, other{Bu uygulama {count} durağı taşıyamıyor; ilk ve son durak korunur.}}'**
  String navHandoffDropped(int count);

  /// No description provided for @navAppGoogleMaps.
  ///
  /// In tr, this message translates to:
  /// **'Google Haritalar'**
  String get navAppGoogleMaps;

  /// No description provided for @navAppYandexMaps.
  ///
  /// In tr, this message translates to:
  /// **'Yandex Haritalar'**
  String get navAppYandexMaps;

  /// No description provided for @navAppYandexNavi.
  ///
  /// In tr, this message translates to:
  /// **'Yandex Navigasyon'**
  String get navAppYandexNavi;

  /// No description provided for @navAppAppleMaps.
  ///
  /// In tr, this message translates to:
  /// **'Apple Haritalar'**
  String get navAppAppleMaps;

  /// No description provided for @authWallSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Kartları kaydır, gezi planını çıkar. Başlamak için hesabına gir.'**
  String get authWallSubtitle;

  /// No description provided for @authWallFootnote.
  ///
  /// In tr, this message translates to:
  /// **'Planların ve beğendiklerin hesabına bağlanır; telefonunu değiştirsen de kaybolmaz.'**
  String get authWallFootnote;

  /// No description provided for @authPasswordShow.
  ///
  /// In tr, this message translates to:
  /// **'Şifreyi göster'**
  String get authPasswordShow;

  /// No description provided for @authPasswordHide.
  ///
  /// In tr, this message translates to:
  /// **'Şifreyi gizle'**
  String get authPasswordHide;

  /// No description provided for @authRegister.
  ///
  /// In tr, this message translates to:
  /// **'Hesap oluştur'**
  String get authRegister;

  /// No description provided for @authLogin.
  ///
  /// In tr, this message translates to:
  /// **'Giriş yap'**
  String get authLogin;

  /// No description provided for @authSignOut.
  ///
  /// In tr, this message translates to:
  /// **'Çıkış yap'**
  String get authSignOut;

  /// No description provided for @authDeleteAccount.
  ///
  /// In tr, this message translates to:
  /// **'Hesabımı sil'**
  String get authDeleteAccount;

  /// No description provided for @authRegisterDetail.
  ///
  /// In tr, this message translates to:
  /// **'Bu cihazdaki planların ve beğendiklerin hesabına taşınacak.'**
  String get authRegisterDetail;

  /// No description provided for @authLoginDetail.
  ///
  /// In tr, this message translates to:
  /// **'Planlarına başka cihazlardan da ulaş.'**
  String get authLoginDetail;

  /// No description provided for @authEmail.
  ///
  /// In tr, this message translates to:
  /// **'E-posta'**
  String get authEmail;

  /// No description provided for @authPassword.
  ///
  /// In tr, this message translates to:
  /// **'Şifre'**
  String get authPassword;

  /// No description provided for @authPasswordHelper.
  ///
  /// In tr, this message translates to:
  /// **'En az 8 karakter'**
  String get authPasswordHelper;

  /// No description provided for @authEmailRequired.
  ///
  /// In tr, this message translates to:
  /// **'E-posta gerekli'**
  String get authEmailRequired;

  /// No description provided for @authEmailInvalid.
  ///
  /// In tr, this message translates to:
  /// **'Geçerli bir e-posta yaz'**
  String get authEmailInvalid;

  /// No description provided for @authPasswordRequired.
  ///
  /// In tr, this message translates to:
  /// **'Şifre gerekli'**
  String get authPasswordRequired;

  /// No description provided for @authPasswordTooShort.
  ///
  /// In tr, this message translates to:
  /// **'En az 8 karakter olmalı'**
  String get authPasswordTooShort;

  /// No description provided for @authSwitchToLogin.
  ///
  /// In tr, this message translates to:
  /// **'Zaten hesabın var mı? Giriş yap'**
  String get authSwitchToLogin;

  /// No description provided for @authSwitchToRegister.
  ///
  /// In tr, this message translates to:
  /// **'Hesabın yok mu? Oluştur'**
  String get authSwitchToRegister;

  /// No description provided for @authDeleteTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hesabını sil'**
  String get authDeleteTitle;

  /// No description provided for @authDeleteDetail.
  ///
  /// In tr, this message translates to:
  /// **'Hesabın, planların ve kaydırma geçmişin kalıcı olarak silinir. Bu işlem geri alınamaz.'**
  String get authDeleteDetail;

  /// No description provided for @authDeletePasswordLabel.
  ///
  /// In tr, this message translates to:
  /// **'Şifren'**
  String get authDeletePasswordLabel;

  /// No description provided for @authDeleted.
  ///
  /// In tr, this message translates to:
  /// **'Hesabın silindi.'**
  String get authDeleted;

  /// No description provided for @attributionsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kaynaklar ve lisanslar'**
  String get attributionsTitle;

  /// No description provided for @attributionsIntro.
  ///
  /// In tr, this message translates to:
  /// **'Yolla, açık veriyle çalışıyor. Gösterdiğimiz her şeyin bir kaynağı var ve o kaynağı belirtmek zorundayız.'**
  String get attributionsIntro;

  /// No description provided for @attributionsSeen.
  ///
  /// In tr, this message translates to:
  /// **'Bu oturumda kullanılan veriler'**
  String get attributionsSeen;

  /// No description provided for @attributionOsmTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yer verisi — OpenStreetMap'**
  String get attributionOsmTitle;

  /// No description provided for @attributionOsmDetail.
  ///
  /// In tr, this message translates to:
  /// **'Turistik yerlerin konumu, adı ve etiketleri OpenStreetMap katkıcılarından geliyor. ODbL lisansı altında kullanılıyor.'**
  String get attributionOsmDetail;

  /// No description provided for @attributionCommonsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraflar — Wikimedia Commons'**
  String get attributionCommonsTitle;

  /// No description provided for @attributionCommonsDetail.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraflar Wikimedia Commons\'tan alınıyor; büyük bölümü CC BY-SA lisanslı. Her fotoğrafın yanında fotoğrafçı adı ve lisansı gösteriliyor.'**
  String get attributionCommonsDetail;

  /// No description provided for @attributionWikipediaTitle.
  ///
  /// In tr, this message translates to:
  /// **'Açıklamalar — Wikipedia'**
  String get attributionWikipediaTitle;

  /// No description provided for @attributionWikipediaDetail.
  ///
  /// In tr, this message translates to:
  /// **'Yer açıklamaları Wikipedia özetlerinden geliyor, CC BY-SA lisanslı.'**
  String get attributionWikipediaDetail;

  /// No description provided for @attributionOsrmTitle.
  ///
  /// In tr, this message translates to:
  /// **'Rota hesaplama — OSRM'**
  String get attributionOsrmTitle;

  /// No description provided for @attributionOsrmDetail.
  ///
  /// In tr, this message translates to:
  /// **'Yürüme ve sürüş rotaları açık kaynaklı OSRM motoruyla, OpenStreetMap yol ağı üzerinden hesaplanıyor.'**
  String get attributionOsrmDetail;

  /// No description provided for @commonCancel.
  ///
  /// In tr, this message translates to:
  /// **'Vazgeç'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In tr, this message translates to:
  /// **'Kaydet'**
  String get commonSave;

  /// No description provided for @commonCreate.
  ///
  /// In tr, this message translates to:
  /// **'Oluştur'**
  String get commonCreate;

  /// No description provided for @commonDelete.
  ///
  /// In tr, this message translates to:
  /// **'Sil'**
  String get commonDelete;

  /// No description provided for @commonRetry.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar dene'**
  String get commonRetry;

  /// No description provided for @commonBack.
  ///
  /// In tr, this message translates to:
  /// **'Geri'**
  String get commonBack;

  /// No description provided for @commonLoading.
  ///
  /// In tr, this message translates to:
  /// **'Yükleniyor'**
  String get commonLoading;

  /// No description provided for @commonLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Yüklenemedi'**
  String get commonLoadFailed;

  /// No description provided for @commonSomethingWrong.
  ///
  /// In tr, this message translates to:
  /// **'Bir şeyler ters gitti'**
  String get commonSomethingWrong;

  /// No description provided for @durationLessThanMinute.
  ///
  /// In tr, this message translates to:
  /// **'1 dk\'dan az'**
  String get durationLessThanMinute;

  /// No description provided for @durationMinutes.
  ///
  /// In tr, this message translates to:
  /// **'{minutes} dk'**
  String durationMinutes(int minutes);

  /// No description provided for @durationHours.
  ///
  /// In tr, this message translates to:
  /// **'{hours} sa'**
  String durationHours(int hours);

  /// No description provided for @durationHoursMinutes.
  ///
  /// In tr, this message translates to:
  /// **'{hours} sa {minutes} dk'**
  String durationHoursMinutes(int hours, int minutes);

  /// No description provided for @suggestTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yeni yer öner'**
  String get suggestTitle;

  /// No description provided for @suggestIntro.
  ///
  /// In tr, this message translates to:
  /// **'Katalogda olmayan bir yer biliyorsan ekleyelim. Önerin moderatör onayından sonra yayına giriyor.'**
  String get suggestIntro;

  /// Haritada seçilen noktanın koordinatları.
  ///
  /// In tr, this message translates to:
  /// **'Seçilen konum: {latitude}, {longitude}'**
  String suggestLocation(String latitude, String longitude);

  /// No description provided for @suggestNameLabel.
  ///
  /// In tr, this message translates to:
  /// **'Yerin adı'**
  String get suggestNameLabel;

  /// No description provided for @suggestNameHint.
  ///
  /// In tr, this message translates to:
  /// **'Örnek: Kuşcenneti Seyir Terası'**
  String get suggestNameHint;

  /// No description provided for @suggestCategoryLabel.
  ///
  /// In tr, this message translates to:
  /// **'Kategori'**
  String get suggestCategoryLabel;

  /// No description provided for @suggestDescriptionLabel.
  ///
  /// In tr, this message translates to:
  /// **'Kısa tanıtım (isteğe bağlı)'**
  String get suggestDescriptionLabel;

  /// No description provided for @suggestDescriptionHint.
  ///
  /// In tr, this message translates to:
  /// **'Burayı gezmeye değer kılan ne?'**
  String get suggestDescriptionHint;

  /// No description provided for @suggestSend.
  ///
  /// In tr, this message translates to:
  /// **'Öneriyi gönder'**
  String get suggestSend;

  /// No description provided for @suggestSent.
  ///
  /// In tr, this message translates to:
  /// **'Önerin alındı, incelemeye gönderildi.'**
  String get suggestSent;

  /// No description provided for @suggestModerationNote.
  ///
  /// In tr, this message translates to:
  /// **'Öneriler moderatör onayından sonra yayına giriyor. Onaylanan öneri coin kazandırıyor.'**
  String get suggestModerationNote;

  /// No description provided for @suggestStatusPending.
  ///
  /// In tr, this message translates to:
  /// **'İncelemede'**
  String get suggestStatusPending;

  /// No description provided for @suggestStatusApproved.
  ///
  /// In tr, this message translates to:
  /// **'Yayında'**
  String get suggestStatusApproved;

  /// No description provided for @suggestStatusRejected.
  ///
  /// In tr, this message translates to:
  /// **'Reddedildi'**
  String get suggestStatusRejected;

  /// Onaylanan öneri karşılığı yazılan coin.
  ///
  /// In tr, this message translates to:
  /// **'{count} coin kazandın'**
  String suggestCoinsEarned(int count);

  /// No description provided for @suggestOpenPlace.
  ///
  /// In tr, this message translates to:
  /// **'Yeri aç'**
  String get suggestOpenPlace;

  /// No description provided for @mySuggestionsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Önerdiğim yerler'**
  String get mySuggestionsTitle;

  /// No description provided for @mySuggestionsEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henüz yer önermedin'**
  String get mySuggestionsEmptyTitle;

  /// No description provided for @mySuggestionsEmptyDetail.
  ///
  /// In tr, this message translates to:
  /// **'Haritada bir noktayı basılı tutarak katalogda olmayan bir yeri önerebilirsin.'**
  String get mySuggestionsEmptyDetail;

  /// No description provided for @mapSuggestTitle.
  ///
  /// In tr, this message translates to:
  /// **'Burada bir yer mi var?'**
  String get mapSuggestTitle;

  /// No description provided for @mapSuggestDetail.
  ///
  /// In tr, this message translates to:
  /// **'Katalogda olmayan bir yeri bu noktaya önerebilirsin.'**
  String get mapSuggestDetail;

  /// No description provided for @mapSuggestConfirm.
  ///
  /// In tr, this message translates to:
  /// **'Yer öner'**
  String get mapSuggestConfirm;

  /// No description provided for @profileSuggestions.
  ///
  /// In tr, this message translates to:
  /// **'Önerdiğim yerler'**
  String get profileSuggestions;

  /// No description provided for @profileSuggestionsDetail.
  ///
  /// In tr, this message translates to:
  /// **'Gönderdiğin yerler ve durumları'**
  String get profileSuggestionsDetail;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return L10nEn();
    case 'tr':
      return L10nTr();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
