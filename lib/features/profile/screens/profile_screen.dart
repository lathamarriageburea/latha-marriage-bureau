import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> profile;

  const ProfileScreen({
    super.key,
    required this.profile,
  });

  Color _membershipColor(
    String plan,
  ) {
    switch (plan) {
      case 'Silver':
        return Colors.grey;

      case 'Gold':
        return const Color(
          0xFFD4A24C,
        );

      case 'Diamond':
        return Colors.blue;

      case 'Platinum':
        return Colors.purple;

      default:
        return Colors.blueGrey;
    }
  }

  Widget _sectionTitle(
    IconData icon,
    String title,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        top: 28,
        bottom: 16,
      ),
      child: Row(
        children: [

          Icon(
            icon,
            color:
                const Color(
              0xFF8B002E,
            ),
          ),

          const SizedBox(
            width: 10,
          ),

          Text(
            title,
            style:
                const TextStyle(
              fontSize: 22,
              fontWeight:
                  FontWeight.bold,
              color:
                  Color(
                0xFF8B002E,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(
    String label,
    dynamic value,
  ) {
    final displayValue =
        value?.toString().trim().isNotEmpty ==
                true
            ? value.toString()
            : 'Not Provided';

    return Container(
      padding:
          const EdgeInsets.all(
        16,
      ),

      decoration:
          BoxDecoration(
        color:
            Colors.white,

        borderRadius:
            BorderRadius.circular(
          16,
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
            CrossAxisAlignment.start,

        children: [

          Text(
            label,
            style:
                const TextStyle(
              fontSize: 12,
              color:
                  Color(
                0xFF6B6B6B,
              ),
            ),
          ),

          const SizedBox(
            height: 6,
          ),

          Text(
  displayValue,
  maxLines: 3,
  overflow: TextOverflow.ellipsis,
  style: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),
),
        ],
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final photoUrl =
        profile['photoUrl']
                ?.toString() ??
            '';

    final fullName =
        profile['fullName'] ??
            'Member';

    final age =
        profile['age']
                ?.toString() ??
            '';

    final gender =
        profile['gender']
                ?.toString() ??
            '';

    final location =
        profile['currentLocation']
                ?.toString() ??
            '';

    final membershipPlan =
        profile['membershipPlan']
                ?.toString() ??
            'Free';

    final membershipStatus =
        profile['membershipStatus']
                ?.toString() ??
            'Free';

    return Scaffold(
      backgroundColor:
          const Color(
        0xFFFFF8F3,
      ),

      appBar: AppBar(
        backgroundColor:
            const Color(
          0xFFFFF8F3,
        ),

        elevation: 0,

        centerTitle: true,

        title: const Text(
          'Profile Details',
          style: TextStyle(
            color:
                Color(
              0xFF8B002E,
            ),
            fontWeight:
                FontWeight.bold,
          ),
        ),

        iconTheme:
            const IconThemeData(
          color:
              Color(
            0xFF8B002E,
          ),
        ),
      ),

      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(
            maxWidth: 1000,
          ),

          child:
              SingleChildScrollView(
            padding:
                const EdgeInsets.all(
              20,
            ),

            child: Column(
              children: [

                /// HEADER CARD

                Container(
                  width:
                      double.infinity,

                  padding:
                      const EdgeInsets.all(
                    24,
                  ),

                  decoration:
                      BoxDecoration(
                    color:
                        Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                      24,
                    ),

                    border:
                        Border.all(
                      color:
                          const Color(
                        0xFFE7DCCF,
                      ),
                    ),

                    boxShadow:
                        const [
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

                      CircleAvatar(
                        radius: 70,

                        backgroundImage:
                            photoUrl
                                    .isNotEmpty
                                ? NetworkImage(
                                    photoUrl,
                                  )
                                : null,

                        child:
                            photoUrl
                                    .isEmpty
                                ? const Icon(
                                    Icons.person,
                                    size: 70,
                                  )
                                : null,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Text(
                        fullName,
                        textAlign:
                            TextAlign.center,

                        style:
                            const TextStyle(
                          fontSize:
                              30,
                          fontWeight:
                              FontWeight.bold,
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
                        '$age Years • $gender',
                        textAlign:
                            TextAlign.center,
                      ),

                      const SizedBox(
                        height: 4,
                      ),

                      Text(
                        location,
                        textAlign:
                            TextAlign.center,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal:
                              18,
                          vertical: 10,
                        ),

                        decoration:
                            BoxDecoration(
                          color:
                              _membershipColor(
                            membershipPlan,
                          ),

                          borderRadius:
                              BorderRadius.circular(
                            30,
                          ),
                        ),

                        child: Text(
                          membershipPlan,
                          style:
                              const TextStyle(
                            color:
                                Colors.white,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                                /// PERSONAL DETAILS

                _sectionTitle(
                  Icons.person,
                  'Personal Details',
                ),

                LayoutBuilder(
                  builder: (
                    context,
                    constraints,
                  ) {
                    final isMobile =
                        constraints.maxWidth <
                            700;

                    if (isMobile) {
  return GridView.count(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 1.4,
    children: [

      _infoTile(
        'Religion',
        profile['religion'],
      ),

      _infoTile(
        'Caste',
        profile['caste'],
      ),

      _infoTile(
        'Height',
        profile['height'],
      ),

      _infoTile(
        'Mother Tongue',
        profile['motherTongue'],
      ),

      _infoTile(
        'Marital Status',
        profile['maritalStatus'],
      ),

      _infoTile(
        'Date Of Birth',
        profile['dateOfBirth'],
      ),
    ],
  );
}

                    return Column(
                      children: [

                        Row(
                          children: [

                            Expanded(
                              child: _infoTile(
                                'Religion',
                                profile['religion'],
                              ),
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            Expanded(
                              child: _infoTile(
                                'Caste',
                                profile['caste'],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        Row(
                          children: [

                            Expanded(
                              child: _infoTile(
                                'Height',
                                profile['height'],
                              ),
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            Expanded(
                              child: _infoTile(
                                'Mother Tongue',
                                profile['motherTongue'],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        Row(
                          children: [

                            Expanded(
                              child: _infoTile(
                                'Marital Status',
                                profile['maritalStatus'],
                              ),
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            Expanded(
                              child: _infoTile(
                                'Date Of Birth',
                                profile['dateOfBirth'],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),

                /// EDUCATION & CAREER

                _sectionTitle(
                  Icons.school,
                  'Education & Career',
                ),

                LayoutBuilder(
                  builder: (
                    context,
                    constraints,
                  ) {
                    final isMobile =
                        constraints.maxWidth <
                            700;

                    if (isMobile) {
  return GridView.count(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 0.95,
    children: [
      _infoTile('Qualification', profile['qualification']),
      _infoTile('Specialization', profile['specialization']),
      _infoTile('College / University', profile['college']),
      _infoTile('Occupation', profile['occupation']),
      _infoTile('Company', profile['company']),
      _infoTile('Annual Income', profile['annualIncome']),
      _infoTile('Work Location', profile['workLocation']),
    ],
  );
}

                    return Column(
                      children: [

                        Row(
                          children: [

                            Expanded(
                              child: _infoTile(
                                'Qualification',
                                profile['qualification'],
                              ),
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            Expanded(
                              child: _infoTile(
                                'Specialization',
                                profile['specialization'],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        Row(
                          children: [

                            Expanded(
                              child: _infoTile(
                                'College / University',
                                profile['college'],
                              ),
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            Expanded(
                              child: _infoTile(
                                'Occupation',
                                profile['occupation'],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        Row(
                          children: [

                            Expanded(
                              child: _infoTile(
                                'Company',
                                profile['company'],
                              ),
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            Expanded(
                              child: _infoTile(
                                'Annual Income',
                                profile['annualIncome'],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        _infoTile(
                          'Work Location',
                          profile['workLocation'],
                        ),
                      ],
                    );
                  },
                ),

                /// FAMILY DETAILS

                _sectionTitle(
                  Icons.family_restroom,
                  'Family Details',
                ),
                                LayoutBuilder(
                  builder: (
                    context,
                    constraints,
                  ) {
                    final isMobile =
                        constraints.maxWidth <
                            700;

                    if (isMobile) {
  return GridView.count(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 1.4,
    children: [
      _infoTile('Father Occupation', profile['fatherOccupation']),
      _infoTile('Mother Occupation', profile['motherOccupation']),
      _infoTile('Brothers', profile['brothers']),
      _infoTile('Sisters', profile['sisters']),
      _infoTile('Family Status', profile['familyStatus']),
    ],
  );
}

                    return Column(
                      children: [

                        Row(
                          children: [

                            Expanded(
                              child: _infoTile(
                                'Father Occupation',
                                profile['fatherOccupation'],
                              ),
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            Expanded(
                              child: _infoTile(
                                'Mother Occupation',
                                profile['motherOccupation'],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        Row(
                          children: [

                            Expanded(
                              child: _infoTile(
                                'Brothers',
                                profile['brothers'],
                              ),
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            Expanded(
                              child: _infoTile(
                                'Sisters',
                                profile['sisters'],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        _infoTile(
                          'Family Status',
                          profile['familyStatus'],
                        ),
                      ],
                    );
                  },
                ),

                /// PARTNER PREFERENCES

                _sectionTitle(
                  Icons.favorite,
                  'Partner Preferences',
                ),

                LayoutBuilder(
                  builder: (
                    context,
                    constraints,
                  ) {
                    final isMobile =
                        constraints.maxWidth <
                            700;

                    if (isMobile) {
  return GridView.count(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 1.4,
    children: [
      _infoTile('Preferred Age', profile['preferredAge']),
      _infoTile('Preferred Religion', profile['preferredReligion']),
      _infoTile('Preferred Caste', profile['preferredCaste']),
      _infoTile('Preferred Location', profile['preferredLocation']),
      _infoTile('Partner Expectations', profile['partnerExpectations']),
    ],
  );
}

                    return Column(
                      children: [

                        Row(
                          children: [

                            Expanded(
                              child: _infoTile(
                                'Preferred Age',
                                profile['preferredAge'],
                              ),
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            Expanded(
                              child: _infoTile(
                                'Preferred Religion',
                                profile['preferredReligion'],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        Row(
                          children: [

                            Expanded(
                              child: _infoTile(
                                'Preferred Caste',
                                profile['preferredCaste'],
                              ),
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            Expanded(
                              child: _infoTile(
                                'Preferred Location',
                                profile['preferredLocation'],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        _infoTile(
                          'Partner Expectations',
                          profile['partnerExpectations'],
                        ),
                      ],
                    );
                  },
                ),

                /// MEMBERSHIP INFO

                _sectionTitle(
                  Icons.workspace_premium,
                  'Membership Information',
                ),

                LayoutBuilder(
  builder: (context, constraints) {

    final isMobile =
        constraints.maxWidth < 700;

    if (isMobile) {
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.4,
        children: [

          _infoTile(
            'Membership Plan',
            membershipPlan,
          ),

          _infoTile(
            'Membership Status',
            membershipStatus,
          ),
        ],
      );
    }

    return Row(
      children: [

        Expanded(
          child: _infoTile(
            'Membership Plan',
            membershipPlan,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _infoTile(
            'Membership Status',
            membershipStatus,
          ),
        ),
      ],
    );
  },
),

                /// SAFETY NOTICE

                const SizedBox(
                  height: 30,
                ),

                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.all(
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
                      16,
                    ),
                    border:
                        Border.all(
                      color:
                          const Color(
                        0xFFD4A24C,
                      ),
                    ),
                  ),
                  child: const Column(
                    children: [

                      Icon(
                        Icons.verified_user,
                        color:
                            Color(
                          0xFF8B002E,
                        ),
                        size: 40,
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Text(
                        'Privacy Protected',
                        textAlign:
                            TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              Color(
                            0xFF8B002E,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 8,
                      ),

                      Text(
                        'Contact details are protected and shared only according to membership rules and approval policies.',
                        textAlign:
                            TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}