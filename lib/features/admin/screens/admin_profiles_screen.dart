import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'profile_review_screen.dart';

class AdminProfilesScreen extends StatelessWidget {
  const AdminProfilesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F5F2),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,

        title: const Text(
          'Pending Profiles',
          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where(
              'profileStatus',
              isEqualTo: 'Pending',
            )
            .snapshots(),

        builder: (
          context,
          snapshot,
        ) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding:
                    const EdgeInsets.all(
                  20,
                ),
                child: Text(
                  snapshot.error
                      .toString(),
                  textAlign:
                      TextAlign.center,
                ),
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
              snapshot.data!.docs;

          if (profiles.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment
                        .center,
                children: [

                  Icon(
                    Icons
                        .check_circle_outline,
                    size: 80,
                    color: Colors.green,
                  ),

                  SizedBox(
                    height: 16,
                  ),

                  Text(
                    'No Pending Profiles',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  SizedBox(
                    height: 8,
                  ),

                  Text(
                    'All submitted profiles have been reviewed.',
                    textAlign:
                        TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [

              Container(
                width: double.infinity,
                margin:
                    const EdgeInsets.all(
                  16,
                ),

                padding:
                    const EdgeInsets.all(
                  18,
                ),

                decoration:
                    BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),

                  gradient:
                      const LinearGradient(
                    colors: [
                      Color(
                        0xFFD81B60,
                      ),
                      Color(
                        0xFFAD1457,
                      ),
                    ],
                  ),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    const Text(
                      'Profile Review Queue',
                      style:
                          TextStyle(
                        color:
                            Colors.white,
                        fontSize: 22,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                      '${profiles.length} profiles waiting for approval',
                      style:
                          const TextStyle(
                        color:
                            Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child:
                    ListView.builder(
                  padding:
                      const EdgeInsets
                          .only(
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),

                  itemCount:
                      profiles.length,

                  itemBuilder: (
                    context,
                    index,
                  ) {
                    final data =
                        profiles[index]
                                .data()
                            as Map<String,
                                dynamic>;

                    final fullName =
                        data['fullName'] ??
                            'Unknown';

                    final gender =
                        data['gender'] ??
                            'N/A';

                    final religion =
                        data['religion'] ??
                            'N/A';

                    final qualification =
                        data['qualification'] ??
                            'N/A';

                    final location =
                        data['currentLocation'] ??
                            'N/A';

                    return Card(
  color: Colors.white,
  elevation: 1,
  shadowColor: Colors.black12,

                      margin:
                          const EdgeInsets
                              .only(
                        bottom: 14,
                      ),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          18,
                        ),
                      ),

                      child: Padding(
                        padding:
                            const EdgeInsets
                                .all(
                          16,
                        ),

                        child: Column(
                          children: [

                            Row(
                              children: [

                                CircleAvatar(
  radius: 28,
  backgroundColor:
      const Color(
    0xFFF8F8F8,
  ),
                                  child:
                                      Text(
                                    fullName
                                            .isNotEmpty
                                        ? fullName[
                                            0]
                                        : '?',
                                    style:
                                        const TextStyle(
                                      fontSize:
                                          22,
                                      fontWeight:
                                          FontWeight.bold,
                                      color:
                                          Color(0xFFD81B60),
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  width: 14,
                                ),

                                Expanded(
                                  child:
                                      Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [

                                      Text(
                                        fullName,
                                        style:
                                            const TextStyle(
                                          fontSize:
                                              18,
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(
                                        height:
                                            4,
                                      ),

                                      Text(
  location,
  style:
      const TextStyle(
    color: Color(0xFF777777),
    fontWeight: FontWeight.w500,
  ),
),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 16,
                            ),

                            Row(
                              children: [

                                Expanded(
                                  child:
                                      _infoChip(
                                    Icons
                                        .person,
                                    gender,
                                  ),
                                ),

                                const SizedBox(
                                  width: 8,
                                ),

                                Expanded(
                                  child:
                                      _infoChip(
                                    Icons
                                        .temple_hindu,
                                    religion,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            _infoChip(
                              Icons.school,
                              qualification,
                            ),

                            const SizedBox(
                              height: 18,
                            ),

                            SizedBox(
                              width: double
                                  .infinity,

                              child:
                                  ElevatedButton.icon(
                                icon:
                                    const Icon(
                                  Icons
                                      .visibility,
                                ),

                                label:
                                    const Text(
                                  'Review Profile',
                                ),

                                style:
                                    ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(
                                    0xFFD81B60,
                                  ),

                                  foregroundColor:
                                      Colors.white,

                                  padding:
                                      const EdgeInsets.symmetric(
                                    vertical:
                                        14,
                                  ),

                                  shape:
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(
                                      12,
                                    ),
                                  ),
                                ),

                                onPressed:
                                    () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) =>
                                              ProfileReviewScreen(
                                        documentId:
                                            profiles[index].id,
                                        profile:
                                            data,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  static Widget _infoChip(
    IconData icon,
    String text,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),

      decoration: BoxDecoration(
  color: Colors.white,
  borderRadius:
      BorderRadius.circular(
    12,
  ),
  border: Border.all(
    color: const Color(
      0xFFE5E5E5,
    ),
  ),
),

      child: Row(
        children: [

          Icon(
            icon,
            size: 18,
            color:
                const Color(
              0xFFD81B60,
            ),
          ),

          const SizedBox(
            width: 8,
          ),

          Expanded(
            child: Text(
              text,
              overflow:
                  TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}