
import 'package:flutter/material.dart';
import '../services/theme_service.dart';
import '../services/language_service.dart';
import '../localization/app_localizations.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('settings')),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    loc.translate('theme'),
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Switch(
                  value: context.watch<ThemeService>().isDark,
                  onChanged: (_) => context.read<ThemeService>().toggleTheme(),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Language
            Text(loc.translate('language'), style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: context.watch<LanguageService>().locale.languageCode,
              isExpanded: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              items: [
                DropdownMenuItem(value: 'vi', child: Text(loc.translate('vietnamese'))),
                DropdownMenuItem(value: 'en', child: Text(loc.translate('english'))),
              ],
              onChanged: (value) {
                if (value != null) {
                  context.read<LanguageService>().changeLanguage(value);
                }
              },
            ),
            const SizedBox(height: 40),
            Text(
              'Theme & language applied to the entire app!',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}