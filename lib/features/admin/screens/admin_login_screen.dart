import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

import '../../auth/services/auth_service.dart';
import 'admin_dashboard_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({
    super.key,
  });

  @override
  State<AdminLoginScreen> createState() =>
      _AdminLoginScreenState();
}

class _AdminLoginScreenState
    extends State<AdminLoginScreen> {
  final usernameController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  String? _emailError;
  String? _passwordError;

  bool _loading = false;

  bool _obscurePassword = true;

  Future<void> login() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    bool isValid = true;

    if (usernameController.text
        .trim()
        .isEmpty) {
      _emailError =
          'Please enter email address';

      isValid = false;
    }

    if (passwordController.text
        .trim()
        .isEmpty) {
      _passwordError =
          'Please enter password';

      isValid = false;
    }

    if (!isValid) {
      setState(() {});
      return;
    }

    try {
      setState(
        () => _loading = true,
      );

      await AuthService().login(
        email:
            usernameController.text.trim(),
        password:
            passwordController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Admin Login Successful',
          ),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const AdminDashboardScreen(),
        ),
      );
    } catch (_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Invalid email or password',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(
          () => _loading = false,
        );
      }
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          AppColors.background,

      body: Center(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(
            24,
          ),
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(
              maxWidth: 460,
            ),
            child: Card(
              elevation: 3,
              color: Colors.white,
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  24,
                ),
                side:
                    const BorderSide(
                  color:
                      AppColors.border,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.all(
                  32,
                ),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [

                    Container(
                      width: 100,
                      height: 100,
                      decoration:
                          BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(
                          50,
                        ),
                        border:
                            Border.all(
                          color:
                              AppColors.gold,
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(
                          50,
                        ),
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      'Admin Portal',
                      textAlign:
                          TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            AppColors.primary,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    const Text(
                      'Latha Marriage Bureau',
                      textAlign:
                          TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors
                            .textSecondary,
                      ),
                    ),

                    const SizedBox(
                      height: 32,
                    ),

                    TextField(
                      controller:
                          usernameController,
                      keyboardType:
                          TextInputType
                              .emailAddress,
                      decoration:
                          InputDecoration(
                        labelText:
                            'Admin Email',
                        errorText:
                            _emailError,
                        filled: true,
                        fillColor:
                            AppColors.ivory,
                        prefixIcon:
                            const Icon(
                          Icons.email_outlined,
                        ),
                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    TextField(
                      controller:
                          passwordController,
                      obscureText:
                          _obscurePassword,
                      decoration:
                          InputDecoration(
                        labelText:
                            'Password',
                        errorText:
                            _passwordError,
                        filled: true,
                        fillColor:
                            AppColors.ivory,
                        prefixIcon:
                            const Icon(
                          Icons.lock_outline,
                        ),
                        suffixIcon:
                            IconButton(
                          onPressed: () {
                            setState(
                              () {
                                _obscurePassword =
                                    !_obscurePassword;
                              },
                            );
                          },
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                                        SizedBox(
                      width:
                          double.infinity,
                      height: 55,
                      child:
                          ElevatedButton(
                        onPressed:
                            _loading
                                ? null
                                : login,
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColors.primary,
                          foregroundColor:
                              Colors.white,
                          elevation: 0,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),
                          ),
                        ),
                        child: _loading
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child:
                                    CircularProgressIndicator(
                                  strokeWidth:
                                      2,
                                  color:
                                      Colors.white,
                                ),
                              )
                            : const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.admin_panel_settings,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Admin Login',
                                    style:
                                        TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    Container(
                      padding:
                          const EdgeInsets.all(
                        16,
                      ),
                      decoration:
                          BoxDecoration(
                        color:
                            AppColors.ivory,
                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                        border:
                            Border.all(
                          color:
                              AppColors.border,
                        ),
                      ),
                      child:
                          const Column(
                        children: [

                          Text(
                            'Administrator Access',
                            style:
                                TextStyle(
                              fontSize: 15,
                              fontWeight:
                                  FontWeight.bold,
                              color:
                                  AppColors.primary,
                            ),
                          ),

                          SizedBox(
                            height: 8,
                          ),

                          Text(
                            'Authorized staff only',
                            textAlign:
                                TextAlign.center,
                            style:
                                TextStyle(
                              color: AppColors
                                  .textSecondary,
                            ),
                          ),

                          SizedBox(
                            height: 12,
                          ),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [

                              Icon(
                                Icons.phone,
                                size: 16,
                                color:
                                    AppColors.gold,
                              ),

                              SizedBox(
                                width: 6,
                              ),

                              Text(
                                '+91 89193 64223',
                                style:
                                    TextStyle(
                                  fontWeight:
                                      FontWeight.w600,
                                  color:
                                      AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}