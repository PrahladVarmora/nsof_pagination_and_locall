import 'package:nstack_softech_practical/modules/core/common/widgets/app_localizations.dart';
import 'package:nstack_softech_practical/modules/core/utils/common_import.dart';

/// This extension is use for Email Validator feature
extension Translator on String {
  String translate() {
    try {
      return AppLocalizations.of(getNavigatorKeyContext())!.translate(this) ??
          this;
    } catch (e) {
      return '-';
    }
  }
}
