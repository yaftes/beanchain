import 'package:beanchain/features/auth/presentation/pages/login_page.dart';
import 'package:beanchain/features/auth/presentation/widgets/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      final confirm = _confirmController.text;

      if (password != confirm) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
        return;
      }

      print("Registering user: $name, $email");
      // TODO: Add Firebase or backend logic
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,

      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/coffee_background.jpg', fit: BoxFit.cover),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),

                    Column(
                      children: [
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: ScaleTransition(
                            scale: _scaleAnimation,
                            child: Text(
                              "Brew Your Perfect Start!",
                              style: GoogleFonts.poppins(
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "Sign up to explore and track premium coffee from farm to cup.",
                      style: GoogleFonts.poppins(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    // Email
                    TextFormField(
                      controller: _emailController,
                      decoration: buildinputDecoration(
                        "Email",
                        "luna@gmail.com",
                        Icons.email,
                      ),
                      validator:
                          (value) =>
                              value == null || !value.contains('@')
                                  ? "Enter valid email"
                                  : null,
                    ),

                    const SizedBox(height: 20),

                    // Password
                    TextFormField(
                      controller: _passwordController,
                      decoration: buildinputDecoration(
                        "Password",
                        "alskldgl",
                        Icons.lock,
                      ),
                      obscureText: true,
                      validator:
                          (value) =>
                              value != null && value.length < 6
                                  ? "Password must be at least 6 characters"
                                  : null,
                    ),

                    const SizedBox(height: 20),

                    // Confirm Password
                    TextFormField(
                      controller: _confirmController,
                      decoration: buildinputDecoration(
                        "Confirm Password",
                        "alsdlkgjl",
                        Icons.lock_outline,
                      ),
                      obscureText: true,
                      validator:
                          (value) =>
                              value != _passwordController.text
                                  ? "Passwords do not match"
                                  : null,
                    ),

                    const SizedBox(height: 30),

                    ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[600],
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Register",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    GestureDetector(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          ),
                      child: Center(
                        child: Text.rich(
                          TextSpan(
                            text: "Already part of the Coffee Family? ",
                            style: GoogleFonts.poppins(
                              color: Colors.brown[100],
                            ),
                            children: [
                              TextSpan(
                                text: "Login",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
