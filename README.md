#BDToastAlert - A simple UIKit class for displaying non-obstructive alert message labels on iOS UIView 

Sometimes your app might want to display messages to user, but not needing user interaction to acknowledge those messages. Multiple duplicate messages are automatically suppressed for a short interval (great for, e.g. automatic alert for multiple URL connections that suddenly fail at the same time)  

##Features
- Basically, one toast per one parent view. (So you can have more than one toast on your UISplitViewController's child  UIViewControllers.)
- Automatically guards against displaying duplicate texts on the same parent view.
- Singleton instance. Knows where all your toasts are.
- Toast automatically resizes to fit your text size.



##Requirements
- Requires ARC
- QuartzCore.framework

##How to use
- With CocoaPods, add to your dependency list.

    dependency 'BDToastAlert'

- Without CocoaPods, just include h/.m files in BDToastAlert folder to your project source code 
- See the sample project. There's really not much to it.


##License
BDToastAlert is licensed under BSD. More info in LICENSE file.