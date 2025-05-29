import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:beanchain/features/coffee/presentation/pages/qr_code_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  final void Function(Locale)? onChangeLanguage;
  final bool isLoggedIn;
  const HomePage({super.key, this.onChangeLanguage, this.isLoggedIn = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 250,
                child: Image.asset(
                  "assets/images/coffee.jpg",
                  fit: BoxFit.cover,
                ),
              ),

              Positioned.fill(
                child: Center(
                  child: Text(
                    // AppLocalizations.of(context)!.appTitle,
                    "Fist",
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 2),
                          blurRadius: 6,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.brown[50]?.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.brown.shade200),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.language, color: Colors.brown),
                      const SizedBox(width: 8),
                      // Theme(
                      //   data: Theme.of(context).copyWith(
                      //     canvasColor: Colors.brown[50],
                      //     cardColor: Colors.brown[50],
                      //     shadowColor: Colors.brown.shade400,
                      //     popupMenuTheme: PopupMenuThemeData(
                      //       color: Colors.brown[50],
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(20),
                      //       ),
                      //       elevation: 8,
                      //     ),
                      //   ),

                      //   child: DropdownButtonHideUnderline(
                      //     child: DropdownButton<Locale>(
                      //       value: currentLocale,
                      //       icon: const Icon(
                      //         Icons.arrow_drop_down,
                      //         color: Colors.brown,
                      //       ),
                      //       dropdownColor: Colors.brown[50],
                      //       style: GoogleFonts.poppins(
                      //         color: Colors.brown[900],
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //       items: const [
                      //         DropdownMenuItem(
                      //           value: Locale('en'),
                      //           child: Text('English'),
                      //         ),
                      //         DropdownMenuItem(
                      //           value: Locale('am'),
                      //           child: Text('አማርኛ'),
                      //         ),
                      //       ],
                      //       onChanged: (locale) {
                      //         if (locale != null && onChangeLanguage != null) {
                      //           onChangeLanguage!(locale);
                      //         }
                      //       },
                      //     ),
                      //   ),

                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/coffee_journey.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 30),

                    Center(
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TyperAnimatedText(
                            "lkjsldgjkl",
                            textStyle: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.brown[800],
                            ),
                            speed: const Duration(milliseconds: 110),
                          ),
                        ],
                        isRepeatingAnimation: true,
                        totalRepeatCount: 5,
                        pause: const Duration(seconds: 2),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Lottie.asset(
                      'assets/lottie/coffee_brew.json',
                      width: 180,
                      height: 180,
                      repeat: true,
                    ),

                    const Spacer(),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QRScannerPage(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.qr_code_scanner_rounded),
                          label: Text(
                            "QR Code Scanner",
                            style: GoogleFonts.poppins(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown[700],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
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
