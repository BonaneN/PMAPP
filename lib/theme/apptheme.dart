import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.violet,
    required this.success,
    required this.warning,
    required this.danger,
    required this.info,
    required this.pink,
  });

  final Color violet;
  final Color success;
  final Color warning;
  final Color danger;
  final Color info;
  final Color pink;

  List<Color> get palette => [violet, info, success, warning, pink, danger];

  @override
  AppColors copyWith({
    Color? violet,
    Color? success,
    Color? warning,
    Color? danger,
    Color? info,
    Color? pink,
  }) => AppColors(
    violet: violet ?? this.violet,
    success: success ?? this.success,
    warning: warning ?? this.warning,
    danger: danger ?? this.danger,
    info: info ?? this.info,
    pink: pink ?? this.pink,
  );

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      violet: Color.lerp(violet, other.violet, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      info: Color.lerp(info, other.info, t)!,
      pink: Color.lerp(pink, other.pink, t)!,
    );
  }
}

extension AppThemeContext on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
  ColorScheme get scheme => Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  /// A tinted surface for an accent colour, readable in both themes.
  Color soft(Color accent, {double? alpha}) => Color.alphaBlend(
    accent.withValues(alpha: alpha ?? (isDark ? .18 : .12)),
    scheme.surface,
  );
}

class AppTheme {
  static const _lightAccents = AppColors(
    violet: Color(0xFF6C4CF1),
    success: Color(0xFF0F9F78),
    warning: Color(0xFFD97706),
    danger: Color(0xFFE0383E),
    info: Color(0xFF2F7DF6),
    pink: Color(0xFFD6409F),
  );

  static const _darkAccents = AppColors(
    violet: Color(0xFFA08DFF),
    success: Color(0xFF3DD6A3),
    warning: Color(0xFFFFB020),
    danger: Color(0xFFFF6B70),
    info: Color(0xFF6AA5FF),
    pink: Color(0xFFFF7EC6),
  );

  static ThemeData get light => _build(dark: false);
  static ThemeData get dark => _build(dark: true);

  static ThemeData _build({required bool dark}) {
    final accents = dark ? _darkAccents : _lightAccents;
    final brightness = dark ? Brightness.dark : Brightness.light;

    final bg = dark ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
    final surface = dark ? const Color(0xFF111113) : const Color(0xFFFFFFFF);
    final onSurface = dark ? const Color(0xFFF4F4F6) : const Color(0xFF111114);
    final muted = dark ? const Color(0xFFA6A6B0) : const Color(0xFF5E5E68);
    final outline = dark ? const Color(0xFF6E6E7A) : const Color(0xFF8A8A96);
    final hairline = dark ? const Color(0xFF27272C) : const Color(0xFFE6E6EC);
    final primary = accents.violet;
    final onPrimary = dark ? const Color(0xFF0B0A12) : Colors.white;
    final primaryContainer = dark
        ? const Color(0xFF2A2250)
        : const Color(0xFFEAE5FF);
    final onPrimaryContainer = dark
        ? const Color(0xFFE6E0FF)
        : const Color(0xFF2B1A8A);
    final high = dark ? const Color(0xFF1C1C20) : const Color(0xFFFFFFFF);

    final scheme = ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: accents.success,
      onSecondary: dark ? const Color(0xFF00130C) : Colors.white,
      secondaryContainer: dark
          ? const Color(0xFF12332A)
          : const Color(0xFFD9F5EA),
      onSecondaryContainer: dark
          ? const Color(0xFFC8F5E4)
          : const Color(0xFF05402E),
      error: accents.danger,
      onError: dark ? const Color(0xFF1A0003) : Colors.white,
      surface: surface,
      onSurface: onSurface,
      onSurfaceVariant: muted,
      outline: outline,
      outlineVariant: hairline,
      surfaceTint: Colors.transparent,
      surfaceContainerLowest: dark ? Colors.black : Colors.white,
      surfaceContainerLow: dark
          ? const Color(0xFF0B0B0D)
          : const Color(0xFFF8F8FA),
      surfaceContainer: dark
          ? const Color(0xFF161618)
          : const Color(0xFFF2F2F6),
      surfaceContainerHigh: high,
      surfaceContainerHighest: dark
          ? const Color(0xFF26262B)
          : const Color(0xFFE8E8EE),
      inverseSurface: dark ? const Color(0xFFF2F2F5) : const Color(0xFF1B1A22),
      onInverseSurface: dark
          ? const Color(0xFF0F0F10)
          : const Color(0xFFF4F4F6),
      inversePrimary: dark ? const Color(0xFF6C4CF1) : const Color(0xFFB9A9FF),
      shadow: Colors.black,
      scrim: Colors.black,
    );

    final base = ThemeData(brightness: brightness, useMaterial3: true);
    final textTheme = base.textTheme.apply(
      bodyColor: onSurface,
      displayColor: onSurface,
    );

