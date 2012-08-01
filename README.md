#BDToastAlert - Self-managed HUD-style alert text.

##Overview

BDToastAlert provides you an easy way to display non-obstructive messages to 
user without having to worry about the view heirachy (too much.) It also takes care
of not displaying repetitive message or displaying them in a nicer fashion.

##version 2.0



[![](https://github.com/norsez/BDToastAlert/raw/master/BDToastAlert/screencap.png)](https://github.com/norsez/BDToastAlert/raw/master/BDToastAlert/screencap.png)

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