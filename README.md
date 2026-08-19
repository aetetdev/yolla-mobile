# Yolla — Mobil

Swipe kartlarıyla turistik yer keşfi ve gezi rotası uygulamasının mobil istemcisi.

Backend ayrı bir depoda (`TourAppBackend` / `yolla-backend`). Sözleşme:
[`docs/api-rehberi.md`](../TourAppBackend/docs/api-rehberi.md).

---

## Kurulum

Gereksinimler: Flutter 3.44+, Android SDK.

```bash
flutter pub get
dart run build_runner build
```

## Çalıştırma

Backend'in ayakta olması gerekir:

```bash
dotnet run --project ../TourAppBackend/src/Yolla.Api
```

Sonra:

```bash
flutter run
```

API adresi platforma göre otomatik seçilir — Android öykünücüsü ana makineye
`localhost` ile ulaşamadığı için `10.0.2.2` kullanılır ([`lib/app/env.dart`](lib/app/env.dart)).
Başka bir adres için:

```bash
flutter run --dart-define=YOLLA_API_BASE_URL=https://api.yolla.app/api/v1
```

### Web önizlemesi

Web hedefi yalnızca geliştirme önizlemesi içindir — ürünün web tarafı ayrı bir
Next.js uygulaması olacak. Tarayıcıdan denemek için backend'in CORS listesine
önizleme adresi eklenmelidir:

```bash
flutter run -d chrome --web-port=5173
```

Backend tarafında (dosyaya dokunmadan, ortam değişkeniyle):
`Cors__AllowedOrigins__0=http://localhost:5173`

---

## Mimari

Özellik odaklı klasörleme:

```
lib/
├── app/            router, tema kökü, ortam ayarları
├── core/
│   ├── media/      Commons görsel adresi yardımcıları
│   ├── models/     sözleşme modelleri (freezed)
│   ├── network/    dio istemcisi, zarf, hata eşlemesi
│   └── theme/      renk, tipografi, aralık token'ları
├── features/
│   ├── session/    cihaz oturumu (hesapsız kullanım)
│   ├── geo/        şehir seçimi
│   └── discovery/  kart destesi  ← ürünün kalbi
└── shared/         ortak bileşenler
```

Durum yönetimi **Riverpod** (kod üretimsiz — `riverpod_generator` bu sürümde
`flutter_riverpod` 3.4 ile çakışıyor, manuel provider'lar kullanılıyor).
Modeller **freezed** ile üretiliyor.

Üç sekme `StatefulShellRoute` ile ayrı gezinme yığınları olarak tutuluyor;
yer detayı, beğenilenler ve atıflar sekmelerin üstüne açılıyor.

### Arayüz dili

TR/EN, `lib/l10n/*.arb`. Metin eklerken önce `app_tr.arb` ve `app_en.arb`
güncellenir, sonra `flutter gen-l10n` çalıştırılır. Ekranlarda sabit metin
bırakılmaz. İstemci ayrıca `Accept-Language` gönderiyor, sunucu içeriği de
dile göre dönebiliyor.

---

## Kayda değer kararlar

### Fotoğraflar küçültülerek isteniyor

Backend `photoUrl` alanında Wikimedia Commons **orijinalini** veriyor; ölçülen
ortalama ~1 MB. Deste 3-5 kartı önden yüklediği için bu haliyle mobil veride
kullanılamazdı.

[`CommonsPhoto`](lib/core/media/commons_photo.dart) adresi Commons'ın
küçültülmüş sürümüne çeviriyor. **Genişlik keyfi seçilemez:** Wikimedia
doğrudan bağlantıda standart dışı boyutları `400 Bad Request` ile reddediyor
(izin verilen liste: 20, 40, 60, 120, 250, 330, 500, 960, 1280, 1920, 3840).
Ölçüm: 652 KB orijinal → 131 KB (500px) / 385 KB (960px).

Bu mantığın kalıcı yeri backend DTO'su. Sunucu hazır bir `photoThumbUrl`
döndürürse hem istemci bu işi taşımaz hem de web istemcisi aynı kodu yeniden
yazmaz.

Görsel istekleri [`PlacePhoto`](lib/shared/widgets/place_photo.dart) üzerinden
geçer; tanımlayıcı bir `User-Agent` gönderir. Commons'ın kullanım politikası
bunu şart koşuyor — başlıksız isteklerde bazı görseller yüklenmiyordu.
Yayına çıkmadan önce `Env.imageUserAgent` içine gerçek iletişim adresi konmalı.

### Kaydırmalar biriktirilerek gönderiliyor

Her kaydırma için istek atmak hız sınırını (dakikada 120) yakar ve çevrimdışıyken
kaybolur. [`DeckController`](lib/features/discovery/deck_controller.dart) yerelde
biriktirip 10 kaydırmada bir ya da 4 saniyelik duraklamada toplu gönderiyor;
uygulama arka plana alınırken de boşaltılıyor. Gönderim başarısız olursa kayıtlar
kuyrukta kalıyor.

Geri alma bu tasarımın yan ürünü: kaydırma henüz gönderilmediyse kart desteye
geri konabiliyor. Gönderildikten sonra sunucuda geri alma ucu olmadığı için
işlem reddediliyor ve kullanıcıya söyleniyor.

### Atıf silinemez

OSM verisi ODbL, Commons fotoğrafları çoğunlukla CC BY-SA. `photoAttribution`
her kartın üzerinde, `attributions` listesi uygulama genelinde gösterilmek
zorunda — tasarım tercihi değil, hukuki yükümlülük.

---

## Testler

```bash
flutter test
```

---

### Rota çiziliyor, altlık harita yok

[`TripMap`](lib/features/trips/widgets/trip_map.dart) sunucudan gelen kodlanmış
polyline'ı çözüp ([`Polyline`](lib/core/geo/polyline.dart)) rotayı ve durakları
ölçekleyerek çiziyor. Altlık harita **bilerek yok**: vektör karo kaynağı
(Protomaps self-host ya da MapTiler anahtarı) seçilmedi ve uydurulamaz.

Karar verilince yerine `maplibre_gl` gelecek. O zaman
"© OpenStreetMap katkıcıları" atıfının haritanın üstünde görünmesi zorunlu.

### Atıfsız fotoğraf gösterilmiyor

Sunucu `nearby` listesinde ve plan listesinin kapak görselinde fotoğraf adresi
veriyor ama `photoAttribution` vermiyor. Commons görsellerinin çoğu CC BY-SA
olduğu için o fotoğraflar gösterilemiyor; bu listeler metin olarak çiziliyor.
Sunucu alanı eklerse görselli tasarıma geçilir.

---

## Henüz yapılmadı

- **Altlık harita** — vektör karo kaynağı kararı bekleniyor (yukarıya bakın)
- **Çevrimdışı şehir paketleri (Drift)** — Pro özelliği; karo önbelleği
  gerektirdiği için harita kararına bağlı
- Çok günlük plan bölme (`dayIndex` alanı taşınıyor, bölme mantığı sunucuda yok)
- Plan paylaşma / GPX dışa aktarma
