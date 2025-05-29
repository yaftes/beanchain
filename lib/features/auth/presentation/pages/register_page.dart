// import 'package:beanchain/features/auth/data/services/auth_services.dart';
// import 'package:beanchain/features/auth/presentation/pages/login_page.dart';
// import 'package:beanchain/features/auth/presentation/widgets/input_decoration.dart';
// import 'package:beanchain/features/coffee/presentation/pages/issue_report_page.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:lottie/lottie.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage>
//     with TickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmController = TextEditingController();

//   final AuthServices _authServices = AuthServices();

//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;

//   bool _isLoading = false;
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;

//   @override
//   void initState() {
//     super.initState();

//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
//     );

//     _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
//     );
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmController.dispose();
//     super.dispose();
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(content: Text(message)),
//     );
//   }

//   void _register() async {
//     if (!_formKey.currentState!.validate()) return;

//     final email = _emailController.text.trim();
//     final password = _passwordController.text;
//     final confirm = _confirmController.text;

//     if (password != confirm) {
//       _showErrorDialog(
//         AppLocalizations.of(context)!.registerPageErrorPasswordMismatch,
//       );
//       return;
//     }

//     setState(() => _isLoading = true);

//     final user = await _authServices.signUpWithEmail(email, password);

//     setState(() => _isLoading = false);

//     if (user != null) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const IssueReportPage()),
//       );
//     } else {
//       _showErrorDialog(
//         AppLocalizations.of(context)!.registerPageErrorAlreadyRegistered,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final local = AppLocalizations.of(context)!;

//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         extendBodyBehindAppBar: true,
//         backgroundColor: Colors.white.withOpacity(0.95),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(24),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 10),
//                   Center(
//                     child: Lottie.asset(
//                       'assets/lottie/coffee_login.json',
//                       height: 280,
//                       controller: _animationController,
//                       onLoaded: (composition) async {
//                         _animationController.duration =
//                             composition.duration * 1.1;

//                         await Future.delayed(const Duration(milliseconds: 500));

//                         if (mounted) {
//                           _animationController.forward();
//                         }
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   FadeTransition(
//                     opacity: _fadeAnimation,
//                     child: ScaleTransition(
//                       scale: _scaleAnimation,
//                       child: Text(
//                         local.registerPageTitle,
//                         style: GoogleFonts.poppins(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.brown[800],
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   /// Email
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: buildinputDecoration(
//                       local.registerPageFormEmailLabel,
//                       local.registerPageFormEmailHint,
//                       Icons.email,
//                     ),
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return local.registerPageFormEmailValidationRequired;
//                       }
//                       if (!RegExp(
//                         r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
//                       ).hasMatch(value)) {
//                         return local.registerPageFormEmailValidationInvalid;
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),

//                   /// Password
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: _obscurePassword,
//                     decoration: buildinputDecoration(
//                       local.registerPageFormPasswordLabel,
//                       local.registerPageFormPasswordHint,
//                       Icons.lock,
//                     ).copyWith(
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _obscurePassword
//                               ? Icons.visibility_off
//                               : Icons.visibility,
//                           color: Colors.brown,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _obscurePassword = !_obscurePassword;
//                           });
//                         },
//                       ),
//                     ),
//                     validator:
//                         (value) =>
//                             value == null || value.length < 6
//                                 ? local
//                                     .registerPageFormPasswordValidationMinLength
//                                 : null,
//                   ),
//                   const SizedBox(height: 20),

//                   /// Confirm Password
//                   TextFormField(
//                     controller: _confirmController,
//                     obscureText: _obscureConfirmPassword,
//                     decoration: buildinputDecoration(
//                       local.registerPageFormConfirmPasswordLabel,
//                       local.registerPageFormConfirmPasswordHint,
//                       Icons.lock_outline,
//                     ).copyWith(
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _obscureConfirmPassword
//                               ? Icons.visibility_off
//                               : Icons.visibility,
//                           color: Colors.brown,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _obscureConfirmPassword = !_obscureConfirmPassword;
//                           });
//                         },
//                       ),
//                     ),
//                     validator:
//                         (value) =>
//                             value != _passwordController.text
//                                 ? local
//                                     .registerPageFormConfirmPasswordValidationMatch
//                                 : null,
//                   ),
//                   const SizedBox(height: 30),

//                   /// Register Button
//                   _isLoading
//                       ? const Center(
//                         child: CircularProgressIndicator(color: Colors.brown),
//                       )
//                       : ElevatedButton(
//                         onPressed: _register,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.brown[600],
//                           foregroundColor: Colors.white,
//                           minimumSize: const Size.fromHeight(50),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: Text(
//                           local.registerPageButtonsRegister,
//                           style: GoogleFonts.poppins(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                   const SizedBox(height: 20),

//                   /// Login Redirect
//                   GestureDetector(
//                     onTap:
//                         () => Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const LoginPage(),
//                           ),
//                         ),
//                     child: Center(
//                       child: Text.rich(
//                         TextSpan(
//                           text: local.registerPageLoginPrompt,
//                           style: GoogleFonts.poppins(color: Colors.brown[400]),
//                           children: [
//                             TextSpan(
//                               text: local.registerPageLoginLink,
//                               style: GoogleFonts.poppins(
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.brown[800],
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
