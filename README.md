# iOSFingerPrintScanner
Sample of iOS finger Print Scanner for iPhone


This is the source for an iOS app that uses the Finger Print Scanner for Authentication. It also allows a fallback prompt for user name and password.

You will need XCode to run this program.

All source is open source, you may use this for anything you wish.

There is no intended use, you at your own risk.

# Info
You will see that once you click on the finger print button, the system will prompt you for a finger print scan. If this is successful then you wind up in the block. If not then you can cancel or continue attempting and get the user fallback prompt.

Note that in iOS8 and above the User Fallback prompt no longer appears by default, it must fail the fingerprint scan a couple of times and it will then appear. This is different then on iOS7 where it always appeared.

Scann Button
![screenshot](https://github.com/ThomasJay/iOSFingerPrintScanner/blob/master/home.png)

System Auth Prompt
![screenshot](https://github.com/ThomasJay/iOSFingerPrintScanner/blob/master/auth.png)

System Auth Prompt with user fallback
![screenshot](https://github.com/ThomasJay/iOSFingerPrintScanner/blob/master/auth_enterpasword.png)

User Fall Back user name and password prompt
![screenshot](https://github.com/ThomasJay/iOSFingerPrintScanner/blob/master/login.png)
