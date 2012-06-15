#BDToastAlert - A simple UIKit class for displaying non-obstructive message labels on iOS UIView 

Sometimes your app might want to display messages to user, but not needing user interaction to acknowledge those messages. 

##Features
- Basically, one toast per one parent view. (So you can have more than one toasts on your UISplitViewController's child  UIViewControllers.)
- Automatically guards against displaying duplicate texts on the same parent view.
- Singleton instance. Knows where all your toasts are.
- Toast automatically resizes to fit your text size.



##Requirements
- Only tested in iOS 5.x 
- ARC
- UIKit
- QuartzCore.framework

##How to use
- Include h/.m files in BDToastAlert folder to your project source code 
- See the sample project. There's really not much to it.


##License
BDToastAlert is licensed under BSD. More info in LICENSE file.