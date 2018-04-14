flutter clean
flutter build apk
# adb uninstall com.mjohnsullivan.flutwear
adb -s 14362D11F1DD436 install -r build/app/outputs/apk/release/app-release.apk
adb shell am start -a android.intent.action.MAIN -n com.mjohnsullivan.flutwear/.MainActivity
