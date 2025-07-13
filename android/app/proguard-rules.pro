# Flutter-specific rules.
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.embedding.**  { *; }
-keep class io.flutter.plugins.**  { *; }
# Add these rules
-keep class com.stripe.android.** { *; }
-keep class com.stripe.android.model.** { *; }
-keep class com.stripe.android.net.** { *; }
-keep class com.stripe.android.view.** { *; }
-keep class com.stripe.android.pushProvisioning.** { *; }
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn com.stripe.android.pushProvisioning.**

# Google Play Core library
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**
-keep class io.flutter.embedding.android.FlutterPlayStoreSplitApplication

