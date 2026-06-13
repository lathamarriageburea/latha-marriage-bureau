import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteProfilesScreen extends StatelessWidget {
  const DeleteProfilesScreen({
    super.key,
  });

  Future<void> deleteProfile(
    String documentId,
  ) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .delete();
  }

  Color _membershipColor(
    String plan,
  ) {
    switch (plan) {
      case 'Silver':
        return Colors.blueGrey;

      case 'Gold':
        return Colors.amber;

      case 'Diamond':
        return Colors.blue;

      case 'Platinum':
        return Colors.purple;

      default:
        return Colors.grey;
    }
  }

  Future<void> _confirmDelete({
    required BuildContext context,
    required String documentId,
    required String memberName,
  }) async {
    final bool? confirm =
        await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              20,
            ),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
              ),
              SizedBox(width: 8),
              Text(
                'Delete Profile',
              ),
            ],
          ),
          content: Column(
            mainAxisSize:
                MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'Member: $memberName',
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'This action cannot be undone.',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child: const Text(
                'Cancel',
              ),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.red,
                foregroundColor:
                    Colors.white,
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              child: const Text(
                'Delete',
              ),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    await deleteProfile(
      documentId,
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Profile Deleted Successfully',
          ),
        ),
      );
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F5F2),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Delete Profiles',
          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore
            .instance
            .collection('users')
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
                        .all(20),
                child: Text(
                  snapshot.error
                      .toString(),
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

          final users =
              snapshot.data!.docs.where(
            (doc) {
              final data =
                  doc.data()
                      as Map<String,
                          dynamic>;

              final email =
                  (data['email'] ?? '')
                      .toString()
                      .toLowerCase();

              return email !=
                  'admin@gmail.com';
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
                    size: 90,
                    color:
                        Colors.grey,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'No Profiles Found',
                    style:
                        TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'All member profiles have been removed.',
                  ),
                ],
              ),
            );
          }

          return ListView(
            padding:
                const EdgeInsets.all(
              16,
            ),
            children: [
              Container(
                padding:
                    const EdgeInsets
                        .all(20),
                decoration:
                    BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                  gradient:
                      const LinearGradient(
                    colors: [
                      Colors.red,
                      Color(
                        0xFFC62828,
                      ),
                    ],
                  ),
                ),
                child:
                    const Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Text(
                      'Delete Profiles',
                      style:
                          TextStyle(
                        color:
                            Colors.white,
                        fontSize:
                            24,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Manage and remove member profiles',
                      style:
                          TextStyle(
                        color:
                            Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              ...users.map(
                (doc) {
                  final data =
                      doc.data()
                          as Map<
                              String,
                              dynamic>;

                  final name =
                      data['fullName'] ??
                          'Unknown';

                  final mobile =
                      data['mobileNumber'] ??
                          '';

                  final membership =
                      data['membershipPlan'] ??
                          'Free';

                  return Card(
                    elevation: 3,
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
                            children: [
                              CircleAvatar(
                                radius:
                                    28,
                                backgroundColor:
                                    Colors.red
                                        .shade50,
                                child:
                                    Text(
                                  name
                                          .toString()
                                          .isNotEmpty
                                      ? name[0]
                                          .toUpperCase()
                                      : '?',
                                  style:
                                      const TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                    color:
                                        Colors.red,
                                    fontSize:
                                        20,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                width:
                                    14,
                              ),

                              Expanded(
                                child:
                                    Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
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
                                      'Mobile: $mobile',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height:
                                14,
                          ),

                          Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal:
                                      12,
                                  vertical:
                                      6,
                                ),
                                decoration:
                                    BoxDecoration(
                                  color:
                                      _membershipColor(
                                    membership,
                                  ).withOpacity(
                                    0.15,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(
                                    20,
                                  ),
                                ),
                                child:
                                    Text(
                                  membership,
                                  style:
                                      TextStyle(
                                    color:
                                        _membershipColor(
                                      membership,
                                    ),
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ),

                              const Spacer(),

                              ElevatedButton.icon(
                                style:
                                    ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.red,
                                  foregroundColor:
                                      Colors.white,
                                ),
                                onPressed:
                                    () {
                                  _confirmDelete(
                                    context:
                                        context,
                                    documentId:
                                        doc.id,
                                    memberName:
                                        name,
                                  );
                                },
                                icon:
                                    const Icon(
                                  Icons.delete,
                                ),
                                label:
                                    const Text(
                                  'Delete',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}