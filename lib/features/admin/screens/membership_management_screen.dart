import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MembershipManagementScreen extends StatelessWidget {
  const MembershipManagementScreen({
    super.key,
  });

  Future<void> updateMembership({
    required String documentId,
    required String status,
    required String plan,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .update({
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
    final bool? confirmed =
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
          title: const Text(
            'Confirm Membership Change',
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
                height: 8,
              ),
              Text(
                'Selected Plan: $plan',
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
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(
                  0xFFD81B60,
                ),
                foregroundColor:
                    Colors.white,
              ),
              child: const Text(
                'Confirm',
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    await updateMembership(
      documentId: documentId,
      status: plan == 'Free'
          ? 'Free'
          : 'Active',
      plan: plan,
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            '$plan membership updated successfully',
          ),
        ),
      );
    }
  }

  Color _statusColor(
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

  Widget _planButton({
    required BuildContext context,
    required String documentId,
    required String memberName,
    required String plan,
  }) {
    return OutlinedButton(
      onPressed: () {
        _confirmUpdate(
          context: context,
          documentId: documentId,
          memberName: memberName,
          plan: plan,
        );
      },
      style:
          OutlinedButton.styleFrom(
        shape: const StadiumBorder(),
        side: BorderSide(
          color: _statusColor(plan),
        ),
      ),
      child: Text(
        plan,
        style: TextStyle(
          color: _statusColor(plan),
          fontWeight:
              FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F5F2),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Membership Management',
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
                  (data['email'] ??
                          '')
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
                    Icons.workspace_premium,
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
                      fontSize: 18,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
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
                      Color(
                        0xFFD81B60,
                      ),
                      Color(
                        0xFFAD1457,
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
                      'Membership Management',
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
                      'Manage and activate member subscriptions',
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

                  final memberName =
                      data['fullName'] ??
                          'Unknown';

                  final currentPlan =
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
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius:
                                    28,
                                backgroundColor:
                                    const Color(
                                  0xFFFCE4EC,
                                ),
                                child:
                                    Text(
                                  memberName
                                          .toString()
                                          .isNotEmpty
                                      ? memberName[
                                              0]
                                          .toUpperCase()
                                      : '?',
                                  style:
                                      const TextStyle(
                                    color:
                                        Color(
                                      0xFFD81B60,
                                    ),
                                    fontWeight:
                                        FontWeight
                                            .bold,
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
                                      memberName,
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
                                      'Mobile: ${data['mobileNumber'] ?? ''}',
                                    ),

                                    Text(
                                      'Profile Status: ${data['profileStatus'] ?? 'Pending'}',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height:
                                16,
                          ),

                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal:
                                  12,
                              vertical:
                                  8,
                            ),
                            decoration:
                                BoxDecoration(
                              color:
                                  _statusColor(
                                currentPlan,
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
                              'Current Plan: $currentPlan',
                              style:
                                  TextStyle(
                                color:
                                    _statusColor(
                                  currentPlan,
                                ),
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(
                            height:
                                16,
                          ),

                          const Text(
                            'Change Membership',
                            style:
                                TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height:
                                10,
                          ),

                          Wrap(
                            spacing:
                                8,
                            runSpacing:
                                8,
                            children: [
                              _planButton(
                                context:
                                    context,
                                documentId:
                                    doc.id,
                                memberName:
                                    memberName,
                                plan:
                                    'Free',
                              ),
                              _planButton(
                                context:
                                    context,
                                documentId:
                                    doc.id,
                                memberName:
                                    memberName,
                                plan:
                                    'Silver',
                              ),
                              _planButton(
                                context:
                                    context,
                                documentId:
                                    doc.id,
                                memberName:
                                    memberName,
                                plan:
                                    'Gold',
                              ),
                              _planButton(
                                context:
                                    context,
                                documentId:
                                    doc.id,
                                memberName:
                                    memberName,
                                plan:
                                    'Diamond',
                              ),
                              _planButton(
                                context:
                                    context,
                                documentId:
                                    doc.id,
                                memberName:
                                    memberName,
                                plan:
                                    'Platinum',
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