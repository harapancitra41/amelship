# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Keep Flame engine classes
-keep class flame.** { *; }
-keep class flame.audio.** { *; }
-keep class flame.collisions.** { *; }
-keep class flame.components.** { *; }
-keep class flame.effects.** { *; }
-keep class flame.particles.** { *; }

# Hive
-keep class hive.** { *; }
-keep class ** extends com.google.protobuf.GeneratedMessageLite { *; }

# Provider
-keep class ** extends dagger.** { *; }
-keep class ** extends javax.inject.** { *; }
