import 'package:flutter/material.dart';
import 'package:travel_advisor/theme/app_theme.dart';

class SettingsContentScreen extends StatelessWidget {
  final String settingTitle;
  final String settingIcon;

  const SettingsContentScreen({
    super.key,
    required this.settingTitle,
    required this.settingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(settingTitle),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (settingTitle) {
      case 'Account Settings':
        return _buildAccountSettingsContent(context);
      case 'Notification Settings':
        return _buildNotificationSettingsContent(context);
      case 'Privacy Settings':
        return _buildPrivacySettingsContent(context);
      case 'Help & Support':
        return _buildHelpSupportContent(context);
      case 'About':
        return _buildAboutContent(context);
      default:
        return _buildDefaultContent(context);
    }
  }

  Widget _buildAccountSettingsContent(BuildContext context) {
    return ListView(
      children: [
        _buildSection(
          context,
          'Account Information',
          [
            _buildSettingItem(
              context,
              'Change Email',
              Icons.email_outlined,
              () {
                // TODO: Implement change email
              },
            ),
            _buildSettingItem(
              context,
              'Change Password',
              Icons.lock_outline,
              () {
                // TODO: Implement change password
              },
            ),
            _buildSettingItem(
              context,
              'Phone Number',
              Icons.phone_outlined,
              () {
                // TODO: Implement phone number change
              },
            ),
          ],
        ),
        _buildSection(
          context,
          'Privacy & Security',
          [
            _buildSettingItem(
              context,
              'Privacy Settings',
              Icons.privacy_tip_outlined,
              () {
                // TODO: Implement privacy settings
              },
            ),
            _buildSettingItem(
              context,
              'Security Settings',
              Icons.security_outlined,
              () {
                // TODO: Implement security settings
              },
            ),
            _buildSettingItem(
              context,
              'Two-Factor Authentication',
              Icons.verified_user_outlined,
              () {
                // TODO: Implement 2FA
              },
            ),
          ],
        ),
        _buildSection(
          context,
          'Preferences',
          [
            _buildSettingItem(
              context,
              'Notification Settings',
              Icons.notifications_outlined,
              () {
                // TODO: Implement notification settings
              },
            ),
            _buildSettingItem(
              context,
              'Language',
              Icons.language_outlined,
              () {
                // TODO: Implement language settings
              },
            ),
            _buildSettingItem(
              context,
              'Theme',
              Icons.palette_outlined,
              () {
                // TODO: Implement theme settings
              },
            ),
          ],
        ),
        _buildSection(
          context,
          'Account Management',
          [
            _buildSettingItem(
              context,
              'Delete Account',
              Icons.delete_outline,
              () {
                _showDeleteAccountDialog(context);
              },
              isDestructive: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNotificationSettingsContent(BuildContext context) {
    return ListView(
      children: [
        _buildSection(
          context,
          'Push Notifications',
          [
            _buildSwitchItem(
              context,
              'Travel Updates',
              'Get updates about your trips and bookings',
              true,
            ),
            _buildSwitchItem(
              context,
              'Price Alerts',
              'Receive notifications about price changes',
              true,
            ),
            _buildSwitchItem(
              context,
              'Special Offers',
              'Get notified about exclusive deals and discounts',
              false,
            ),
          ],
        ),
        _buildSection(
          context,
          'Email Notifications',
          [
            _buildSwitchItem(
              context,
              'Booking Confirmations',
              'Receive email confirmations for your bookings',
              true,
            ),
            _buildSwitchItem(
              context,
              'Travel Tips',
              'Get helpful travel tips and recommendations',
              true,
            ),
            _buildSwitchItem(
              context,
              'Newsletter',
              'Subscribe to our monthly newsletter',
              false,
            ),
          ],
        ),
        _buildSection(
          context,
          'In-App Notifications',
          [
            _buildSwitchItem(
              context,
              'Chat Messages',
              'Get notified about new messages',
              true,
            ),
            _buildSwitchItem(
              context,
              'Friend Activity',
              'See what your friends are planning',
              true,
            ),
            _buildSwitchItem(
              context,
              'App Updates',
              'Get notified about new features and updates',
              true,
            ),
          ],
        ),
        _buildSection(
          context,
          'Notification Preferences',
          [
            _buildSettingItem(
              context,
              'Sound & Vibration',
              Icons.volume_up_outlined,
              () {
                // TODO: Implement sound settings
              },
            ),
            _buildSettingItem(
              context,
              'Notification Schedule',
              Icons.access_time_outlined,
              () {
                // TODO: Implement notification schedule
              },
            ),
            _buildSettingItem(
              context,
              'Do Not Disturb',
              Icons.notifications_off_outlined,
              () {
                // TODO: Implement DND settings
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPrivacySettingsContent(BuildContext context) {
    return ListView(
      children: [
        _buildSection(
          context,
          'Data & Privacy',
          [
            _buildSwitchItem(
              context,
              'Location Services',
              'Allow app to access your location for better recommendations',
              true,
            ),
            _buildSwitchItem(
              context,
              'Data Collection',
              'Allow anonymous data collection to improve app experience',
              true,
            ),
            _buildSwitchItem(
              context,
              'Personalized Ads',
              'Show personalized advertisements based on your interests',
              false,
            ),
          ],
        ),
        _buildSection(
          context,
          'Profile Visibility',
          [
            _buildSettingItem(
              context,
              'Profile Privacy',
              Icons.visibility_outlined,
              () {
                _showProfilePrivacyDialog(context);
              },
            ),
            _buildSettingItem(
              context,
              'Activity Sharing',
              Icons.share_outlined,
              () {
                _showActivitySharingDialog(context);
              },
            ),
            _buildSettingItem(
              context,
              'Friend Requests',
              Icons.person_add_outlined,
              () {
                _showFriendRequestsDialog(context);
              },
            ),
          ],
        ),
        _buildSection(
          context,
          'Data Management',
          [
            _buildSettingItem(
              context,
              'Download My Data',
              Icons.download_outlined,
              () {
                // TODO: Implement data download
              },
            ),
            _buildSettingItem(
              context,
              'Clear Search History',
              Icons.history_outlined,
              () {
                _showClearHistoryDialog(context);
              },
            ),
            _buildSettingItem(
              context,
              'Delete Account Data',
              Icons.delete_forever_outlined,
              () {
                _showDeleteDataDialog(context);
              },
              isDestructive: true,
            ),
          ],
        ),
        _buildSection(
          context,
          'Legal & Policies',
          [
            _buildSettingItem(
              context,
              'Privacy Policy',
              Icons.description_outlined,
              () {
                // TODO: Show privacy policy
              },
            ),
            _buildSettingItem(
              context,
              'Terms of Service',
              Icons.gavel_outlined,
              () {
                // TODO: Show terms of service
              },
            ),
            _buildSettingItem(
              context,
              'Cookie Policy',
              Icons.cookie_outlined,
              () {
                // TODO: Show cookie policy
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHelpSupportContent(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildContactCard(
          context,
          'Customer Support',
          'support@traveladvisor.com',
          '+1 (555) 123-4567',
          Icons.support_agent_outlined,
        ),
        const SizedBox(height: 16),
        _buildContactCard(
          context,
          'Technical Support',
          'tech@traveladvisor.com',
          '+1 (555) 987-6543',
          Icons.engineering_outlined,
        ),
        const SizedBox(height: 16),
        _buildContactCard(
          context,
          'Emergency Support',
          'emergency@traveladvisor.com',
          '+1 (555) 911-9111',
          Icons.emergency_outlined,
        ),
        const SizedBox(height: 24),
        _buildInfoSection(
          context,
          'Support Hours',
          'Monday - Friday: 9:00 AM - 6:00 PM\nSaturday: 10:00 AM - 4:00 PM\nSunday: Closed',
          Icons.access_time_outlined,
        ),
        const SizedBox(height: 16),
        _buildInfoSection(
          context,
          'Response Time',
          'We aim to respond to all inquiries within 24 hours during business days.',
          Icons.timer_outlined,
        ),
      ],
    );
  }

  Widget _buildAboutContent(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildAppInfoCard(context),
        const SizedBox(height: 16),
        _buildVersionInfoCard(context),
        const SizedBox(height: 16),
        _buildTeamCard(context),
        const SizedBox(height: 16),
        _buildSocialLinksCard(context),
        const SizedBox(height: 16),
        _buildLegalInfoCard(context),
      ],
    );
  }

  Widget _buildAppInfoCard(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/logo.png'),
            ),
            const SizedBox(height: 16),
            Text(
              'Travel Advisor',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your Ultimate Travel Companion',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Travel Advisor helps you discover amazing destinations, plan your trips, and make unforgettable memories. Our mission is to make travel planning easy and enjoyable for everyone.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVersionInfoCard(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Version Information',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              context,
              'App Version',
              '1.0.0',
              Icons.info_outline,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              context,
              'Last Updated',
              'March 2024',
              Icons.update_outlined,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              context,
              'Platform',
              'Android & iOS',
              Icons.devices_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamCard(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Team',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Travel Advisor is developed by a passionate team of travel enthusiasts and technology experts dedicated to making your travel experience better.',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            _buildTeamMember(
              context,
              'John Smith',
              'Lead Developer',
              Icons.code_outlined,
            ),
            _buildTeamMember(
              context,
              'Sarah Johnson',
              'UI/UX Designer',
              Icons.design_services_outlined,
            ),
            _buildTeamMember(
              context,
              'Michael Brown',
              'Travel Expert',
              Icons.travel_explore_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLinksCard(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Connect With Us',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildSocialLink(
              context,
              'Facebook',
              'facebook.com/traveladvisor',
              Icons.facebook,
            ),
            _buildSocialLink(
              context,
              'Twitter',
              'twitter.com/traveladvisor',
              Icons.public,
            ),
            _buildSocialLink(
              context,
              'Instagram',
              'instagram.com/traveladvisor',
              Icons.camera_alt,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalInfoCard(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Legal Information',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildLegalLink(
              context,
              'Terms of Service',
              Icons.gavel_outlined,
            ),
            _buildLegalLink(
              context,
              'Privacy Policy',
              Icons.privacy_tip_outlined,
            ),
            _buildLegalLink(
              context,
              'Cookie Policy',
              Icons.cookie_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey[600],
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const Spacer(),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  Widget _buildTeamMember(
    BuildContext context,
    String name,
    String role,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppTheme.primaryColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                role,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLink(
    BuildContext context,
    String platform,
    String link,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // TODO: Implement social media link opening
        },
        child: Row(
          children: [
            Icon(
              icon,
              color: AppTheme.primaryColor,
              size: 24,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  platform,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  link,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalLink(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // TODO: Implement legal document viewing
        },
        child: Row(
          children: [
            Icon(
              icon,
              color: AppTheme.primaryColor,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    String title,
    String email,
    String phone,
    IconData icon,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildContactInfo(
              context,
              Icons.email_outlined,
              email,
              () {
                // TODO: Implement email action
              },
            ),
            const SizedBox(height: 8),
            _buildContactInfo(
              context,
              Icons.phone_outlined,
              phone,
              () {
                // TODO: Implement phone call action
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(
    BuildContext context,
    IconData icon,
    String text,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey[600],
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(
    BuildContext context,
    String title,
    String content,
    IconData icon,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getIconData(),
            size: 64,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(height: 16),
          Text(
            settingTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Content for $settingTitle will be displayed here',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
          ),
        ),
        ...items,
      ],
    );
  }

  Widget _buildSettingItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : AppTheme.primaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : null,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildSwitchItem(
    BuildContext context,
    String title,
    String subtitle,
    bool value,
  ) {
    return ListTile(
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Switch(
        value: value,
        activeColor: AppTheme.primaryColor,
        onChanged: (bool newValue) {
          // TODO: Implement switch functionality
        },
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement account deletion
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showProfilePrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Profile Privacy'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPrivacyOption(
              context,
              'Public',
              'Anyone can see your profile and activity',
              true,
            ),
            _buildPrivacyOption(
              context,
              'Friends Only',
              'Only your friends can see your profile and activity',
              false,
            ),
            _buildPrivacyOption(
              context,
              'Private',
              'Only you can see your profile and activity',
              false,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement privacy changes
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyOption(
    BuildContext context,
    String title,
    String description,
    bool isSelected,
  ) {
    return RadioListTile(
      title: Text(title),
      subtitle: Text(
        description,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      value: isSelected,
      groupValue: true,
      onChanged: (value) {
        // TODO: Implement privacy option selection
      },
    );
  }

  void _showActivitySharingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Activity Sharing'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSwitchItem(
              context,
              'Share Travel Plans',
              'Allow friends to see your upcoming trips',
              true,
            ),
            _buildSwitchItem(
              context,
              'Share Reviews',
              'Share your destination reviews with friends',
              true,
            ),
            _buildSwitchItem(
              context,
              'Share Photos',
              'Share your travel photos with friends',
              false,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement sharing changes
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showFriendRequestsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Friend Requests'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSwitchItem(
              context,
              'Accept All Requests',
              'Automatically accept friend requests',
              false,
            ),
            _buildSwitchItem(
              context,
              'Show in Feed',
              'Show friend requests in your activity feed',
              true,
            ),
            _buildSwitchItem(
              context,
              'Email Notifications',
              'Get email notifications for friend requests',
              true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement friend request settings
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showClearHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Search History'),
        content: const Text(
          'Are you sure you want to clear your search history? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement history clearing
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account Data'),
        content: const Text(
          'This will permanently delete all your account data. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement data deletion
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  IconData _getIconData() {
    switch (settingIcon) {
      case 'account':
        return Icons.person;
      case 'notifications':
        return Icons.notifications;
      case 'privacy':
        return Icons.lock;
      case 'help':
        return Icons.help;
      case 'about':
        return Icons.info;
      default:
        return Icons.settings;
    }
  }
} 