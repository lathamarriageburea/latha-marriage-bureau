import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../auth/screens/login_screen.dart';
import '../../auth/services/auth_service.dart';
import '../../profile/screens/browse_profiles_screen.dart';

class UserDashboardScreen extends StatelessWidget {
  const UserDashboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user =
        FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            'User not logged in',
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor:
          const Color(0xFFFFF8F3),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFFFFF8F3),

        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF2D2D2D),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Member Dashboard',
          style: TextStyle(
            color: Color(0xFF2D2D2D),
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(
              Icons.logout_rounded,
              color: Color(0xFF8B002E),
            ),
            onPressed: () async {
              await AuthService().logout();

              if (!context.mounted) return;

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const LoginScreen(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),

      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore
            .instance
            .collection('users')
            .doc(user.uid)
            .snapshots(),

        builder: (
          context,
          snapshot,
        ) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          if (!snapshot.hasData ||
              !snapshot.data!.exists) {
            return const Center(
              child: Text(
                'Profile not found',
              ),
            );
          }

          final data =
              snapshot.data!.data()
                  as Map<String, dynamic>;

          final fullName =
              data['fullName'] ?? '';

          final email =
              data['email'] ??
                  user.email ??
                  '';

          final mobileNumber =
              data['mobileNumber'] ?? '';

          final location =
              data['currentLocation'] ?? '';

          final profileStatus =
              data['profileStatus'] ??
                  'Pending';

          final membershipStatus =
              data['membershipStatus'] ??
                  'Free';

          final membershipPlan =
              data['membershipPlan'] ??
                  'Free';

          return Center(
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(
                maxWidth: 900,
              ),

              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.all(
                  24,
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .center,

                  children: [

                    /// PAGE TITLE
                    const Center(
  child: Text(
    'Welcome Back',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Color(0xFF8B002E),
    ),
  ),
),

                    const SizedBox(
                      height: 8,
                    ),

                    const Center(
  child: Text(
    'Manage your profile, membership and matches',
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Color(0xFF6B6B6B),
    ),
  ),
),

                    const SizedBox(
                      height: 24,
                    ),

                    /// PROFILE SUMMARY CARD
                    Container(
                      width:
                          double.infinity,

                      padding:
                          const EdgeInsets
                              .all(
                        24,
                      ),

                      decoration:
                          BoxDecoration(
                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius
                                .circular(
                          24,
                        ),

                        border:
                            Border.all(
                          color:
                              const Color(
                            0xFFE7DCCF,
                          ),
                        ),

                        boxShadow: const [
                          BoxShadow(
                            blurRadius:
                                10,
                            color:
                                Color(
                              0x12000000,
                            ),
                            offset:
                                Offset(
                              0,
                              4,
                            ),
                          ),
                        ],
                      ),

                      child: Column(
                        children: [

                          Container(
                            height: 100,
                            width: 100,

                            decoration:
                                BoxDecoration(
                              shape: BoxShape
                                  .circle,

                              border:
                                  Border.all(
                                color:
                                    const Color(
                                  0xFFD4A24C,
                                ),
                                width: 2,
                              ),
                            ),

                            child:
                                ClipOval(
                              child:
                                  Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit
                                    .cover,
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 16,
                          ),

                          Text(
                            fullName,
                            textAlign:
                                TextAlign
                                    .center,
                            style:
                                const TextStyle(
                              fontSize:
                                  28,
                              fontWeight:
                                  FontWeight
                                      .bold,
                              color:
                                  Color(
                                0xFF8B002E,
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          Text(
                            email,
                            textAlign:
                                TextAlign
                                    .center,
                          ),

                          const SizedBox(
                            height: 4,
                          ),

                          Text(
                            mobileNumber,
                            textAlign:
                                TextAlign
                                    .center,
                          ),

                          const SizedBox(
                            height: 4,
                          ),

                          Text(
                            location,
                            textAlign:
                                TextAlign
                                    .center,
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            alignment:
                                WrapAlignment
                                    .center,

                            children: [

                              _buildBadge(
                                Icons
                                    .verified_user,
                                profileStatus,
                              ),

                              _buildBadge(
                                Icons
                                    .workspace_premium,
                                membershipPlan,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    /// STATUS GRID
                    LayoutBuilder(
                      builder: (
                        context,
                        constraints,
                      ) {
                        final isMobile =
                            constraints.maxWidth < 700;
                                                    return Column(
                          children: [

                            if (isMobile) ...[

  Row(
    children: [

      Expanded(
        child: _buildStatusCard(
          title: 'Profile Status',
          value: profileStatus,
          icon: Icons.verified_user,
        ),
      ),

      const SizedBox(width: 12),

      Expanded(
        child: _buildStatusCard(
          title: 'Membership',
          value: membershipStatus,
          icon: Icons.workspace_premium,
        ),
      ),
    ],
  ),

  const SizedBox(height: 12),

  Row(
    children: [

      Expanded(
        child: _buildStatusCard(
          title: 'Plan',
          value: membershipPlan,
          icon: Icons.card_membership,
        ),
      ),

      const SizedBox(width: 12),

      Expanded(
        child: _buildStatusCard(
          title: 'Location',
          value: location.isEmpty ? 'N/A' : location,
          icon: Icons.location_on,
        ),
      ),
    ],
  ),

] else ...[

                              Row(
                                children: [

                                  Expanded(
                                    child:
                                        _buildStatusCard(
                                      title:
                                          'Profile Status',
                                      value:
                                          profileStatus,
                                      icon:
                                          Icons.verified_user,
                                    ),
                                  ),

                                  const SizedBox(
                                    width:
                                        16,
                                  ),

                                  Expanded(
                                    child:
                                        _buildStatusCard(
                                      title:
                                          'Membership',
                                      value:
                                          membershipStatus,
                                      icon:
                                          Icons.workspace_premium,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height:
                                    16,
                              ),

                              Row(
                                children: [

                                  Expanded(
                                    child:
                                        _buildStatusCard(
                                      title:
                                          'Plan',
                                      value:
                                          membershipPlan,
                                      icon:
                                          Icons.card_membership,
                                    ),
                                  ),

                                  const SizedBox(
                                    width:
                                        16,
                                  ),

                                  Expanded(
                                    child:
                                        _buildStatusCard(
                                      title:
                                          'Location',
                                      value:
                                          location.isEmpty
                                              ? 'N/A'
                                              : location,
                                      icon:
                                          Icons.location_on,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        );
                      },
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    if (profileStatus !=
                        'Approved')
                      Container(
                        width:
                            double.infinity,

                        padding:
                            const EdgeInsets
                                .all(
                          20,
                        ),

                        decoration:
                            BoxDecoration(
                          color:
                              const Color(
                            0xFFFFF3E0,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            20,
                          ),

                          border:
                              Border.all(
                            color:
                                Colors.orange,
                          ),
                        ),

                        child: const Row(
                          children: [

                            Icon(
                              Icons.info,
                              color:
                                  Colors.orange,
                            ),

                            SizedBox(
                              width: 12,
                            ),

                            Expanded(
                              child: Text(
                                'Your profile is under review. You can browse profiles once approved.',
                              ),
                            ),
                          ],
                        ),
                      ),

                    if (profileStatus !=
                        'Approved')
                      const SizedBox(
                        height: 24,
                      ),

                    /// MEMBERSHIP SECTION

                    Container(
                      width:
                          double.infinity,

                      padding:
                          const EdgeInsets
                              .all(
                        24,
                      ),

                      decoration:
                          BoxDecoration(
                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius
                                .circular(
                          24,
                        ),

                        border:
                            Border.all(
                          color:
                              const Color(
                            0xFFE7DCCF,
                          ),
                        ),
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .center,

                        children: [

                          const Center(
  child: Text(
    'Membership',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Color(0xFF8B002E),
    ),
  ),
),

                          const SizedBox(
                            height: 8,
                          ),

                          Center(
  child: Text(
    'Current Plan: $membershipPlan',
    textAlign: TextAlign.center,
    style: const TextStyle(
      fontSize: 16,
    ),
  ),
),

                          const SizedBox(
                            height: 20,
                          ),

                          SizedBox(
                            width:
                                220,
                            height:
                                50,

                            child:
                                ElevatedButton.icon(
                              onPressed:
                                  () {
                                _showMembershipDialog(
                                  context,
                                );
                              },

                              icon:
                                  const Icon(
                                Icons
                                    .workspace_premium,
                              ),

                              label:
                                  const Text(
                                'View Plans',
                              ),

                              style:
                                  ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(
                                  0xFF8B002E,
                                ),

                                foregroundColor:
                                    Colors
                                        .white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),
                                        /// BROWSE PROFILES

                    Container(
                      width:
                          double.infinity,

                      padding:
                          const EdgeInsets
                              .all(
                        24,
                      ),

                      decoration:
                          BoxDecoration(
                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius
                                .circular(
                          24,
                        ),

                        border:
                            Border.all(
                          color:
                              const Color(
                            0xFFE7DCCF,
                          ),
                        ),
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .center,

                        children: [

                          const Center(
  child: Text(
    'Find Your Match',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Color(0xFF8B002E),
    ),
  ),
),

                          const SizedBox(
                            height: 8,
                          ),

                          const Center(
  child: Text(
    'Browse verified member profiles',
    textAlign: TextAlign.center,
  ),
),
                          const SizedBox(
                            height: 20,
                          ),

                          SizedBox(
                            width:
                                250,
                            height:
                                50,

                            child:
                                ElevatedButton.icon(
                              onPressed:
                                  () {
                                if (profileStatus !=
                                    'Approved') {
                                  ScaffoldMessenger.of(
                                          context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text(
                                        'Profile approval is pending',
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) =>
                                            const BrowseProfilesScreen(),
                                  ),
                                );
                              },

                              icon:
                                  const Icon(
                                Icons.people,
                              ),

                              label:
                                  const Text(
                                'Browse Profiles',
                              ),

                              style:
                                  ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(
                                  0xFF8B002E,
                                ),

                                foregroundColor:
                                    Colors
                                        .white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  static Widget _buildBadge(
    IconData icon,
    String text,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),

      decoration:
          BoxDecoration(
        color:
            const Color(
          0xFFF7E9D7,
        ),

        borderRadius:
            BorderRadius.circular(
          30,
        ),
      ),

      child: Row(
        mainAxisSize:
            MainAxisSize.min,

        children: [
          Icon(
            icon,
            size: 18,
            color:
                const Color(
              0xFF8B002E,
            ),
          ),

          const SizedBox(
            width: 8,
          ),

          Text(
            text,
            style:
                const TextStyle(
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildStatusCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding:
          const EdgeInsets.all(
        20,
      ),

      decoration:
          BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          20,
        ),

        border: Border.all(
          color:
              const Color(
            0xFFE7DCCF,
          ),
        ),
      ),

      child: Column(
        children: [

          Icon(
            icon,
            size: 32,
            color:
                const Color(
              0xFF8B002E,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          Text(
            value,
            textAlign:
                TextAlign.center,

            style:
                const TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
              color:
                  Color(
                0xFF8B002E,
              ),
            ),
          ),

          const SizedBox(
            height: 6,
          ),

          Text(
            title,
            textAlign:
                TextAlign.center,
          ),
        ],
      ),
    );
  }

  static void _showMembershipDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Center(
  child: Text(
    'Membership Plans',
    style: TextStyle(
      fontWeight: FontWeight.bold,
      color: Color(0xFF8B002E),
    ),
  ),
),

          content:
             const SingleChildScrollView(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Text(
        'Free Plan',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

      Text(
        '₹0',
      ),

      SizedBox(height: 16),

      Text(
        'Silver Plan',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

      Text(
        '₹999 • 1 Month',
      ),

      SizedBox(height: 16),

      Text(
        'Gold Plan',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

      Text(
        '₹2,999 • 3 Months',
      ),

      SizedBox(height: 16),

      Text(
        'Diamond Plan',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

      Text(
        '₹4,999 • 6 Months',
      ),

      SizedBox(height: 16),

      Text(
        'Platinum Plan',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

      Text(
        '₹9,999 • 1 Year',
      ),
    ],
  ),
),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              child:
                  const Text(
                'Close',
              ),
            ),
          ],
        );
      },
    );
  }
}
                    
