import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/session/session_manager.dart';
import '../features/session/session_store.dart';
import 'models/device_session.dart';
import 'network/api_client.dart';
import 'network/api_envelope.dart';

/// Uygulama boyunca görülen lisans atıflarını biriktirir.
final attributionRegistryProvider = Provider<AttributionRegistry>(
  (ref) => AttributionRegistry(),
);

final sessionStoreProvider = Provider<SessionStore>((ref) => SessionStore());

final apiClientProvider = Provider<ApiClient>(
  (ref) => ApiClient(attributions: ref.watch(attributionRegistryProvider)),
);

final sessionManagerProvider = Provider<SessionManager>(
  (ref) => SessionManager(
    store: ref.watch(sessionStoreProvider),
    api: ref.watch(apiClientProvider),
  ),
);

/// Açılışta beklenen tek şey. Bu tamamlanmadan jeton isteyen hiçbir uç
/// çağrılmamalı.
final sessionProvider = FutureProvider<DeviceSession>(
  (ref) => ref.watch(sessionManagerProvider).ensure(),
);
