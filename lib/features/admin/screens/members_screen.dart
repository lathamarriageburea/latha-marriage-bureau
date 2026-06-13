import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({
    super.key,
  });

  @override
  State<MembersScreen> createState() =>
      _MembersScreenState();
}

class _MembersScreenState
    extends State<MembersScreen> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F5F2),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Member Directory',
          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin:
                const EdgeInsets.all(
              16,
            ),
            padding:
                const EdgeInsets.all(
              20,
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
            child: const Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Text(
                  'Member Directory',
                  style: TextStyle(
                    color:
                        Colors.white,
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Search and manage registered members',
                  style: TextStyle(
                    color:
                        Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: TextField(
              decoration:
                  InputDecoration(
                hintText:
                    'Search by name or mobile number',
                prefixIcon:
                    const Icon(
                  Icons.search,
                ),
                filled: true,
                fillColor:
                    Colors.white,
                    enabledBorder:
    OutlineInputBorder(
  borderRadius:
      BorderRadius.circular(
    14,
  ),
  borderSide:
      const BorderSide(
    color:
        Color(
      0xFFE5E5E5,
    ),
  ),
),
                border: OutlineInputBorder(
  borderRadius:
      BorderRadius.circular(
    14,
  ),
),

focusedBorder:
    OutlineInputBorder(
  borderRadius:
      BorderRadius.circular(
    14,
  ),
  borderSide:
      const BorderSide(
    color:
        Color(
      0xFFD81B60,
    ),
    width: 1.5,
  ),
),
                contentPadding:
                    const EdgeInsets.symmetric(
                  vertical: 14,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchText =
                      value.toLowerCase();
                });
              },
            ),
          ),

          const SizedBox(
            height: 16,
          ),

          Expanded(
            child:
                StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore
                      .instance
                      .collection(
                        'users',
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
                          const EdgeInsets
                              .all(
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

                final allUsers =
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

                    return email !=
                            'admin@gmail.com' &&
                        name !=
                            'adminaccess';
                  },
                ).toList();

                final users =
                    allUsers.where(
                  (doc) {
                    final data =
                        doc.data()
                            as Map<
                                String,
                                dynamic>;

                    final name =
                        (data['fullName'] ??
                                '')
                            .toString()
                            .toLowerCase();

                    final mobile =
                        (data['mobileNumber'] ??
                                '')
                            .toString()
                            .toLowerCase();

                    return name.contains(
                            searchText) ||
                        mobile.contains(
                            searchText);
                  },
                ).toList();

                if (users.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 80,
                          color:
                              Colors.grey,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'No Members Found',
                          style:
                              TextStyle(
                            fontSize:
                                18,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding:
                      const EdgeInsets
                          .fromLTRB(
                    16,
                    0,
                    16,
                    16,
                  ),
                  itemCount:
                      users.length,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    final data =
                        users[index]
                                .data()
                            as Map<
                                String,
                                dynamic>;

                    final fullName =
                        data['fullName'] ??
                            'Unknown';

                    final mobile =
                        data['mobileNumber'] ??
                            '';

                    final location =
                        data['currentLocation'] ??
                            '';

                    final profileStatus =
                        data['profileStatus'] ??
                            '';

                    final membershipPlan =
                        data['membershipPlan'] ??
                            'Free';

                    return Card(
  color: Colors.white,
  elevation: 1,
  shadowColor: Colors.black12,
                      margin:
                          const EdgeInsets.only(
                        bottom: 14,
                      ),
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                                
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
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor:
                                    const Color(
  0xFFF8F8F8,
),
                                  child: Text(
                                    fullName
                                            .toString()
                                            .isNotEmpty
                                        ? fullName[
                                                0]
                                            .toUpperCase()
                                        : '?',
                                    style:
                                        const TextStyle(
                                      fontSize:
                                          22,
                                      fontWeight:
                                          FontWeight
                                              .bold,
                                      color:
                                          Color(
                                        0xFFD81B60,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  width: 14,
                                ),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                    children: [
                                      Text(
                                        fullName,
                                        style:
                                            const TextStyle(
                                          fontSize:
                                              18,
                                          fontWeight:
                                              FontWeight
                                                  .bold,
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 6,
                                      ),

                                      Text(
  mobile,
  style: const TextStyle(
    color: Color(0xFF666666),
    fontWeight: FontWeight.w500,
  ),
),
                                      Text(
  location,
  style: const TextStyle(
    color: Color(0xFF888888),
  ),
),
                                    ],
                                  ),
                                ),

                                PopupMenuButton<
                                    String>(
                                  onSelected:
                                      (
                                    value,
                                  ) {
                                    if (value ==
                                        'details') {
                                      _showDetails(
                                        context,
                                        data,
                                      );
                                    }
                                  },
                                  itemBuilder:
                                      (_) => [
                                    const PopupMenuItem(
                                      value:
                                          'details',
                                      child: Text(
                                        'View Details',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 14,
                            ),

                            Row(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets
                                          .symmetric(
                                    horizontal:
                                        12,
                                    vertical:
                                        6,
                                  ),
                                  decoration:
                                      BoxDecoration(
                                    color: Colors
                                        .blue
                                        .shade50,
                                    borderRadius:
                                        BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                  child: Text(
                                    profileStatus,
                                    style:
                                        TextStyle(
                                      color: Colors
                                          .blue
                                          .shade700,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  width: 8,
                                ),

                                Container(
                                  padding:
                                      const EdgeInsets
                                          .symmetric(
                                    horizontal:
                                        12,
                                    vertical:
                                        6,
                                  ),
                                  decoration:
                                      BoxDecoration(
                                    color:
                                    
    const Color(
  0xFFF8F8F8,
),
border: Border.all(
  color: const Color(
    0xFFE5E5E5,
  ),
),
                                    borderRadius:
                                        BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                  child: Text(
                                    membershipPlan,
                                    style:
                                        const TextStyle(
                                      color:
                                          Color(
                                        0xFFD81B60,
                                      ),
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDetails(
    BuildContext context,
    Map<String, dynamic> data,
  ) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            data['fullName'] ?? '',
          ),
          content:
              SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                Text(
                  'Mobile: ${data['mobileNumber'] ?? ''}',
                ),
                Text(
                  'Location: ${data['currentLocation'] ?? ''}',
                ),
                Text(
                  'Gender: ${data['gender'] ?? ''}',
                ),
                Text(
                  'Religion: ${data['religion'] ?? ''}',
                ),
                Text(
                  'Qualification: ${data['qualification'] ?? ''}',
                ),
                Text(
                  'Occupation: ${data['occupation'] ?? ''}',
                ),
                Text(
                  'Membership: ${data['membershipPlan'] ?? ''}',
                ),
                Text(
                  'Profile Status: ${data['profileStatus'] ?? ''}',
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
              child: const Text(
                'Close',
              ),
            ),
          ],
        );
      },
    );
  }
}