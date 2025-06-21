#!/bin/bash

echo "🚧 حذف أثر pyjnius القديم..."
rm -rf .buildozer/android/platform/build-*/build/other_builds/pyjnius*

echo "📁 إنشاء مجلد جديد لـ pyjnius..."
mkdir -p .buildozer/android/platform/build-*/build/other_builds/pyjnius-sdl2/armeabi-v7a__ndk_target_23/pyjnius

echo "⬇️ تحميل pyjnius من GitHub..."
git clone https://github.com/kivy/pyjnius.git temp_pyjnius

echo "📦 نسخ ملفات pyjnius إلى مجلد البناء..."
cp -r temp_pyjnius/* .buildozer/android/platform/build-*/build/other_builds/pyjnius-sdl2/armeabi-v7a__ndk_target_23/pyjnius/

echo "🧹 تنظيف التحميل المؤقت..."
rm -rf temp_pyjnius

echo "🚀 إعادة بناء التطبيق..."
buildozer android debug
