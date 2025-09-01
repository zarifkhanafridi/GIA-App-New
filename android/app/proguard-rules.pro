# Keep NewPipeExtractor classes (they use reflection internally)
-keep class org.schabi.newpipe.extractor.** { *; }

# Suppress references to Java Beans and Scripting APIs not present on Android
-dontwarn java.beans.**
-dontwarn javax.script.**

# Suppress any auxiliary Rhino warnings
-dontwarn org.mozilla.classfile.**
-dontwarn org.mozilla.javascript.engine.**

# Keep annotations and signatures (can help reflection)
-keepattributes Signature, *Annotation*
