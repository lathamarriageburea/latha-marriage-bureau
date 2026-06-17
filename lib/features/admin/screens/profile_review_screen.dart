import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/theme/app_colors.dart';

class ProfileReviewScreen extends StatelessWidget {
  final String documentId;
  final Map<String, dynamic> profile;

  const ProfileReviewScreen({
    super.key,
    required this.documentId,
    required this.profile,
  });

  Future<void> approveProfile() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .update({
      'profileStatus': 'Approved',
      'isApproved': true,
      'profileVisible': true,
      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> rejectProfile() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .update({
      'profileStatus': 'Rejected',
      'isApproved': false,
      'profileVisible': false,
      'updatedAt': Timestamp.now(),
    });
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  Future<void> _showApproveDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Approve Profile'),
          content: const Text('Are you sure you want to approve this profile?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Approve'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      await approveProfile();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile Approved Successfully')),
        );
        Navigator.pop(context);
      }
    }
  }

  Future<void> _showRejectDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Reject Profile'),
          content: const Text('Are you sure you want to reject this profile?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Reject'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      await rejectProfile();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile Rejected Successfully')),
        );
        Navigator.pop(context);
      }
    }
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value == null || value.toString().trim().isEmpty
                  ? 'Not Provided'
                  : value.toString(),
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle(title),
            ...children,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileStatus = profile['profileStatus'] ?? 'Pending';

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile Review',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.primary),
      ),

      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
            child: Column(
              children: [

                // ── PROFILE HEADER BANNER ────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryDark],
                    ),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.white24,
                        backgroundImage: profile['photoUrl'] != null &&
                                profile['photoUrl'].toString().isNotEmpty
                            ? NetworkImage(profile['photoUrl'])
                            : null,
                        child: profile['photoUrl'] == null ||
                                profile['photoUrl'].toString().isEmpty
                            ? const Icon(Icons.person, size: 45, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        profile['fullName'] ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${profile['gender'] ?? ''} • ${profile['age'] ?? ''} Years',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // ── STATUS BADGE ─────────────────────────────────────
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 9),
                  decoration: BoxDecoration(
                    color: _statusColor(profileStatus),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    profileStatus,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ── SECTION CARDS ─────────────────────────────────────
                buildSectionCard(
                  title: 'Personal Details',
                  children: [
                    buildInfoRow('Full Name', profile['fullName']),
                    buildInfoRow('Email', profile['email']),
                    buildInfoRow('Mobile Number', profile['mobileNumber']),
                    buildInfoRow('Current Location', profile['currentLocation']),
                    buildInfoRow('Gender', profile['gender']),
                    buildInfoRow('Date Of Birth', profile['dateOfBirth']),
                    buildInfoRow('Age', profile['age']),
                    buildInfoRow('Height', profile['height']),
                    buildInfoRow('Religion', profile['religion']),
                    buildInfoRow('Caste', profile['caste']),
                    buildInfoRow('Mother Tongue', profile['motherTongue']),
                  ],
                ),

                buildSectionCard(
                  title: 'Education & Profession',
                  children: [
                    buildInfoRow('Qualification', profile['qualification']),
                    buildInfoRow('Occupation', profile['occupation']),
                    buildInfoRow('Annual Income', profile['annualIncome']),
                  ],
                ),

                buildSectionCard(
                  title: 'Family Details',
                  children: [
                    buildInfoRow('Father Name', profile['fatherName']),
                    buildInfoRow('Mother Name', profile['motherName']),
                    buildInfoRow('Family Type', profile['familyType']),
                    buildInfoRow('Native Place', profile['nativePlace']),
                    buildInfoRow('Brothers', profile['brothers']),
                    buildInfoRow('Sisters', profile['sisters']),
                  ],
                ),

                buildSectionCard(
                  title: 'Partner Preferences',
                  children: [
                    buildInfoRow('Preferred Age', profile['preferredAge']),
                    buildInfoRow('Preferred Height', profile['preferredHeight']),
                    buildInfoRow('Preferred Education', profile['preferredEducation']),
                    buildInfoRow('Preferred Occupation', profile['preferredOccupation']),
                  ],
                ),

                buildSectionCard(
                  title: 'Membership Information',
                  children: [
                    buildInfoRow('Membership Status', profile['membershipStatus']),
                    buildInfoRow('Membership Plan', profile['membershipPlan']),
                    buildInfoRow('Profile Status', profile['profileStatus']),
                  ],
                ),

                // ── ADMIN ACTIONS ─────────────────────────────────────
                const SizedBox(height: 6),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Admin Actions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.check),
                        label: const Text(
                          'Approve',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => _showApproveDialog(context),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.close),
                        label: const Text(
                          'Reject',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => _showRejectDialog(context),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
