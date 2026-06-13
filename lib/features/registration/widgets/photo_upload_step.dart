import 'package:flutter/material.dart';

class PhotoUploadStep extends StatelessWidget {
  final String? photoPath;
  final VoidCallback onPickPhoto;

  const PhotoUploadStep({
    super.key,
    required this.photoPath,
    required this.onPickPhoto,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Center(
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(
          maxWidth: 580,
        ),
        child: Card(
  elevation: 18,
  shadowColor: Colors.black12,
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              24,
            ),
          ),
          color: Colors.white,

child: Padding(
            padding:
    const EdgeInsets.symmetric(
  horizontal: 32,
  vertical: 28,
),
            child: Column(
              children: [

                const SizedBox(height: 10),

                Container(
                  height: 180,
width: 180,

                  decoration:
                      BoxDecoration(
                    color:
                        const Color(
                      0xFFFFF8F3,
                    ),

                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),

                    border: Border.all(
                      color:
                          const Color(
                        0xFFD4A24C,
                      ),
                      width: 2,
                    ),
                  ),

                  child: photoPath != null
                      ? const Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [

                            Icon(
                              Icons.check_circle,
                              size: 70,
                              color:
                                  Colors.green,
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            Text(
                              'Photo Selected',
                              style:
                                  TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : const Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [

                            Icon(
                              Icons
                                  .add_a_photo,
                              size: 70,
                              color:
                                  Color(
                                0xFF8B002E,
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),

                           Text(
  'Tap below to upload',
  textAlign: TextAlign.center,
),
                          ],
                        ),
                ),

                const SizedBox(
                  height: 25,
                ),

                SizedBox(
                  width: 260,
                  height: 55,
                  child:
                      ElevatedButton.icon(
                    onPressed:
                        onPickPhoto,
                    icon: const Icon(
                      Icons.upload,
                    ),
                    label: Text(
                      photoPath == null
                          ? 'Choose Profile Photo'
                          : 'Change Photo',
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
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                if (photoPath == null)
                  const Text(
                    '* Profile photo is mandatory',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  )
                else
                  const Text(
                    'Photo uploaded successfully ✓',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                const SizedBox(
                  height: 10,
                ),

                const Text(
                  'Supported formats: JPG, JPEG, PNG',
                  textAlign:
                      TextAlign.center,
                  style: TextStyle(
                    color:
                        Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}