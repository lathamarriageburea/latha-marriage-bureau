import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'profile_screen.dart';

class BrowseProfilesScreen extends StatefulWidget {
  const BrowseProfilesScreen({
    super.key,
  });

  @override
  State<BrowseProfilesScreen> createState() =>
      _BrowseProfilesScreenState();
}

class _BrowseProfilesScreenState
    extends State<BrowseProfilesScreen> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final currentUser =
        FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor:
          const Color(0xFFFFF8F3),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFFFFF8F3),

        elevation: 0,

        centerTitle: true,

        title: const Text(
          'Browse Profiles',
          style: TextStyle(
            color: Color(0xFF8B002E),
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Color(0xFF8B002E),
        ),
      ),

      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(
            maxWidth: 1000,
          ),

          child: Column(
            children: [

              /// HEADER

              const SizedBox(
                height: 16,
              ),

              const Text(
                'Find Your Perfect Match',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight.bold,
                  color: Color(
                    0xFF8B002E,
                  ),
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              const Text(
                'Browse verified member profiles',
                textAlign:
                    TextAlign.center,
                style: TextStyle(
                  color: Color(
                    0xFF6B6B6B,
                  ),
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              /// SEARCH BOX

              Padding(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 20,
                ),

                child: SizedBox(
                  width: 600,

                  child: TextField(
                    decoration:
                        InputDecoration(
                      hintText:
                          'Search by name or location',

                      prefixIcon:
                          const Icon(
                        Icons.search,
                      ),

                      filled: true,

                      fillColor:
                          Colors.white,

                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                          16,
                        ),

                        borderSide:
                            const BorderSide(
                          color: Color(
                            0xFFE7DCCF,
                          ),
                        ),
                      ),

                      enabledBorder:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                          16,
                        ),

                        borderSide:
                            const BorderSide(
                          color: Color(
                            0xFFE7DCCF,
                          ),
                        ),
                      ),
                    ),

                    onChanged:
                        (value) {
                      setState(
                        () {
                          searchText =
                              value
                                  .toLowerCase();
                        },
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              /// PROFILE LIST

              Expanded(
                child:
                    StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore
                          .instance
                          .collection(
                            'users',
                          )
                          .where(
                            'profileStatus',
                            isEqualTo:
                                'Approved',
                          )
                          .where(
                            'profileVisible',
                            isEqualTo:
                                true,
                          )
                          .snapshots(),

                  builder: (
                    context,
                    snapshot,
                  ) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          snapshot.error
                              .toString(),
                        ),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Center(
                        child:
                            CircularProgressIndicator(),
                      );
                    }

                    final profiles =
                        snapshot.data!.docs
                            .where(
                      (doc) {
                        final data =
                            doc.data()
                                as Map<
                                    String,
                                    dynamic>;

                        final email =
                            (data['email'] ??
                                    '')
                                .toString()
                                .toLowerCase();

                        final name =
                            (data['fullName'] ??
                                    '')
                                .toString()
                                .toLowerCase();

                        final location =
                            (data['currentLocation'] ??
                                    '')
                                .toString()
                                .toLowerCase();

                        return email !=
                                'lathamarriagebureau@gmail.com' &&
                            email !=
                                currentUser
                                    ?.email &&
                            (name.contains(
                                    searchText) ||
                                location.contains(
                                    searchText));
                      },
                    ).toList();

                    if (profiles.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [

                            Icon(
                              Icons.people_outline,
                              size: 80,
                              color:
                                  Colors.grey,
                            ),

                            SizedBox(
                              height: 16,
                            ),

                            Text(
                              'No Profiles Found',
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView(
                      padding:
                          const EdgeInsets.all(
                        20,
                      ),

                      children: [

                        Center(
                          child: Text(
                            '${profiles.length} Profiles Available',
                            style:
                                const TextStyle(
                              fontSize:
                                  18,
                              fontWeight:
                                  FontWeight.bold,
                              color:
                                  Color(
                                0xFF8B002E,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                                                ...profiles.map(
                          (profile) {
                            final data =
                                profile.data()
                                    as Map<
                                        String,
                                        dynamic>;

                            return _ProfileCard(
                              profile: data,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileCard
    extends StatelessWidget {
  final Map<String, dynamic>
      profile;

  const _ProfileCard({
    required this.profile,
  });

  Color getBadgeColor(
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

  @override
  Widget build(BuildContext context) {
    final plan =
        profile['membershipPlan'] ??
            'Free';

    final photoUrl =
        profile['photoUrl'] ?? '';

    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 20,
      ),

      padding:
          const EdgeInsets.all(
        24,
      ),

      decoration:
          BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          24,
        ),

        border: Border.all(
          color:
              const Color(
            0xFFE7DCCF,
          ),
        ),

        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color:
                Color(0x12000000),
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      ),

      child: LayoutBuilder(
        builder: (
          context,
          constraints,
        ) {
          final isMobile =
              constraints.maxWidth <
                  700;

          if (isMobile) {
            return Column(
              children: [

                CircleAvatar(
                  radius: 55,

                  backgroundImage:
                      photoUrl
                              .toString()
                              .isNotEmpty
                          ? NetworkImage(
                              photoUrl,
                            )
                          : null,

                  child: photoUrl
                          .toString()
                          .isEmpty
                      ? const Icon(
                          Icons.person,
                          size: 50,
                        )
                      : null,
                ),

                const SizedBox(
                  height: 16,
                ),

                Text(
                  profile[
                          'fullName'] ??
                      '',
                  textAlign:
                      TextAlign.center,

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

                const SizedBox(
                  height: 12,
                ),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),

                  decoration:
                      BoxDecoration(
                    color:
                        getBadgeColor(
                      plan,
                    ),

                    borderRadius:
                        BorderRadius.circular(
                      30,
                    ),
                  ),

                  child: Text(
                    plan,
                    style:
                        const TextStyle(
                      color:
                          Colors.white,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                Text(
                  '${profile['age'] ?? ''} Years • ${profile['height'] ?? ''}',
                  textAlign:
                      TextAlign.center,
                ),

                const SizedBox(
                  height: 6,
                ),

                Text(
                  profile[
                          'currentLocation'] ??
                      '',
                  textAlign:
                      TextAlign.center,
                ),

                const SizedBox(
                  height: 6,
                ),

                Text(
                  profile[
                          'occupation'] ??
                      '',
                  textAlign:
                      TextAlign.center,
                ),

                const SizedBox(
                  height: 6,
                ),

                Text(
                  '${profile['religion'] ?? ''} • ${profile['caste'] ?? ''}',
                  textAlign:
                      TextAlign.center,
                ),

                const SizedBox(
                  height: 20,
                ),
                                SizedBox(
                  width: 220,
                  height: 50,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.visibility,
                    ),
                    label: const Text(
                      'View Full Profile',
                    ),
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(
                        0xFF8B002E,
                      ),
                      foregroundColor:
                          Colors.white,
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProfileScreen(
                            profile:
                                profile,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          /// DESKTOP / TABLET LAYOUT

          return Row(
            crossAxisAlignment:
                CrossAxisAlignment.center,
            children: [

              CircleAvatar(
                radius: 60,
                backgroundImage:
                    photoUrl
                            .toString()
                            .isNotEmpty
                        ? NetworkImage(
                            photoUrl,
                          )
                        : null,
                child: photoUrl
                        .toString()
                        .isEmpty
                    ? const Icon(
                        Icons.person,
                        size: 55,
                      )
                    : null,
              ),

              const SizedBox(
                width: 24,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(
                      profile[
                              'fullName'] ??
                          '',
                      style:
                          const TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            Color(
                          0xFF8B002E,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      '${profile['age'] ?? ''} Years • ${profile['height'] ?? ''}',
                    ),

                    const SizedBox(
                      height: 6,
                    ),

                    Text(
                      profile[
                              'currentLocation'] ??
                          '',
                    ),

                    const SizedBox(
                      height: 6,
                    ),

                    Text(
                      profile[
                              'occupation'] ??
                          '',
                    ),

                    const SizedBox(
                      height: 6,
                    ),

                    Text(
                      '${profile['religion'] ?? ''} • ${profile['caste'] ?? ''}',
                    ),
                  ],
                ),
              ),

              const SizedBox(
                width: 20,
              ),

              Column(
                children: [

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration:
                        BoxDecoration(
                      color:
                          getBadgeColor(
                        plan,
                      ),
                      borderRadius:
                          BorderRadius.circular(
                        30,
                      ),
                    ),
                    child: Text(
                      plan,
                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    width: 180,
                    height: 50,
                    child:
                        ElevatedButton.icon(
                      icon:
                          const Icon(
                        Icons.visibility,
                      ),
                      label:
                          const Text(
                        'View Full Profile',
                      ),
                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(
                          0xFF8B002E,
                        ),
                        foregroundColor:
                            Colors.white,
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ProfileScreen(
                              profile:
                                  profile,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}