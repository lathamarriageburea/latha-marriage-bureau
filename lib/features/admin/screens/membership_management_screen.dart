import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/theme/app_colors.dart';

class MembershipManagementScreen extends StatelessWidget {
  const MembershipManagementScreen({super.key});

  Future<void> updateMembership({
    required String documentId,
    required String status,
    required String plan,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(documentId).update({
      'membershipStatus': status,
      'membershipPlan': plan,
      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> _confirmUpdate({
    required BuildContext context,
    required String documentId,
    required String memberName,
    required String plan,
  }) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Confirm Membership Change'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Member: $memberName'),
              const SizedBox(height: 8),
              Text('Selected Plan: $plan'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    await updateMembership(
      documentId: documentId,
      status: plan == 'Free' ? 'Free' : 'Active',
      plan: plan,
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$plan membership updated successfully')),
      );
    }
  }

  Color _planColor(String plan) {
    switch (plan) {
      case 'Silver':
        return Colors.blueGrey;
      case 'Gold':
        return Colors.amber.shade700;
      case 'Diamond':
        return Colors.blue;
      case 'Platinum':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Widget _planButton({
    required BuildContext context,
    required String documentId,
    required String memberName,
    required String plan,
  }) {
    return OutlinedButton(
      onPressed: () => _confirmUpdate(
        context: context,
        documentId: documentId,
        memberName: memberName,
        plan: plan,
      ),
      style: OutlinedButton.styleFrom(
        shape: const StadiumBorder(),
        side: BorderSide(color: _planColor(plan)),
      ),
      child: Text(
        plan,
        style: TextStyle(color: _planColor(plan), fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Membership Management',
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
        ),
        iconTheme: const IconThemeData(color: AppColors.primary),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(snapshot.error.toString()),
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!.docs.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final email = (data['email'] ?? '').toString().toLowerCase();
            return email != 'lathamarriagebureau@gmail.com';
          }).toList();

          if (users.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.workspace_premium, size: 80, color: AppColors.primary),
                  SizedBox(height: 12),
                  Text(
                    'No Members Found',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [

                  // ── HEADER BANNER ────────────────────────────────────
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryDark],
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Membership Management',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Manage and activate member subscriptions',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── MEMBER CARDS ─────────────────────────────────────
                  ...users.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final memberName = data['fullName'] ?? 'Unknown';
                    final currentPlan = data['membershipPlan'] ?? 'Free';

                    return Card(
                      elevation: 1,
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: const BorderSide(color: AppColors.border),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 26,
                                  backgroundColor: AppColors.ivory,
                                  child: Text(
                                    memberName.toString().isNotEmpty
                                        ? memberName[0].toUpperCase()
                                        : '?',
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        memberName,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Mobile: ${data['mobileNumber'] ?? ''}',
                                        style: const TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        'Profile Status: ${data['profileStatus'] ?? 'Pending'}',
                                        style: const TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 14),

                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                              decoration: BoxDecoration(
                                color: _planColor(currentPlan).withValues(alpha:0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Current Plan: $currentPlan',
                                style: TextStyle(
                                  color: _planColor(currentPlan),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            const Text(
                              'Change Membership',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: ['Free', 'Silver', 'Gold', 'Diamond', 'Platinum']
                                  .map((plan) => _planButton(
                                        context: context,
                                        documentId: doc.id,
                                        memberName: memberName,
                                        plan: plan,
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
