// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class L10nTr extends L10n {
  L10nTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'Yolla';

  @override
  String get appTagline => 'Kaydır, keşfet, yola çık.';

  @override
  String get loading => 'Yükleniyor';

  @override
  String get navDiscover => 'Keşfet';

  @override
  String get navTrips => 'Planlarım';

  @override
  String get navProfile => 'Profil';

  @override
  String get modeCityTitle => 'Şehir gez';

  @override
  String get modeCityDetail =>
      'Bir şehir seç, gezilecek yerleri kart kart gör, beğendiklerin için yürüme rotası çıkar.';

  @override
  String get modeRouteTitle => 'Yola çıkıyorum';

  @override
  String get modeRouteDetail =>
      'Nereden nereye gittiğini söyle, yol üstündeki yerleri sırayla göster.';

  @override
  String get modeLikedTitle => 'Beğendiğim yerler';

  @override
  String get modeLikedDetail =>
      'Daha önce beğendiklerinden seç, onlarla ayrı bir plan kur.';

  @override
  String get cityPickerTitle => 'Nereyi gezeceksin?';

  @override
  String get cityPickerSubtitle =>
      'Şehri seç, kartları kaydırarak planını çıkar.';

  @override
  String get citySearchHint => 'Şehir ara';

  @override
  String get cityNotFoundTitle => 'Şehir bulunamadı';

  @override
  String get cityNotFoundEmpty => 'İçeriği hazır şehir listelenemedi.';

  @override
  String cityNotFoundQuery(String query) {
    return '\"$query\" için sonuç yok.';
  }

  @override
  String get cityNoContent => 'Henüz içerik yok';

  @override
  String cityPlaceCount(int count) {
    return '$count yer';
  }

  @override
  String get citiesLoadFailed => 'Şehirler yüklenemedi';

  @override
  String get deckStampLike => 'PLANA EKLE';

  @override
  String get deckStampPass => 'GEÇ';

  @override
  String get deckStampLater => 'SONRA';

  @override
  String get deckActionUndo => 'Geri al';

  @override
  String get deckActionPass => 'Geç';

  @override
  String get deckActionLater => 'Sonra bakarım';

  @override
  String get deckActionLike => 'Plana ekle';

  @override
  String get deckDetail => 'Ayrıntı';

  @override
  String get deckDetailSemantics => 'Ayrıntıları gör';

  @override
  String get deckAlreadySent => 'Bu kaydırma zaten gönderildi';

  @override
  String get deckUndoFailed => 'Geri alınamadı, bağlantını kontrol et';

  @override
  String get deckFinishedTitle => 'Deste bitti';

  @override
  String deckFinishedDetail(int count) {
    return '$count yer beğendin. Planını oluşturmaya hazırsın.';
  }

  @override
  String get deckEmptyTitle => 'Burada henüz içerik yok';

  @override
  String get deckEmptyDetail =>
      'Bu şehir için gösterilebilecek yer bulunamadı. Başka bir şehir seçebilirsin.';

  @override
  String get deckCreatePlan => 'Planı oluştur';

  @override
  String deckCreateTripPill(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Plan kur · $count',
      one: 'Plan kur · 1',
    );
    return '$_temp0';
  }

  @override
  String deckDetourLabel(String distance) {
    return '$distance sapma';
  }

  @override
  String get corridorTitle => 'Yola çıkıyorum';

  @override
  String get corridorIntro =>
      'Yol boyunca uğrayabileceğin yerleri, geçiş sırasına göre göstereceğiz.';

  @override
  String get corridorFrom => 'Nereden';

  @override
  String get corridorTo => 'Nereye';

  @override
  String get corridorPickCity => 'Şehir seç';

  @override
  String get corridorUseMyLocation => 'Konumumdan başla';

  @override
  String get corridorMyLocation => 'Bulunduğum yer';

  @override
  String get corridorLocationDenied =>
      'Konum izni verilmedi; başlangıç için şehir seçebilirsin.';

  @override
  String get corridorLocationFailed => 'Konumun alınamadı, tekrar dene.';

  @override
  String get corridorSameCity => 'Başlangıç ve varış aynı olamaz.';

  @override
  String get corridorBufferTitle => 'Yoldan sapma payı';

  @override
  String corridorBufferDetail(int km) {
    return 'Ana yoldan en fazla $km km uzaktaki yerler gösterilsin.';
  }

  @override
  String get corridorStart => 'Yol üstünü göster';

  @override
  String get corridorCitiesTitle => 'Hangi şehirlere uğrayalım?';

  @override
  String get corridorCitiesIntro =>
      'Yolun geçtiği şehirler, geçiş sırasına göre. İstemediklerinin işaretini kaldır.';

  @override
  String corridorCitiesPlaces(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count yer',
      one: '1 yer',
    );
    return '$_temp0';
  }

  @override
  String get corridorCitiesSelectAll => 'Hepsini seç';

  @override
  String get corridorCitiesClear => 'Hiçbiri';

  @override
  String corridorCitiesSelected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count şehir seçildi',
      one: '1 şehir seçildi',
      zero: 'Şehir seçilmedi',
    );
    return '$_temp0';
  }

  @override
  String get corridorCitiesEmptyTitle => 'Bu yolda gösterilecek şehir yok';

  @override
  String get corridorCitiesEmptyDetail =>
      'Sapma payını artırmayı dene; koridora daha çok yer girer.';

  @override
  String get corridorCitiesContinue => 'Devam et';

  @override
  String get likedTitle => 'Beğendiklerin';

  @override
  String get likedEmptyTitle => 'Henüz bir yer beğenmedin';

  @override
  String get likedEmptyDetail =>
      'Kartları sağa kaydırdığın yerler burada birikir.';

  @override
  String get likedSelectAtLeastOne => 'En az bir yer seç';

  @override
  String get likedSelectAtLeastTwo => 'Rota için en az iki yer seç';

  @override
  String likedCreateWith(int count) {
    return '$count yerle plan oluştur';
  }

  @override
  String likedRowSemantics(String name, String state) {
    return '$name, $state';
  }

  @override
  String get likedInPlan => 'planda';

  @override
  String get likedNotInPlan => 'planda değil';

  @override
  String get tripNameDialogTitle => 'Plana bir ad ver';

  @override
  String get tripNameHint => 'Plan adı';

  @override
  String get tripDefaultName => 'Gezi planım';

  @override
  String tripCityName(String city) {
    return '$city gezisi';
  }

  @override
  String get tripsTitle => 'Planlarım';

  @override
  String get tripsEmptyTitle => 'Henüz planın yok';

  @override
  String get tripsEmptyDetail =>
      'Bir şehir seçip kartları kaydırmaya başla; beğendiklerinle plan kurabilirsin.';

  @override
  String get tripsEmptyAction => 'Şehir seç';

  @override
  String tripStopCount(int count) {
    return '$count durak';
  }

  @override
  String get tripRouteNotComputed => 'rota hesaplanmadı';

  @override
  String get tripFallbackTitle => 'Plan';

  @override
  String get tripRename => 'Yeniden adlandır';

  @override
  String get tripRenameTitle => 'Planı yeniden adlandır';

  @override
  String get tripDelete => 'Planı sil';

  @override
  String get tripDeleteTitle => 'Plan silinsin mi?';

  @override
  String get tripDeleteDetail => 'Bu işlem geri alınamaz.';

  @override
  String get tripNoStopsTitle => 'Planda durak kalmadı';

  @override
  String get tripNoStopsDetail =>
      'Kart destesine dönüp yeni yerler beğenebilirsin.';

  @override
  String get tripRouteHint =>
      'Rota henüz hesaplanmadı. Duraklar en kısa sıraya dizilecek.';

  @override
  String get tripMetricDistance => 'Mesafe';

  @override
  String get tripMetricTravel => 'Yol süresi';

  @override
  String get tripMetricVisit => 'Gezme';

  @override
  String get tripTooLongOnFoot =>
      'Duraklar birbirinden uzak — yürüyerek uzun sürer, araç önerilir.';

  @override
  String get tripStopsTitle => 'Duraklar';

  @override
  String get tripRemoveStop => 'Plandan çıkar';

  @override
  String get tripNeedTwoStops =>
      'Rota hesaplamak için planda en az iki durak olmalı.';

  @override
  String get tripOptimize => 'Rotayı hesapla';

  @override
  String get tripReoptimize => 'Rotayı yeniden hesapla';

  @override
  String get tripMapNoLocation => 'Gösterilecek konum yok';

  @override
  String get tripMapStopsOnly => 'Duraklar — rota hesaplanmadı';

  @override
  String get placeDirections => 'Yol tarifi al';

  @override
  String get placeWebsite => 'Web sitesi';

  @override
  String get placeWikipedia => 'Wikipedia';

  @override
  String get placeAddress => 'Adres';

  @override
  String get placeOpeningHours => 'Çalışma saatleri';

  @override
  String get placeAverageVisit => 'Ortalama süre';

  @override
  String placeAverageVisitValue(int minutes) {
    return '$minutes dakika';
  }

  @override
  String get placeNearby => 'Yakında';

  @override
  String get placeLinkFailed => 'Bağlantı açılamadı';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileAnonymousTitle => 'Hesapsız kullanıyorsun';

  @override
  String get profileAnonymousDetail =>
      'Planların ve beğendiklerin bu cihazda tutuluyor. Hesap açarsan başka cihazlarda da açabilirsin — uygulamayı silersen kaybolmazlar.';

  @override
  String get profileSignedInTitle => 'Hesabın açık';

  @override
  String get profileSignedInDetail =>
      'Planların hesabına bağlı; başka bir cihazda giriş yaparak aynı yerden devam edebilirsin.';

  @override
  String get profileVersion => 'Sürüm';

  @override
  String get profileSources => 'Kaynaklar ve lisanslar';

  @override
  String get profileSourcesDetail =>
      'OpenStreetMap, Wikimedia Commons, Wikipedia';

  @override
  String get mapPreparing => 'Harita hazırlanıyor';

  @override
  String get mapAttribution => '© OpenStreetMap katkıcıları';

  @override
  String get mapPinNoPhoto => 'Bu yerin fotoğrafı yok';

  @override
  String get mapPinDetail => 'Detayına bak';

  @override
  String get mapPinLike => 'Beğendim';

  @override
  String get mapPinLikedShort => 'Beğenildi';

  @override
  String mapPinLiked(String name) {
    return '$name beğenilenlere eklendi';
  }

  @override
  String get mapPinCreateTrip => 'Plan kur';

  @override
  String get contributePhotoTitle => 'Bu yerin fotoğrafı yok';

  @override
  String get contributePhotoDetail =>
      'Buraya gittiysen bir fotoğraf ekle; onaylandığında yayına girer.';

  @override
  String contributePhotoDetailWithCoins(int coins) {
    return 'Buraya gittiysen bir fotoğraf ekle. Onaylanırsa $coins coin kazanırsın.';
  }

  @override
  String get contributePhotoAction => 'Fotoğraf ekle';

  @override
  String get contributePhotoCamera => 'Kamerayla çek';

  @override
  String get contributePhotoGallery => 'Galeriden seç';

  @override
  String get contributePhotoRules =>
      'Yerin kendisini gösteren, net bir fotoğraf olsun. Başkasının fotoğrafını gönderme.';

  @override
  String get contributePhotoModeration =>
      'Gönderiler yayına girmeden önce elle inceleniyor. Fotoğraftaki konum bilgisi kaldırılır.';

  @override
  String get contributePhotoSent =>
      'Fotoğrafın gönderildi, inceleme sonrası yayına girecek.';

  @override
  String get premiumTitle => 'Coin ve Premium';

  @override
  String premiumCoinBalance(int count) {
    return '$count coin';
  }

  @override
  String premiumCoinHowTo(int coins) {
    return 'Gönderdiğin her fotoğraf onaylandığında $coins coin kazanırsın.';
  }

  @override
  String premiumPendingPhotos(int count) {
    return '$count fotoğrafın inceleniyor';
  }

  @override
  String premiumTripQuota(int left, int limit) {
    return 'Bu ay $left plan hakkın kaldı ($limit üzerinden).';
  }

  @override
  String get premiumBenefitsTitle => 'Premium ne veriyor?';

  @override
  String get premiumBenefitOfflineTitle => 'Çevrimdışı harita ve plan';

  @override
  String get premiumBenefitOfflineDetail =>
      'Şehir haritasını ve planını indir, veri olmadan kullan.';

  @override
  String get premiumBenefitTripsTitle => 'Sınırsız plan';

  @override
  String premiumBenefitTripsDetail(int limit) {
    return 'Ücretsiz hesap ayda $limit plan kaydedebiliyor; premiumda sınır yok.';
  }

  @override
  String get premiumBenefitAdsTitle => 'Reklamsız';

  @override
  String get premiumBenefitAdsDetail => 'Uygulamada reklam gösterilmez.';

  @override
  String get premiumWithCoinsTitle => 'Coinle al';

  @override
  String premiumWithCoinsDetail(int coins) {
    return 'Fotoğraf katkısıyla kazandığın coinleri premium süresine çevir. Onaylanan her fotoğraf $coins coin.';
  }

  @override
  String get premiumOneMonth => '1 ay premium';

  @override
  String get premiumTwoMonths => '2 ay premium';

  @override
  String get premiumUnlimited => 'Süresiz premium';

  @override
  String premiumPackageCost(int cost) {
    return '$cost coin';
  }

  @override
  String premiumPackageShort(int missing) {
    return '$missing coin daha gerekiyor';
  }

  @override
  String get premiumWithMoneyTitle => 'Parayla al';

  @override
  String get premiumWithMoneyDetail =>
      'Coin biriktirmek istemiyorsan doğrudan satın alabileceksin.';

  @override
  String get premiumWithMoneySoon => 'Mağaza satın alması henüz açık değil';

  @override
  String get premiumConfirmTitle => 'Premium alınsın mı?';

  @override
  String premiumConfirmDetail(int cost) {
    return '$cost coin harcanacak.';
  }

  @override
  String get premiumConfirmAction => 'Al';

  @override
  String get premiumRedeemed => 'Premium hakkın tanımlandı.';

  @override
  String get premiumActiveTitle => 'Premium açık';

  @override
  String get premiumActiveUnlimited => 'Süresiz premium hakkın var.';

  @override
  String premiumActiveUntil(String date) {
    return '$date tarihine kadar geçerli.';
  }

  @override
  String get premiumCoinHistory => 'Coin hareketleri';

  @override
  String get premiumReasonPhoto => 'Fotoğraf onaylandı';

  @override
  String get premiumReasonRedeem => 'Premium alındı';

  @override
  String get premiumReasonAdjustment => 'Düzeltme';

  @override
  String get profilePremium => 'Coin ve Premium';

  @override
  String get profilePremiumDetail => 'Bakiyen, avantajlar ve premium alma';

  @override
  String get mapEnter => 'Gir';

  @override
  String mapPlanWithLiked(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count yerle plan kur',
      one: '1 yerle plan kur',
    );
    return '$_temp0';
  }

  @override
  String get commonClose => 'Kapat';

  @override
  String get navHandoffOpen => 'Navigasyonda aç';

  @override
  String get navHandoffTitle => 'Navigasyonda aç';

  @override
  String get navHandoffDetail =>
      'Rotayı telefonundaki navigasyon uygulamasına gönderiyoruz; yol tarifini oradan alacaksın.';

  @override
  String get navHandoffNone =>
      'Telefonunda desteklenen bir navigasyon uygulaması bulunamadı.';

  @override
  String get navHandoffFailed => 'Navigasyon uygulaması açılamadı.';

  @override
  String navHandoffDropped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bu uygulama $count durağı taşıyamıyor; ilk ve son durak korunur.',
    );
    return '$_temp0';
  }

  @override
  String get navAppGoogleMaps => 'Google Haritalar';

  @override
  String get navAppYandexMaps => 'Yandex Haritalar';

  @override
  String get navAppYandexNavi => 'Yandex Navigasyon';

  @override
  String get navAppAppleMaps => 'Apple Haritalar';

  @override
  String get authWallSubtitle =>
      'Kartları kaydır, gezi planını çıkar. Başlamak için hesabına gir.';

  @override
  String get authWallFootnote =>
      'Planların ve beğendiklerin hesabına bağlanır; telefonunu değiştirsen de kaybolmaz.';

  @override
  String get authPasswordShow => 'Şifreyi göster';

  @override
  String get authPasswordHide => 'Şifreyi gizle';

  @override
  String get authRegister => 'Hesap oluştur';

  @override
  String get authLogin => 'Giriş yap';

  @override
  String get authSignOut => 'Çıkış yap';

  @override
  String get authDeleteAccount => 'Hesabımı sil';

  @override
  String get authRegisterDetail =>
      'Bu cihazdaki planların ve beğendiklerin hesabına taşınacak.';

  @override
  String get authLoginDetail => 'Planlarına başka cihazlardan da ulaş.';

  @override
  String get authEmail => 'E-posta';

  @override
  String get authPassword => 'Şifre';

  @override
  String get authPasswordHelper => 'En az 8 karakter';

  @override
  String get authEmailRequired => 'E-posta gerekli';

  @override
  String get authEmailInvalid => 'Geçerli bir e-posta yaz';

  @override
  String get authPasswordRequired => 'Şifre gerekli';

  @override
  String get authPasswordTooShort => 'En az 8 karakter olmalı';

  @override
  String get authSwitchToLogin => 'Zaten hesabın var mı? Giriş yap';

  @override
  String get authSwitchToRegister => 'Hesabın yok mu? Oluştur';

  @override
  String get authDeleteTitle => 'Hesabını sil';

  @override
  String get authDeleteDetail =>
      'Hesabın, planların ve kaydırma geçmişin kalıcı olarak silinir. Bu işlem geri alınamaz.';

  @override
  String get authDeletePasswordLabel => 'Şifren';

  @override
  String get authDeleted => 'Hesabın silindi.';

  @override
  String get attributionsTitle => 'Kaynaklar ve lisanslar';

  @override
  String get attributionsIntro =>
      'Yolla, açık veriyle çalışıyor. Gösterdiğimiz her şeyin bir kaynağı var ve o kaynağı belirtmek zorundayız.';

  @override
  String get attributionsSeen => 'Bu oturumda kullanılan veriler';

  @override
  String get attributionOsmTitle => 'Yer verisi — OpenStreetMap';

  @override
  String get attributionOsmDetail =>
      'Turistik yerlerin konumu, adı ve etiketleri OpenStreetMap katkıcılarından geliyor. ODbL lisansı altında kullanılıyor.';

  @override
  String get attributionCommonsTitle => 'Fotoğraflar — Wikimedia Commons';

  @override
  String get attributionCommonsDetail =>
      'Fotoğraflar Wikimedia Commons\'tan alınıyor; büyük bölümü CC BY-SA lisanslı. Her fotoğrafın yanında fotoğrafçı adı ve lisansı gösteriliyor.';

  @override
  String get attributionWikipediaTitle => 'Açıklamalar — Wikipedia';

  @override
  String get attributionWikipediaDetail =>
      'Yer açıklamaları Wikipedia özetlerinden geliyor, CC BY-SA lisanslı.';

  @override
  String get attributionOsrmTitle => 'Rota hesaplama — OSRM';

  @override
  String get attributionOsrmDetail =>
      'Yürüme ve sürüş rotaları açık kaynaklı OSRM motoruyla, OpenStreetMap yol ağı üzerinden hesaplanıyor.';

  @override
  String get commonCancel => 'Vazgeç';

  @override
  String get commonSave => 'Kaydet';

  @override
  String get commonCreate => 'Oluştur';

  @override
  String get commonDelete => 'Sil';

  @override
  String get commonRetry => 'Tekrar dene';

  @override
  String get commonBack => 'Geri';

  @override
  String get commonLoading => 'Yükleniyor';

  @override
  String get commonLoadFailed => 'Yüklenemedi';

  @override
  String get commonSomethingWrong => 'Bir şeyler ters gitti';

  @override
  String get durationLessThanMinute => '1 dk\'dan az';

  @override
  String durationMinutes(int minutes) {
    return '$minutes dk';
  }

  @override
  String durationHours(int hours) {
    return '$hours sa';
  }

  @override
  String durationHoursMinutes(int hours, int minutes) {
    return '$hours sa $minutes dk';
  }
}
