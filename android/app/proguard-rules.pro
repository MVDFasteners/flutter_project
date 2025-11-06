# Keep Flutter classes
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep classes used for JSON (Gson)
-keep class com.google.gson.** { *; }

# Keep all classes in your app package
-keep class com.mvd.hrtrip.** { *; }

# Keep Firebase and Google Play Services
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Don’t warn about missing classes
-dontwarn io.flutter.embedding.**
-dontwarn com.google.firebase.**
