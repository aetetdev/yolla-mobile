import 'package:flutter/material.dart';

import '../../core/theme/yolla_tokens.dart';
import '../../l10n/app_localizations.dart';

/// Hesap silmeden önce şifre sorar.
///
/// Giriş ve kayıt formu buradan çıkarıldı: hesap zorunlu olduğu için o form
/// artık bir alt sayfa değil, uygulamanın karşılama ekranı — bkz. `AuthPage`.
Future<String?> showPasswordPrompt(BuildContext context) {
  final controller = TextEditingController();
  final l10n = L10n.of(context);

  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.authDeleteTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.authDeleteDetail),
          const SizedBox(height: Space.lg),
          TextField(
            controller: controller,
            obscureText: true,
            autofillHints: const [AutofillHints.password],
            decoration: InputDecoration(
              labelText: l10n.authDeletePasswordLabel,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(controller.text),
          child: Text(l10n.commonDelete),
        ),
      ],
    ),
  );
}
