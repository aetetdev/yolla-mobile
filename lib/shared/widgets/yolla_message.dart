import 'package:flutter/material.dart';

import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';

/// Boş durum, hata ve bitiş ekranlarının ortak biçimi.
///
/// Tek bir bileşen olması, "içerik yok" ile "bağlantı yok" durumlarının
/// ekranlar arasında farklı görünmesini engelliyor.
class YollaMessage extends StatelessWidget {
  const YollaMessage({
    required this.icon,
    required this.title,
    this.detail,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final IconData icon;
  final String title;
  final String? detail;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 340),
        child: Padding(
          padding: const EdgeInsets.all(Space.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 44, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(height: Space.lg),
              Text(title, style: YollaText.subtitle, textAlign: TextAlign.center),
              if (detail case final text?) ...[
                const SizedBox(height: Space.sm),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: YollaText.body.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              if (actionLabel case final label? when onAction != null) ...[
                const SizedBox(height: Space.xl),
                FilledButton(onPressed: onAction, child: Text(label)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
