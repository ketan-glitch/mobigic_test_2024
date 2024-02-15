import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color textPrimary = Color(0xff000000);
const Color textSecondary = Color(0xff838383);

class CustomDecoration {
  static InputDecoration inputDecoration({
    String? icon,
    String? prefixText,
    String? label,
    String? hint,
    TextStyle? hintStyle,
    Widget? suffix,
    bool floating = false,
    Color color = Colors.transparent,
  }) {
    assert(prefixText == null || icon == null, "Strings are equal So this message is been displayed!!");

    return InputDecoration(
      fillColor: const Color(0xFFF1F1F1),
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 0.4),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 0.4),
      ),
      errorStyle: GoogleFonts.roboto(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: Colors.redAccent,
      ),
      prefixIcon: (icon != null || prefixText != null)
          ? Builder(
              builder: (context) {
                if (prefixText != null) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 10.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          prefixText,
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: textSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            )
          : null,
      suffixIcon: suffix,
      label: label != null
          ? Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: textSecondary,
                ),
              ),
            )
          : null,
      hintText: hint ?? label,
      hintStyle: hintStyle ??
          GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textSecondary,
          ),
      floatingLabelBehavior: floating ? FloatingLabelBehavior.auto : FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 30, 13),
    );
  }
}
