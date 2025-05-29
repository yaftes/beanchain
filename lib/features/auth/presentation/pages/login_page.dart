// import 'package:beanchain/features/auth/data/services/auth_services.dart';
// import 'package:beanchain/features/auth/presentation/pages/register_page.dart';
// import 'package:beanchain/features/auth/presentation/widgets/input_decoration.dart';
// import 'package:beanchain/features/coffee/presentation/pages/issue_report_page.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:lottie/lottie.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final AuthServices _authServices = AuthServices();

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   late AnimationController _animationController;
//   late AnimationController _lottieController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//   late Animation<Offset> _textSlideAnimation;

//   bool _isLoading = false;
//   bool _obscurePassword = true;

//   @override
//   void initState() {
//     super.initState();

//     _animationController = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );

//     _lottieController = AnimationController(vsync: this);

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
//     );

//     _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
//     );

//     _textSlideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.5),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
//     );

//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     _lottieController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder:
//           (context) => AlertDialog(
//             backgroundColor: Colors.brown[50],
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             title: Row(
//               children: const [
//                 Icon(Icons.error_outline, color: Colors.red),
//                 SizedBox(width: 8),
//                 Text(
//                   "Oops!",
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),
//               ],
//             ),
//             content: Text(
//               message,
//               style: const TextStyle(color: Colors.black87, fontSize: 16),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: const Text(
//                   "OK",
//                   style: TextStyle(
//                     color: Colors.brown,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//     );
//   }

//   void signInWithEmail() async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() => _isLoading = true);

//     final user = await _authServices.signInWithEmail(
//       _emailController.text.trim(),
//       _passwordController.text.trim(),
//     );

//     setState(() => _isLoading = false);

//     if (user != null) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => IssueReportPage()),
//       );
//     } else {
//       _showErrorDialog(
//         "Sorry, failed to login. Please check your credentials.",
//       );
//     }
//   }

//   void signInWithGoogle() async {
//     setState(() => _isLoading = true);

//     final user = await _authServices.signInWithGoogle();

//     setState(() => _isLoading = false);

//     if (user != null) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => IssueReportPage()),
//       );
//     } else {
//       _showErrorDialog("Google login failed. Check your connection.");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         backgroundColor: Colors.white.withOpacity(0.95),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//             child: Center(
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       FadeTransition(
//                         opacity: _fadeAnimation,
//                         child: ScaleTransition(
//                           scale: _scaleAnimation,
//                           child: SizedBox(
//                             height: 300,
//                             child: Lottie.asset(
//                               'assets/lottie/coffee_login.json',
//                               controller: _lottieController,
//                               fit: BoxFit.contain,
//                               onLoaded: (composition) {
//                                 _lottieController
//                                   ..duration = composition.duration * 1.2
//                                   ..forward(); // Only play once
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 40),
//                       TextFormField(
//                         style: const TextStyle(color: Colors.brown),
//                         controller: _emailController,
//                         decoration: buildinputDecoration(
//                           AppLocalizations.of(context)!.loginPageFormEmailLabel,
//                           AppLocalizations.of(context)!.loginPageFormEmailHint,
//                           Icons.email,
//                         ),
//                         keyboardType: TextInputType.emailAddress,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return AppLocalizations.of(
//                               context,
//                             )!.loginPageFormEmailValidationRequired;
//                           }
//                           if (!RegExp(
//                             r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
//                           ).hasMatch(value)) {
//                             return AppLocalizations.of(
//                               context,
//                             )!.loginPageFormEmailValidationRequired;
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16),
//                       TextFormField(
//                         style: const TextStyle(color: Colors.brown),
//                         controller: _passwordController,
//                         decoration: buildinputDecoration(
//                           AppLocalizations.of(
//                             context,
//                           )!.loginPageFormPasswordLabel,
//                           AppLocalizations.of(
//                             context,
//                           )!.loginPageFormPasswordLabel,
//                           Icons.lock,
//                         ).copyWith(
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _obscurePassword
//                                   ? Icons.visibility_off
//                                   : Icons.visibility,
//                               color: Colors.brown,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _obscurePassword = !_obscurePassword;
//                               });
//                             },
//                           ),
//                         ),
//                         obscureText: _obscurePassword,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return AppLocalizations.of(
//                               context,
//                             )!.loginPageFormEmailValidationRequired;
//                           }
//                           if (value.length < 6) {
//                             return AppLocalizations.of(
//                               context,
//                             )!.loginPageFormPasswordValidationMinLength;
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 24),
//                       _isLoading
//                           ? const CircularProgressIndicator(color: Colors.brown)
//                           : ElevatedButton(
//                             onPressed: signInWithEmail,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.brown[600],
//                               foregroundColor: Colors.white,
//                               minimumSize: const Size.fromHeight(50),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: Text(
//                               AppLocalizations.of(
//                                 context,
//                               )!.loginPageButtonsLogin,
//                               style: GoogleFonts.poppins(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                       const SizedBox(height: 30),
//                       ElevatedButton.icon(
//                         onPressed: signInWithGoogle,
//                         icon: Image.asset(
//                           'assets/images/google_logo.png',
//                           height: 24,
//                           width: 24,
//                         ),
//                         label: Text(
//                           AppLocalizations.of(
//                             context,
//                           )!.loginPageButtonsSignInWithGoogle,
//                           style: GoogleFonts.poppins(
//                             fontSize: 16,
//                             color: Colors.black,
//                           ),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           minimumSize: const Size.fromHeight(50),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             side: const BorderSide(color: Colors.brown),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       GestureDetector(
//                         onTap:
//                             () => Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const RegisterPage(),
//                               ),
//                             ),
//                         child: Text.rich(
//                           TextSpan(
//                             text:
//                                 AppLocalizations.of(
//                                   context,
//                                 )!.loginPageRegisterPrompt,
//                             style: GoogleFonts.poppins(
//                               fontSize: 14,
//                               color: Colors.brown[300],
//                             ),
//                             children: [
//                               TextSpan(
//                                 text:
//                                     AppLocalizations.of(
//                                       context,
//                                     )!.loginPageRegisterLink,
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.brown[800],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
