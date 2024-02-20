special commands
----------------------------
flutter pub run build_runner build --delete-conflicting-outputs
flutter build appbundle
adb uninstall com.glowsis.dashboard

rebase step
--------------------------------------------------
1.commit the changes in your current branch
2. git checkout master
3. git pull
4. git checkout yourBranch
5. git rebase master yourBranch
6. then push to git server

taking android build for sharing
-------------------------------
flutter build apk --release

take android build and publish
-----------------------------
1.update version code and version name from app lever gradle build
2.flutter clean
3.flutter build appbundle
4. go to google play console 
5. select glosis dashboard application
6. selection production from the left pannel
7. press the "create new release" button from the right rop
8. then drag the application to appbundles box
9. press save button from the bottom right corner
10. press the review release 

take IOS build and publish
------------------------------------------
1. flutter clean
2. flutter build ios --release
3. open the project in xcode
4. select runner and and update vertion code and build nuber
5. choose a device (real device or "any IOS device") nb: simulator not supported
6. product->archive
7. press evry blue buttons in the upcoming windows
8. Fahal test
9. 



fahal

