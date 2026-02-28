# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Google Fonts (sometimes uses reflection)
-keep class com.google.crypto.tink.** { *; }
-keep class com.google.gson.** { *; }

# Prevent stripping of generated plugin registrant
-keep class io.flutter.plugins.GeneratedPluginRegistrant { *; }

# Syncfusion PDF
-keep class com.syncfusion.** { *; }

# Google Play Core (Fix for R8 Missing Class errors)
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }
