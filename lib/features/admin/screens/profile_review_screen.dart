import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<void> _showApproveDialog(
    BuildContext context,
  ) async {
    final result =
        await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            'Approve Profile',
          ),
          content: const Text(
            'Are you sure you want to approve this profile?',
          ),
          actions: [
  TextButton(
    onPressed: () {
      Navigator.pop(context, false);
    },
    child: const Text(
      'Cancel',
    ),
  ),

  ElevatedButton(
    onPressed: () {
      Navigator.pop(context, true);
    },
    child: const Text(
      'Approve',
    ),
  ),
],
        );
      },
    );

    if (result == true) {
      await approveProfile();

      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              'Profile Approved Successfully',
            ),
          ),
        );

        Navigator.pop(context);
      }
    }
  }

  Future<void> _showRejectDialog(
    BuildContext context,
  ) async {
    final result =
        await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            'Reject Profile',
          ),
          content: const Text(
            'Are you sure you want to reject this profile?',
          ),
          actions: [
  TextButton(
    onPressed: () {
      Navigator.pop(context, false);
    },
    child: const Text(
      'Cancel',
    ),
  ),

  ElevatedButton(
    onPressed: () {
      Navigator.pop(context, true);
    },
    child: const Text(
      'Reject',
    ),
  ),
],
        );
      },
    );

    if (result == true) {
      await rejectProfile();

      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              'Profile Rejected Successfully',
            ),
          ),
        );

        Navigator.pop(context);
      }
    }
  }

  Widget buildSectionTitle(
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildInfoRow(
    String label,
    dynamic value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value == null ||
                      value
                          .toString()
                          .trim()
                          .isEmpty
                  ? 'Not Provided'
                  : value.toString(),
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
    return Card(
  elevation: 4,

  shape:
      RoundedRectangleBorder(
    borderRadius:
        BorderRadius.circular(
      16,
    ),
  ),
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          16,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
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
    final profileStatus =
        profile['profileStatus'] ??
            'Pending';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Review',
        ),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [

            Container(
  width: double.infinity,
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    gradient: const LinearGradient(
      colors: [
        Color(0xFFD81B60),
        Color(0xFFAD1457),
      ],
    ),
  ),
  child: Column(
    children: [

      CircleAvatar(
  radius: 45,
  backgroundImage:
      profile['photoUrl'] != null &&
              profile['photoUrl']
                  .toString()
                  .isNotEmpty
          ? NetworkImage(
              profile['photoUrl'],
            )
          : null,
  child:
      profile['photoUrl'] == null ||
              profile['photoUrl']
                  .toString()
                  .isEmpty
          ? const Icon(
              Icons.person,
              size: 45,
            )
          : null,
),

      const SizedBox(height: 12),

      Text(
        profile['fullName'] ?? '',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 8),

      Text(
        '${profile['gender'] ?? ''} • ${profile['age'] ?? ''} Years',
        style: const TextStyle(
          color: Colors.white70,
        ),
      ),
    ],
  ),
),

const SizedBox(height: 16),

            Container(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: _statusColor(
                  profileStatus,
                ),
                borderRadius:
                    BorderRadius.circular(
                  20,
                ),
              ),
              child: Text(
                profileStatus,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            buildSectionCard(
              title: 'Personal Details',
              children: [
                buildInfoRow(
                  'Full Name',
                  profile['fullName'],
                ),
                buildInfoRow(
                  'Email',
                  profile['email'],
                ),
                buildInfoRow(
                  'Mobile Number',
                  profile['mobileNumber'],
                ),
                buildInfoRow(
                  'Current Location',
                  profile['currentLocation'],
                ),
                buildInfoRow(
                  'Gender',
                  profile['gender'],
                ),
                buildInfoRow(
                  'Date Of Birth',
                  profile['dateOfBirth'],
                ),
                buildInfoRow(
                  'Age',
                  profile['age'],
                ),
                buildInfoRow(
                  'Height',
                  profile['height'],
                ),
                buildInfoRow(
                  'Religion',
                  profile['religion'],
                ),
                buildInfoRow(
                  'Caste',
                  profile['caste'],
                ),
                buildInfoRow(
                  'Mother Tongue',
                  profile['motherTongue'],
                ),
              ],
            ),

            buildSectionCard(
              title:
                  'Education & Profession',
              children: [
                buildInfoRow(
                  'Qualification',
                  profile[
                      'qualification'],
                ),
                buildInfoRow(
                  'Occupation',
                  profile['occupation'],
                ),
                buildInfoRow(
                  'Annual Income',
                  profile[
                      'annualIncome'],
                ),
              ],
            ),

            buildSectionCard(
              title: 'Family Details',
              children: [
                buildInfoRow(
                  'Father Name',
                  profile['fatherName'],
                ),
                buildInfoRow(
                  'Mother Name',
                  profile['motherName'],
                ),
                buildInfoRow(
                  'Family Type',
                  profile['familyType'],
                ),
                buildInfoRow(
                  'Native Place',
                  profile['nativePlace'],
                ),
                buildInfoRow(
                  'Brothers',
                  profile['brothers'],
                ),
                buildInfoRow(
                  'Sisters',
                  profile['sisters'],
                ),
              ],
            ),

            buildSectionCard(
              title:
                  'Partner Preferences',
              children: [
                buildInfoRow(
                  'Preferred Age',
                  profile[
                      'preferredAge'],
                ),
                buildInfoRow(
                  'Preferred Height',
                  profile[
                      'preferredHeight'],
                ),
                buildInfoRow(
                  'Preferred Education',
                  profile[
                      'preferredEducation'],
                ),
                buildInfoRow(
                  'Preferred Occupation',
                  profile[
                      'preferredOccupation'],
                ),
              ],
            ),

            buildSectionCard(
              title:
                  'Membership Information',
              children: [
                buildInfoRow(
                  'Membership Status',
                  profile[
                      'membershipStatus'],
                ),
                buildInfoRow(
                  'Membership Plan',
                  profile[
                      'membershipPlan'],
                ),
                buildInfoRow(
                  'Profile Status',
                  profile[
                      'profileStatus'],
                ),
              ],
            ),

            const SizedBox(
  height: 20,
),

const Align(
  alignment: Alignment.centerLeft,
  child: Text(
    'Admin Actions',
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
),

const SizedBox(
  height: 12,
),

Row(
  children: [
    Expanded(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
  backgroundColor: Colors.green,
  foregroundColor: Colors.white,
  padding: const EdgeInsets.symmetric(
    vertical: 14,
  ),
),
        icon: const Icon(
          Icons.check,
        ),
        label: const Text(
          'Approve',
        ),
        onPressed: () {
          _showApproveDialog(
            context,
          );
        },
      ),
    ),

    const SizedBox(
      width: 12,
    ),

    Expanded(
  child: ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(
        vertical: 14,
      ),
    ),
    icon: const Icon(
      Icons.close,
    ),
    label: const Text(
      'Reject',
    ),
    onPressed: () {
      _showRejectDialog(
        context,
      );
    },
  ),
),
  ],
),

            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}