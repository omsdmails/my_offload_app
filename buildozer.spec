[app]

# (Required) Title of your application
title = OffloadApp

# (Required) Package name
package.name = offloadapp

# (Required) Package domain (reverse DNS style)
package.domain = org.example

# Source code location
source.dir = .
source.include_exts = py,kv
source.exclude_exts = spec
source.include_patterns = assets/*,images/*.png
source.exclude_dirs = tests, bin

# Versioning
version = 1.0
android.version_code = 1

# Application requirements
requirements = kivy,flask,requests,psutil,zeroconf
orientation = portrait

# Bootstrap to use (sdl2 or webview)
bootstrap = sdl2

# Supported architectures
arch = armeabi-v7a, arm64-v8a

# Android NDK API level
android.ndk_api = 23

# (Optional) Icon of the application
icon.filename = %(source.dir)s/icon.png

# (Optional) Presplash of the application
presplash.filename = %(source.dir)s/presplash.png

# Permissions
android.permissions = INTERNET

# (Optional) Include SQLite3
android.sqlite3 = True

# (Optional) Package options
android.entrypoint = org.kivy.android.PythonActivity
android.minapi = 21
android.target = 31
android.compile_sdk = 31
android.build_tools_version = 31.0.0

# (Optional) Logging
log_level = 2

android.api = 30
# Disable deploy and run after build
deploy = 0
run = 0
