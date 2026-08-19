import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_exception.dart';
import '../../core/theme/yolla_tokens.dart';
import '../../core/theme/yolla_typography.dart';
import '../../l10n/app_localizations.dart';
import '../session/auth_state.dart';
import 'account_service.dart';

enum AuthMode { register, login }

/// E-posta + şifre formu.
///
/// Hem karşılama ekranında (tam sayfa) hem de ileride başka bir yerde
/// kullanılabilsin diye ayrı tutuldu; ekranın kendi başlığı ve düzeni
/// dışarıda kalır.
class AuthForm extends ConsumerStatefulWidget {
  const AuthForm({this.initialMode = AuthMode.register, this.onSuccess, super.key});

  final AuthMode initialMode;

  /// Giriş/kayıt başarılı olduğunda çağrılır. Verilmezse yalnızca kimlik
  /// durumu güncellenir ve yönlendirici devreye girer.
  final VoidCallback? onSuccess;

  @override
  ConsumerState<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends ConsumerState<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  /// Klavyedeki "sonraki" düğmesi şifreye geçsin diye.
  final _passwordFocus = FocusNode();

  late AuthMode _mode = widget.initialMode;
  bool _isBusy = false;
  bool _obscure = true;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isBusy = true;
      _error = null;
    });

    try {
      final service = ref.read(accountServiceProvider);
      final email = _email.text.trim();
      final password = _password.text;

      if (_mode == AuthMode.register) {
        await service.register(email: email, password: password);
      } else {
        await service.login(email: email, password: password);
      }

      // Jetonu servis zaten oturum yöneticisine devretti; kapıyı burada açıyoruz.
      ref.read(authControllerProvider.notifier).markSignedIn();
      widget.onSuccess?.call();
    } on ApiException catch (error) {
      setState(() {
        // Sunucu, e-postanın kayıtlı olup olmadığını bilerek belli etmiyor;
        // mesajı olduğu gibi göstermek doğru davranış.
        _error =
            error.fieldErrors.values.firstOrNull?.firstOrNull ?? error.message;
      });
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = L10n.of(context);
    final isRegister = _mode == AuthMode.register;

    return Form(
      key: _formKey,
      child: AutofillGroup(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              textInputAction: TextInputAction.next,
              enabled: !_isBusy,
              onFieldSubmitted: (_) => _passwordFocus.requestFocus(),
              decoration: InputDecoration(
                labelText: l10n.authEmail,
                prefixIcon: const Icon(Icons.alternate_email, size: 20),
              ),
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isEmpty) return l10n.authEmailRequired;
                if (!text.contains('@') || !text.contains('.')) {
                  return l10n.authEmailInvalid;
                }
                return null;
              },
            ),
            const SizedBox(height: Space.md),
            TextFormField(
              controller: _password,
              focusNode: _passwordFocus,
              obscureText: _obscure,
              autofillHints: [
                isRegister
                    ? AutofillHints.newPassword
                    : AutofillHints.password,
              ],
              textInputAction: TextInputAction.done,
              enabled: !_isBusy,
              onFieldSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                labelText: l10n.authPassword,
                prefixIcon: const Icon(Icons.lock_outline, size: 20),
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _obscure = !_obscure),
                  icon: Icon(
                    _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    size: 20,
                  ),
                  tooltip: _obscure
                      ? l10n.authPasswordShow
                      : l10n.authPasswordHide,
                ),
                // Sunucu NIST yaklaşımını izliyor: karmaşıklık şartı yok,
                // en az 8 karakter.
                helperText: isRegister ? l10n.authPasswordHelper : null,
              ),
              validator: (value) {
                final text = value ?? '';
                if (text.isEmpty) return l10n.authPasswordRequired;
                if (isRegister && text.length < 8) {
                  return l10n.authPasswordTooShort;
                }
                return null;
              },
            ),
            if (_error case final message?) ...[
              const SizedBox(height: Space.md),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 16,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(width: Space.sm),
                  Expanded(
                    child: Text(
                      message,
                      style: YollaText.caption.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: Space.xl),
            FilledButton(
              onPressed: _isBusy ? null : _submit,
              child: _isBusy
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(isRegister ? l10n.authRegister : l10n.authLogin),
            ),
            const SizedBox(height: Space.sm),
            TextButton(
              onPressed: _isBusy
                  ? null
                  : () => setState(() {
                      _mode = isRegister ? AuthMode.login : AuthMode.register;
                      _error = null;
                    }),
              child: Text(
                isRegister ? l10n.authSwitchToLogin : l10n.authSwitchToRegister,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