    RoundedRectangleBorder rounded(double r, {BorderSide? side}) =>
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(r),
          side: side ?? BorderSide.none,
        );

    WidgetStateProperty<Color?> overlay(Color color) =>
        WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return color.withValues(alpha: .16);
          }
          if (states.contains(WidgetState.hovered)) {
            return color.withValues(alpha: .09);
          }
          if (states.contains(WidgetState.focused)) {
            return color.withValues(alpha: .12);
          }
          return null;
        });

    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: color, width: width),
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      textTheme: textTheme,
      extensions: [accents],
      scaffoldBackgroundColor: bg,
      canvasColor: high,
      hoverColor: primary.withValues(alpha: .07),
      highlightColor: primary.withValues(alpha: .08),
      splashColor: primary.withValues(alpha: .12),
      focusColor: primary.withValues(alpha: .12),
      dividerColor: hairline,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
          TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: bg,
        foregroundColor: onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800,
          color: onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: rounded(20, side: BorderSide(color: hairline)),
        margin: EdgeInsets.zero,
      ),
      dividerTheme: DividerThemeData(color: hairline, space: 1, thickness: 1),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primary,
        selectionColor: primary.withValues(alpha: .35),
        selectionHandleColor: primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: dark ? const Color(0xFF161618) : Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: border(hairline),
        enabledBorder: border(dark ? const Color(0xFF34343A) : hairline),
        focusedBorder: border(primary, 1.8),
        errorBorder: border(accents.danger),
        focusedErrorBorder: border(accents.danger, 1.8),
        disabledBorder: border(hairline),
        hintStyle: TextStyle(color: muted.withValues(alpha: .85)),
        labelStyle: TextStyle(color: muted),
        floatingLabelStyle: TextStyle(
          color: primary,
          fontWeight: FontWeight.w600,
        ),
        helperStyle: TextStyle(color: muted),
        errorStyle: TextStyle(color: accents.danger),
        prefixIconColor: WidgetStateColor.resolveWith(
          (states) => states.contains(WidgetState.focused) ? primary : muted,
        ),
        suffixIconColor: muted,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(64, 54)),
          shape: WidgetStatePropertyAll(rounded(16)),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.disabled)
                ? onSurface.withValues(alpha: .12)
                : primary,
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.disabled)
                ? onSurface.withValues(alpha: .4)
                : onPrimary,
          ),
          overlayColor: overlay(onPrimary),
          elevation: const WidgetStatePropertyAll(0),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(64, 54)),
          shape: WidgetStatePropertyAll(rounded(16)),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          foregroundColor: WidgetStatePropertyAll(onSurface),
          side: WidgetStatePropertyAll(
            BorderSide(color: dark ? const Color(0xFF3A3A41) : outline),
          ),
          overlayColor: overlay(primary),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(primary),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(fontWeight: FontWeight.w700),
          ),
          shape: WidgetStatePropertyAll(rounded(12)),
          overlayColor: overlay(primary),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(onSurface),
          overlayColor: overlay(onSurface),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: onSurface,
        foregroundColor: surface,
        elevation: 4,
        shape: rounded(20),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surface,
        selectedColor: primaryContainer,
        side: BorderSide(color: hairline),
        labelStyle: TextStyle(color: muted, fontWeight: FontWeight.w600),
        shape: const StadiumBorder(),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: muted,
        textColor: onSurface,
        selectedColor: primary,
        selectedTileColor: primary.withValues(alpha: .1),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected) ? onPrimary : outline,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? primary
              : (dark ? const Color(0xFF26262B) : const Color(0xFFE8E8EE)),
        ),
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? Colors.transparent
              : outline.withValues(alpha: .6),
        ),
        overlayColor: overlay(primary),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: high,
        surfaceTintColor: Colors.transparent,
        shape: rounded(28, side: dark ? BorderSide(color: hairline) : null),
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800,
          color: onSurface,
        ),
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: muted),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: high,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: high,
        surfaceTintColor: Colors.transparent,
        elevation: 6,
        shape: rounded(16, side: BorderSide(color: hairline)),
        textStyle: TextStyle(color: onSurface, fontWeight: FontWeight.w600),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(high),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        ),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: high,
        surfaceTintColor: Colors.transparent,
        shape: rounded(28),
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: high,
        shape: rounded(28),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: TextStyle(
          color: scheme.onInverseSurface,
          fontWeight: FontWeight.w600,
        ),
        actionTextColor: scheme.inversePrimary,
        shape: rounded(16),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primary,
        linearTrackColor: primaryContainer,
        circularTrackColor: primaryContainer,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: scheme.inverseSurface,
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: TextStyle(color: scheme.onInverseSurface, fontSize: 12),
      ),
    );
  }
}
