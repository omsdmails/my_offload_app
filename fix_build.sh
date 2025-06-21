#!/bin/bash

echo "🔧 التحقق من الأدوات الأساسية..."

for cmd in python3 pip3 javac unzip zip; do
  if ! command -v $cmd &> /dev/null; then
    echo "❌ الأمر $cmd غير موجود. الرجاء تثبيته يدوياً."
    exit 1
  fi
done

echo "✅ جميع الأدوات الأساسية موجودة."

echo "🔧 التأكد من أن buildozer مثبت..."
if ! command -v buildozer &> /dev/null; then
  echo "📦 تثبيت buildozer..."
  pip3 install --user buildozer
else
  echo "✅ buildozer مثبت مسبقاً."
fi

echo "🛠️ تعديل ملف buildozer.spec إن وجد..."

if [ -f "buildozer.spec" ]; then
  sed -i 's/python3,//g' buildozer.spec
  echo "✅ تم حذف python3 من المتطلبات."
else
  echo "❌ ملف buildozer.spec غير موجود في المجلد الحالي."
  exit 1
fi

echo "🧹 تنظيف الملفات القديمة..."
buildozer android clean
rm -rf .buildozer

echo "🚀 بدء البناء..."
buildozer -v android debug
