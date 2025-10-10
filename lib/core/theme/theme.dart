// Generated using the Material Theme Builder
// https://material-foundation.github.io/material-theme-builder/

import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff4d026b),
      surfaceTint: Color(0xff8441a0),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff662483),
      onPrimaryContainer: Color(0xffde95fa),
      secondary: Color(0xff71547b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfff5d1fe),
      onSecondaryContainer: Color(0xff73567d),
      tertiary: Color(0xff5f0033),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff7d1c4a),
      onTertiaryContainer: Color(0xffff8db8),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff7fb),
      onSurface: Color(0xff1f1a20),
      onSurfaceVariant: Color(0xff4d4350),
      outline: Color(0xff7f7381),
      outlineVariant: Color(0xffd0c2d1),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff342e35),
      inversePrimary: Color(0xffebb2ff),
      primaryFixed: Color(0xfff8d8ff),
      onPrimaryFixed: Color(0xff320047),
      primaryFixedDim: Color(0xffebb2ff),
      onPrimaryFixedVariant: Color(0xff692886),
      secondaryFixed: Color(0xfff8d8ff),
      onSecondaryFixed: Color(0xff291134),
      secondaryFixedDim: Color(0xffdebbe7),
      onSecondaryFixedVariant: Color(0xff583d62),
      tertiaryFixed: Color(0xffffd9e3),
      onTertiaryFixed: Color(0xff3e0020),
      tertiaryFixedDim: Color(0xffffb0cb),
      onTertiaryFixedVariant: Color(0xff81204d),
      surfaceDim: Color(0xffe1d7e0),
      surfaceBright: Color(0xfffff7fb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffcf0f9),
      surfaceContainer: Color(0xfff6ebf4),
      surfaceContainerHigh: Color(0xfff0e5ee),
      surfaceContainerHighest: Color(0xffeadfe8),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff4d026b),
      surfaceTint: Color(0xff8441a0),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff662483),
      onPrimaryContainer: Color(0xfff5ceff),
      secondary: Color(0xff462c50),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff80638a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff5f0033),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff7d1c4a),
      onTertiaryContainer: Color(0xffffcedd),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff7fb),
      onSurface: Color(0xff141015),
      onSurfaceVariant: Color(0xff3c333f),
      outline: Color(0xff5a4f5b),
      outlineVariant: Color(0xff756976),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff342e35),
      inversePrimary: Color(0xffebb2ff),
      primaryFixed: Color(0xff9451b0),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff793796),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff80638a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff664b71),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xffb24774),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff932f5c),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffcec3cc),
      surfaceBright: Color(0xfffff7fb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffcf0f9),
      surfaceContainer: Color(0xfff0e5ee),
      surfaceContainerHigh: Color(0xffe4dae3),
      surfaceContainerHighest: Color(0xffd9cfd7),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff4b0069),
      surfaceTint: Color(0xff8441a0),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff662483),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff3b2245),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5a3f64),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff5c0032),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff7d1c4a),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff7fb),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff322934),
      outlineVariant: Color(0xff504652),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff342e35),
      inversePrimary: Color(0xffebb2ff),
      primaryFixed: Color(0xff6c2a89),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff530c70),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5a3f64),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff42294c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff842250),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff660539),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc0b6be),
      surfaceBright: Color(0xfffff7fb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff9edf7),
      surfaceContainer: Color(0xffeadfe8),
      surfaceContainerHigh: Color(0xffdcd1da),
      surfaceContainerHighest: Color(0xffcec3cc),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffebb2ff),
      surfaceTint: Color(0xffebb2ff),
      onPrimary: Color(0xff50076e),
      primaryContainer: Color(0xff662483),
      onPrimaryContainer: Color(0xffde95fa),
      secondary: Color(0xffdebbe7),
      onSecondary: Color(0xff40264a),
      secondaryContainer: Color(0xff5a3f64),
      onSecondaryContainer: Color(0xffcfadd9),
      tertiary: Color(0xffffb0cb),
      onTertiary: Color(0xff630236),
      tertiaryContainer: Color(0xff7d1c4a),
      onTertiaryContainer: Color(0xffff8db8),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff171218),
      onSurface: Color(0xffeadfe8),
      onSurfaceVariant: Color(0xffd0c2d1),
      outline: Color(0xff998d9b),
      outlineVariant: Color(0xff4d4350),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffeadfe8),
      inversePrimary: Color(0xff8441a0),
      primaryFixed: Color(0xfff8d8ff),
      onPrimaryFixed: Color(0xff320047),
      primaryFixedDim: Color(0xffebb2ff),
      onPrimaryFixedVariant: Color(0xff692886),
      secondaryFixed: Color(0xfff8d8ff),
      onSecondaryFixed: Color(0xff291134),
      secondaryFixedDim: Color(0xffdebbe7),
      onSecondaryFixedVariant: Color(0xff583d62),
      tertiaryFixed: Color(0xffffd9e3),
      onTertiaryFixed: Color(0xff3e0020),
      tertiaryFixedDim: Color(0xffffb0cb),
      onTertiaryFixedVariant: Color(0xff81204d),
      surfaceDim: Color(0xff171218),
      surfaceBright: Color(0xff3d373e),
      surfaceContainerLowest: Color(0xff110d12),
      surfaceContainerLow: Color(0xff1f1a20),
      surfaceContainer: Color(0xff231e24),
      surfaceContainerHigh: Color(0xff2e282f),
      surfaceContainerHighest: Color(0xff39333a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff5d0ff),
      surfaceTint: Color(0xffebb2ff),
      onPrimary: Color(0xff41005c),
      primaryContainer: Color(0xffbb75d7),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff4d0fe),
      onSecondary: Color(0xff341c3e),
      secondaryContainer: Color(0xffa686af),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffd0de),
      onTertiary: Color(0xff50002b),
      tertiaryContainer: Color(0xffde6a98),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff171218),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffe7d8e7),
      outline: Color(0xffbbaebc),
      outlineVariant: Color(0xff998c9a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffeadfe8),
      inversePrimary: Color(0xff6b2988),
      primaryFixed: Color(0xfff8d8ff),
      onPrimaryFixed: Color(0xff220032),
      primaryFixedDim: Color(0xffebb2ff),
      onPrimaryFixedVariant: Color(0xff571274),
      secondaryFixed: Color(0xfff8d8ff),
      onSecondaryFixed: Color(0xff1e0628),
      secondaryFixedDim: Color(0xffdebbe7),
      onSecondaryFixedVariant: Color(0xff462c50),
      tertiaryFixed: Color(0xffffd9e3),
      onTertiaryFixed: Color(0xff2b0014),
      tertiaryFixedDim: Color(0xffffb0cb),
      onTertiaryFixedVariant: Color(0xff6b0b3c),
      surfaceDim: Color(0xff171218),
      surfaceBright: Color(0xff494249),
      surfaceContainerLowest: Color(0xff0a060b),
      surfaceContainerLow: Color(0xff211c22),
      surfaceContainer: Color(0xff2c262d),
      surfaceContainerHigh: Color(0xff373137),
      surfaceContainerHighest: Color(0xff423c43),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffdeaff),
      surfaceTint: Color(0xffebb2ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffe9acff),
      onPrimaryContainer: Color(0xff190026),
      secondary: Color(0xfffdeaff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffdab7e3),
      onSecondaryContainer: Color(0xff170222),
      tertiary: Color(0xffffebef),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffffaac7),
      onTertiaryContainer: Color(0xff20000e),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff171218),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfffbebfb),
      outlineVariant: Color(0xffcdbecd),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffeadfe8),
      inversePrimary: Color(0xff6b2988),
      primaryFixed: Color(0xfff8d8ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffebb2ff),
      onPrimaryFixedVariant: Color(0xff220032),
      secondaryFixed: Color(0xfff8d8ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffdebbe7),
      onSecondaryFixedVariant: Color(0xff1e0628),
      tertiaryFixed: Color(0xffffd9e3),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffb0cb),
      onTertiaryFixedVariant: Color(0xff2b0014),
      surfaceDim: Color(0xff171218),
      surfaceBright: Color(0xff554e55),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff231e24),
      surfaceContainer: Color(0xff342e35),
      surfaceContainerHigh: Color(0xff403940),
      surfaceContainerHighest: Color(0xff4b454c),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
