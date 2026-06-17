import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/theme/app_colors.dart';

import 'members_screen.dart';
import 'membership_management_screen.dart';
import 'admin_profiles_screen.dart';
import 'delete_profiles_screen.dart';

import '../../auth/screens/login_screen.dart';
import '../../auth/services/auth_service.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout, color: AppColors.primary),
            onPressed: () async {
              await AuthService().logout();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!.docs.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return data['email'] != 'admin@gmail.com';
          }).toList();

          final totalProfiles = users.length;

          final pendingProfiles = users.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return data['profileStatus'] == 'Pending';
          }).length;

          final approvedProfiles = users.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return data['profileStatus'] == 'Approved';
          }).length;

          final rejectedProfiles = users.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return data['profileStatus'] == 'Rejected';
          }).length;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                children: [

                  // ── HEADER BANNER ──────────────────────────────────────
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryDark],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Image.asset('assets/images/logo.png'),
                          ),
                        ),
                        const SizedBox(width: 18),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome Admin',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Manage profiles, memberships and approvals',
                                style: TextStyle(color: Colors.white70, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── OVERVIEW LABEL ─────────────────────────────────────
                  const Center(
                    child: Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── STAT CARDS GRID ────────────────────────────────────
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 2.2,
                    children: [
                      _statCard(
                        title: 'Total Profiles',
                        value: totalProfiles.toString(),
                        icon: Icons.people,
                      ),
                      _statCard(
                        title: 'Pending',
                        value: pendingProfiles.toString(),
                        icon: Icons.pending_actions,
                      ),
                      _statCard(
                        title: 'Approved',
                        value: approvedProfiles.toString(),
                        icon: Icons.check_circle,
                      ),
                      _statCard(
                        title: 'Rejected',
                        value: rejectedProfiles.toString(),
                        icon: Icons.cancel,
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // ── MANAGEMENT LABEL ───────────────────────────────────
                  const Center(
                    child: Text(
                      'Management',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── MANAGEMENT CARDS ───────────────────────────────────
                  _managementCard(
                    icon: Icons.pending_actions,
                    title: 'Pending Profiles',
                    subtitle: 'Review submitted member profiles',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AdminProfilesScreen()),
                    ),
                  ),

                  _managementCard(
                    icon: Icons.people,
                    title: 'Member Directory',
                    subtitle: 'View all registered members',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MembersScreen()),
                    ),
                  ),

                  _managementCard(
                    icon: Icons.workspace_premium,
                    title: 'Membership Management',
                    subtitle: 'Manage member subscriptions',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MembershipManagementScreen()),
                    ),
                  ),

                  _managementCard(
                    icon: Icons.delete_outline,
                    title: 'Delete Profiles',
                    subtitle: 'Remove unwanted accounts',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const DeleteProfilesScreen()),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: AppColors.primary),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _managementCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: AppColors.ivory,
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.primary),
        onTap: onTap,
      ),
    );
  }
}
