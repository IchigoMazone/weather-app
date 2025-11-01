
import 'package:flutter/material.dart';
import '../services/theme_service.dart';
import '../services/language_service.dart';
import '../localization/app_localizations.dart';
import 'package:provider/provider.dart';

void showMenuBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      final loc = AppLocalizations.of(context);
      return Consumer2<ThemeService, LanguageService>(
        builder: (context, themeService, langService, child) {
          return Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  loc.translate('settings'),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(loc.translate('theme'), style: const TextStyle(fontSize: 16)),
                    Switch(
                      value: themeService.isDark,
                      onChanged: (_) => themeService.toggleTheme(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(loc.translate('language'), style: const TextStyle(fontSize: 16)),
                    DropdownButton<String>(
                      value: langService.locale.languageCode,
                      items: [
                        DropdownMenuItem(value: 'vi', child: Text(loc.translate('vietnamese'))),
                        DropdownMenuItem(value: 'en', child: Text(loc.translate('english'))),
                      ],
                      onChanged: (value) {
                        if (value != null) langService.changeLanguage(value);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      );
    },
  );
}