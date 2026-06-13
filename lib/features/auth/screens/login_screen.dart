import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';

import '../services/auth_service.dart';
import 'signup_screen.dart';

import '../../dashboard/screens/user_dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {
  final _emailController =
      TextEditingController();

  final _passwordController =
      TextEditingController();

  String? _emailError;
  String? _passwordError;

  bool _loading = false;

  bool _obscurePassword = true;

  Future<void> _callSupport() async {
  final Uri phoneUri = Uri(
    scheme: 'tel',
    path: '+91 8919364223',
  );

  await launchUrl(phoneUri);
}

Future<void> _forgotPassword() async {

  if (_emailController.text
      .trim()
      .isEmpty) {

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          'Please enter your email address first',
        ),
      ),
    );

    return;
  }

  try {

    await FirebaseAuth.instance
        .sendPasswordResetEmail(
      email: _emailController.text
          .trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          'Password reset email sent successfully',
        ),
      ),
    );

  } on FirebaseAuthException catch (e) {

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          e.message ??
              'Unable to send reset email',
        ),
      ),
    );
  }
}

  Future<void> _login() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    bool isValid = true;

    if (_emailController.text
        .trim()
        .isEmpty) {
      _emailError =
          'Please enter email address';

      isValid = false;
    }

    if (_passwordController.text
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
            _emailController.text.trim(),
        password:
            _passwordController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Login Successful',
          ),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const UserDashboardScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message =
          'Invalid Email or Password';

      if (e.code ==
          'user-disabled') {
        message =
            'Your account has been disabled';
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            message,
          ),
        ),
      );
    } catch (_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to login. Please try again.',
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
          padding: EdgeInsets.all(
  MediaQuery.of(context).size.width < 600
      ? 16
      : 24,
),
          child: ConstrainedBox(
            constraints: BoxConstraints(
  maxWidth:
      MediaQuery.of(context).size.width < 600
          ? double.infinity
          : 460,
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
                  24,
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
                      'Latha Marriage Bureau',
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
                      'Trusted Telugu Matrimony Services',
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
                          _emailController,
                      keyboardType:
                          TextInputType
                              .emailAddress,
                      decoration:
                          InputDecoration(
                        labelText:
                            'Email Address',
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
                          _passwordController,
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

                    Align(
  alignment:
      Alignment.centerRight,

  child: TextButton(
    onPressed:
        _forgotPassword,

    child: const Text(
      'Forgot Password?',
      style: TextStyle(
        color:
            AppColors.primary,
        fontWeight:
            FontWeight.bold,
      ),
    ),
  ),
),

const SizedBox(
  height: 10,
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
                                : _login,
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
                                    Icons.login,
                                  ),
                                  SizedBox(
                                    width:
                                        8,
                                  ),
                                  Text(
                                    'Login',
                                    style:
                                        TextStyle(
                                      fontSize:
                                          16,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style:
                              TextStyle(
                            color:
                                AppColors.textSecondary,
                          ),
                        ),
                        TextButton(
                          onPressed:
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) =>
                                        const SignupScreen(),
                              ),
                            );
                          },
                          child:
                              const Text(
                            'Create Account',
                            style:
                                TextStyle(
                              color:
                                  AppColors.primary,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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
                     child: Wrap(
  alignment: WrapAlignment.center,
  crossAxisAlignment:
      WrapCrossAlignment.center,
  spacing: 8,
  runSpacing: 8,
  children: [
    const Text(
      'Need Assistance?',
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    ),

    const Icon(
      Icons.phone,
      size: 16,
      color: AppColors.gold,
    ),

    InkWell(
      onTap: _callSupport,
      child: const Text(
        '+91 89193 64223',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
          decoration:
              TextDecoration.underline,
        ),
      ),
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
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }
}