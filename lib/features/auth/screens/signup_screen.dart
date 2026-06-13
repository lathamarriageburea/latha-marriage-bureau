import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';

import '../services/auth_service.dart';
import '../../registration/screens/registration_wizard.dart';
import 'login_screen.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({
    super.key,
  });

  @override
  State<SignupScreen> createState() =>
      _SignupScreenState();
}

class _SignupScreenState
    extends State<SignupScreen> {
  final _emailController =
      TextEditingController();

  final _passwordController =
      TextEditingController();
  
  final _confirmPasswordController =
    TextEditingController();

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  bool _loading = false;

  bool _obscurePassword = true;

  Future<void> _callSupport() async {
  final Uri phoneUri = Uri(
    scheme: 'tel',
    path: '+91 8919364223',
  );

  await launchUrl(phoneUri);
}

  Future<void> _register() async {
    setState(() {
  _emailError = null;
  _passwordError = null;
  _confirmPasswordError = null;
});

    bool isValid = true;

    final email =
    _emailController.text.trim();

if (email.isEmpty) {

  _emailError =
      'Please enter email address';

  isValid = false;

} else if (!RegExp(
        r'^[^@]+@[^@]+\.[^@]+$')
    .hasMatch(email)) {

  _emailError =
      'Please enter valid email';

  isValid = false;
}

    final password =
    _passwordController.text.trim();

if (password.isEmpty) {

  _passwordError =
      'Please enter password';

  isValid = false;

} else if (password.length < 6) {

  _passwordError =
      'Minimum 6 characters required';

  isValid = false;
}
 
 if (_confirmPasswordController
    .text
    .trim()
    .isEmpty) {

  _confirmPasswordError =
      'Please confirm password';

  isValid = false;
}

if (_passwordController.text
        .trim() !=
    _confirmPasswordController
        .text
        .trim()) {

  _confirmPasswordError =
      'Passwords do not match';

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

      await AuthService().signUp(
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
            'Registration Successful',
          ),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const RegistrationWizard(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
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
                      'Create Your Account',
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

                    const SizedBox(
  height: 20,
),

TextField(
  controller:
      _confirmPasswordController,

  obscureText:
      _obscurePassword,

  decoration:
      InputDecoration(
    labelText:
        'Confirm Password',

    errorText:
        _confirmPasswordError,

    filled: true,

    fillColor:
        AppColors.ivory,

    prefixIcon:
        const Icon(
      Icons.lock_outline,
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
                                : _register,
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
                                    Icons.person_add,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Create Account',
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
                      height: 12,
                    ),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style:
                              TextStyle(
                            color:
                                AppColors.textSecondary,
                          ),
                        ),
                        TextButton(
                          onPressed:
                              () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) =>
                                        const LoginScreen(),
                              ),
                            );
                          },
                          child:
                              const Text(
                            'Login',
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
                      child:
                      Column(
  children: [

    Wrap(
  alignment: WrapAlignment.center,
  crossAxisAlignment:
      WrapCrossAlignment.center,
  spacing: 6,
  runSpacing: 6,
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

    const SizedBox(
      height: 10,
    ),

    const Text(
      'Create your account and complete your matrimonial profile to start finding suitable matches.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12,
        color: AppColors.textSecondary,
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
    _confirmPasswordController.dispose();

    super.dispose();
  }
}