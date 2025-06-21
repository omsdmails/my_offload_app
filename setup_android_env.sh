#!/bin/bash

# مسار التثبيت
ANDROID_DIR="$HOME/Android"
SDK_DIR="$ANDROID_DIR/Sdk"
NDK_VERSION="r25b"
NDK_FOLDER="android-ndk-$NDK_VERSION"

echo "📦 إنشاء مجلد Android في $ANDROID_DIR..."
mkdir -p "$SDK_DIR"

cd "$ANDROID_DIR"

echo "🌐 تنزيل Command Line Tools..."
wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O cmdline-tools.zip

echo "📦 فك الضغط..."
unzip cmdline-tools.zip -d "$SDK_DIR/cmdline-tools"
mv "$SDK_DIR/cmdline-tools/cmdline-tools" "$SDK_DIR/cmdline-tools/latest"
rm cmdline-tools.zip

export ANDROID_HOME="$SDK_DIR"
export ANDROID_SDK_ROOT="$SDK_DIR"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH"

echo "✅ إعداد SDK Manager..."
yes | sdkmanager --licenses

echo "⬇️ تنزيل الأدوات اللازمة..."
sdkmanager "platform-tools" "platforms;android-31" "build-tools;31.0.0"

echo "⬇️ تنزيل Android NDK ($NDK_VERSION)..."
wget https://dl.google.com/android/repository/android-ndk-${NDK_VERSION}-linux.zip -O ndk.zip
unzip ndk.zip -d "$SDK_DIR"
rm ndk.zip

echo "✅ NDK تم تثبيته في $SDK_DIR/$NDK_FOLDER"

# إعداد بيئة Buildozer
echo "🛠️ ربط Buildozer ببيئة SDK/NDK..."
export ANDROIDNDK="$SDK_DIR/$NDK_FOLDER"
export ANDROIDSDK="$SDK_DIR"
export ANDROIDAPI="31"
export ANDROIDMINAPI="23"

echo '✅ تم ضبط المتغيرات التالية:'
echo "ANDROIDNDK=$ANDROIDNDK"
echo "ANDROIDSDK=$ANDROIDSDK"
echo "ANDROIDAPI=$ANDROIDAPI"
echo "ANDROIDMINAPI=$ANDROIDMINAPI"

echo "💡 يمكنك إضافة هذه المتغيرات إلى ~/.bashrc أو ~/.zshrc"

echo "🚀 اختبار Buildozer:"
buildozer android clean
buildozer -v android debug
