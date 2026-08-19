/// Başarılı yanıtların ortak zarfı.
///
/// ```json
/// { "data": { }, "attributions": ["© OpenStreetMap katkıcıları", ...] }
/// ```
class ApiEnvelope<T> {
  const ApiEnvelope({required this.data, this.attributions = const []});

  final T data;

  /// Lisans atıfları. **Ekranda gösterilmesi hukuki zorunluluk** — OSM verisi
  /// ODbL, Commons fotoğrafları çoğunlukla CC BY-SA.
  final List<String> attributions;
}

/// Görülen bütün atıfları biriktirir.
///
/// Atıf her yanıtta geliyor ama her ekranda ayrı ayrı taşımak yerine tek
/// noktada toplanıp uygulamanın atıf bölümünde gösterilir. Kart üzerindeki
/// `photoAttribution` bundan ayrıdır ve fotoğrafın yanında durmak zorundadır.
class AttributionRegistry {
  final _seen = <String>{};

  /// Eklenen yeni atıf oldu mu?
  bool record(Iterable<String> attributions) {
    final before = _seen.length;
    _seen.addAll(attributions);
    return _seen.length != before;
  }

  List<String> get all => List.unmodifiable(_seen);
}
