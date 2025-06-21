#!/bin/bash

echo "🚫 إزالة متغير البيئة ANDROIDAPI..."
unset ANDROIDAPI

echo "✅ تعديل ملف buildozer.spec لفرض API 30..."
if ! grep -q "^android.api = 30" buildozer.spec; then
  echo "android.api = 30" >> buildozer.spec
fi

echo "🧹 حذف مجلد .buildozer المؤقت..."
rm -rf .buildozer

echo "🚀 بدء عملية البناء باستخدام Buildozer..."
buildozer android debug
