import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.example.bobofood"
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        // 启用核心库脱糖以支持 Java 8 特性
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.bobofood"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = (keystoreProperties["keyAlias"] as? String)
            ?: error("keyAlias is missing in key.properties")
        keyPassword = (keystoreProperties["keyPassword"] as? String)
            ?: error("keyPassword is missing in key.properties")
        storeFile = (keystoreProperties["storeFile"] as? String)?.let { file(it) }
            ?: error("storeFile is missing in key.properties")
        storePassword = (keystoreProperties["storePassword"] as? String)
            ?: error("storePassword is missing in key.properties")
        }
        getByName("debug") {
            keyAlias = (keystoreProperties["keyAlias"] as? String)
            ?: error("keyAlias is missing in key.properties")
        keyPassword = (keystoreProperties["keyPassword"] as? String)
            ?: error("keyPassword is missing in key.properties")
        storeFile = (keystoreProperties["storeFile"] as? String)?.let { file(it) }
            ?: error("storeFile is missing in key.properties")
        storePassword = (keystoreProperties["storePassword"] as? String)
            ?: error("storePassword is missing in key.properties")
        }
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("release")
        }
        debug {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // 添加脱糖库依赖
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("com.amap.api:location:6.1.0") // ✅ 或者使用新版如 6.1.0
}
