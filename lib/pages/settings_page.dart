import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/constants.dart';
import '../widgets/animated_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = true;
  bool _notifications = true;
  bool _offlineMode = true;
  bool _autoSync = false;
  double _fontSize = 1.0;
  String _selectedTheme = 'Dark';
  String _selectedLanguage = 'English';

  final List<String> _themes = ['Dark', 'Light', 'Rainbow Onboarding'];
  final List<String> _languages = ['English', 'Spanish', 'French', 'German', 'Japanese'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Settings',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppColors.neonCyan,
                ),
              ),
              centerTitle: false,
              pinned: true,
              floating: true,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: AppConstants.paddingPage,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('Appearance'),
                    _buildThemeCard(),
                    const SizedBox(height: AppConstants.spacingXL),
                    _buildSectionHeader('Preferences'),
                    _buildPreferencesCard(),
                    const SizedBox(height: AppConstants.spacingXL),
                    _buildSectionHeader('Offline & Sync'),
                    _buildOfflineCard(),
                    const SizedBox(height: AppConstants.spacingXL),
                    _buildSectionHeader('Accessibility'),
                    _buildAccessibilityCard(),
                    const SizedBox(height: AppConstants.spacingXL),
                    _buildActionButtons(),
                    const SizedBox(height: AppConstants.spacingXXL),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spacingM),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: AppColors.neonCyan,
        ),
      ),
    );
  }

  Widget _buildThemeCard() {
    return Container(
      padding: AppConstants.paddingCard,
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        boxShadow: AppColors.neonGlow(AppColors.neonPurple),
      ),
      child: Column(
        children: [
          _buildSettingRow(
            'Dark Mode',
            'Use dark theme for better battery life',
            Switch(
              value: _darkMode,
              onChanged: (value) => setState(() => _darkMode = value),
              activeThumbColor: AppColors.neonCyan,
              activeTrackColor: AppColors.neonCyan.withValues(alpha:0.3),
            ),
          ),
          const Divider(color: AppColors.surface),
          _buildDropdownRow(
            'Theme',
            'Select app theme',
            _selectedTheme,
            _themes,
            (value) => setState(() => _selectedTheme = value!),
          ),
          const Divider(color: AppColors.surface),
          _buildSettingRow(
            'Rainbow Animations',
            'Enable colorful onboarding animations',
            Switch(
              value: true,
              onChanged: (value) {},
              activeThumbColor: AppColors.neonPink,
              activeTrackColor: AppColors.neonPink.withValues(alpha:0.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesCard() {
    return Container(
      padding: AppConstants.paddingCard,
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        boxShadow: AppColors.neonGlow(AppColors.neonGreen),
      ),
      child: Column(
        children: [
          _buildSettingRow(
            'Push Notifications',
            'Receive alerts and updates',
            Switch(
              value: _notifications,
              onChanged: (value) => setState(() => _notifications = value),
              activeThumbColor: AppColors.neonGreen,
              activeTrackColor: AppColors.neonGreen.withValues(alpha:0.3),
            ),
          ),
          const Divider(color: AppColors.surface),
          _buildDropdownRow(
            'Language',
            'Select app language',
            _selectedLanguage,
            _languages,
            (value) => setState(() => _selectedLanguage = value!),
          ),
          const Divider(color: AppColors.surface),
          _buildSettingRow(
            'Sound Effects',
            'Play sounds for interactions',
            Switch(
              value: true,
              onChanged: (value) {},
              activeThumbColor: AppColors.oliveGold,
              activeTrackColor: AppColors.oliveGold.withValues(alpha:0.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfflineCard() {
    return Container(
      padding: AppConstants.paddingCard,
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        boxShadow: AppColors.neonGlow(AppColors.oliveGold),
      ),
      child: Column(
        children: [
          _buildSettingRow(
            'Offline-First Mode',
            'Store all data locally',
            Switch(
              value: _offlineMode,
              onChanged: (value) => setState(() => _offlineMode = value),
              activeThumbColor: AppColors.oliveGold,
              activeTrackColor: AppColors.oliveGold.withValues(alpha:0.3),
            ),
          ),
          const Divider(color: AppColors.surface),
          _buildSettingRow(
            'Auto Sync',
            'Sync data when online',
            Switch(
              value: _autoSync,
              onChanged: _offlineMode ? (value) => setState(() => _autoSync = value) : null,
              activeThumbColor: AppColors.neonCyan,
              activeTrackColor: AppColors.neonCyan.withValues(alpha:0.3),
            ),
          ),
          const Divider(color: AppColors.surface),
          _buildStorageInfo(),
        ],
      ),
    );
  }

  Widget _buildAccessibilityCard() {
    return Container(
      padding: AppConstants.paddingCard,
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        boxShadow: AppColors.neonGlow(AppColors.neonCyan),
      ),
      child: Column(
        children: [
          _buildSliderRow(
            'Font Size',
            'Adjust text size',
            _fontSize,
            (value) => setState(() => _fontSize = value),
          ),
          const Divider(color: AppColors.surface),
          _buildSettingRow(
            'High Contrast',
            'Increase color contrast',
            Switch(
              value: false,
              onChanged: (value) {},
              activeThumbColor: AppColors.neonPurple,
              activeTrackColor: AppColors.neonPurple.withValues(alpha:0.3),
            ),
          ),
          const Divider(color: AppColors.surface),
          _buildSettingRow(
            'Reduce Motion',
            'Minimize animations',
            Switch(
              value: false,
              onChanged: (value) {},
              activeThumbColor: AppColors.neonGreen,
              activeTrackColor: AppColors.neonGreen.withValues(alpha:0.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingRow(String title, String subtitle, Widget control) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingM),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppConstants.spacingXS),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          control,
        ],
      ),
    );
  }

  Widget _buildDropdownRow(
    String title,
    String subtitle,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingM),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppConstants.spacingXS),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingM),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
              border: Border.all(color: AppColors.neonCyan.withValues(alpha:0.3)),
            ),
            child: DropdownButton<String>(
              value: value,
              onChanged: onChanged,
              dropdownColor: AppColors.cardBackground,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: AppConstants.fontSizeM,
              ),
              underline: const SizedBox(),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: AppColors.neonCyan,
              ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderRow(
    String title,
    String subtitle,
    double value,
    ValueChanged<double> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingM,
                  vertical: AppConstants.spacingXS,
                ),
                decoration: BoxDecoration(
                  color: AppColors.neonCyan.withValues(alpha:0.2),
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                  border: Border.all(color: AppColors.neonCyan),
                ),
                child: Text(
                  '${(value * 100).round()}%',
                  style: const TextStyle(
                    color: AppColors.neonCyan,
                    fontSize: AppConstants.fontSizeS,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingXS),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: AppConstants.spacingM),
          Slider(
            value: value,
            onChanged: onChanged,
            min: 0.5,
            max: 2.0,
            divisions: 15,
            activeColor: AppColors.neonCyan,
            inactiveColor: AppColors.surface,
            thumbColor: AppColors.neonCyan,
          ),
        ],
      ),
    );
  }

  Widget _buildStorageInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Local Storage',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                '2.3 GB / 4.0 GB',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.neonGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingS),
          LinearProgressIndicator(
            value: 2.3 / 4.0,
            backgroundColor: AppColors.surface,
            valueColor: const AlwaysStoppedAnimation(AppColors.neonGreen),
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusS),
          ),
          const SizedBox(height: AppConstants.spacingS),
          Text(
            'AI models, chat history, and workflows stored locally',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        AnimatedButton(
          text: 'Export All Data',
          onPressed: () {},
          type: ButtonType.secondary,
          icon: Icons.backup,
        ),
        const SizedBox(height: AppConstants.spacingM),
        AnimatedButton(
          text: 'Clear Cache',
          onPressed: () => _showClearCacheDialog(),
          type: ButtonType.success,
          icon: Icons.cleaning_services,
        ),
        const SizedBox(height: AppConstants.spacingM),
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.error.withValues(alpha:0.3)),
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          ),
          child: TextButton(
            onPressed: () => _showResetDialog(),
            child: const Text(
              'Reset to Defaults',
              style: TextStyle(
                color: AppColors.error,
                fontSize: AppConstants.fontSizeM,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        ),
        title: const Text(
          'Clear Cache?',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: AppConstants.fontSizeXL,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: const Text(
          'This will remove all temporary files but keep your important data like chats and workflows.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: AppConstants.fontSizeM,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.textTertiary,
                fontSize: AppConstants.fontSizeM,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Clear cache logic here
              },
              child: const Text(
                'Clear Cache',
                style: TextStyle(
                  color: AppColors.backgroundDark,
                  fontSize: AppConstants.fontSizeM,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        ),
        title: const Text(
          'Reset Settings?',
          style: TextStyle(
            color: AppColors.error,
            fontSize: AppConstants.fontSizeXL,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: const Text(
          'This will reset all settings to their default values. This action cannot be undone.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: AppConstants.fontSizeM,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.textTertiary,
                fontSize: AppConstants.fontSizeM,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha:0.8),
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _darkMode = true;
                  _notifications = true;
                  _offlineMode = true;
                  _autoSync = false;
                  _fontSize = 1.0;
                  _selectedTheme = 'Dark';
                  _selectedLanguage = 'English';
                });
              },
              child: const Text(
                'Reset',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppConstants.fontSizeM,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}