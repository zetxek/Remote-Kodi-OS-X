# About the project #

Remote Kodi for OS X is a very simple native remote for Kodi/XBMC, written in swift.

The project is being developed by [Carolina Barreiro](https://twitter.com/droideca) and [Adrián Moreno](https://twitter.com/zetxek), and suggestions of things to come are needed (in case anyone finds this useful!)

The project uses CocoaPods and is developed in XCode 7, with Swift 2.0 (after the starting point with XCode 6.4 and Swift 1.2).

The idea for the project came after using some mobile remotes for Kodi, where you don't get a response as fast as in a computer, and you also miss the physical response that a computer keyboard provides.

Please note that for using remote calls to Kodi/XBMC you'll need to [enable JSON RPC server](http://kodi.wiki/view/JSON-RPC_API#Enabling_JSON-RPC)! And if you want to modify the app yourself, you will need to create a "APIKeys.plist" files, in order to provide your Parse.com credentials. A sample file is provided as reference.

![2015-08-27 01.22.50 am.png](https://bitbucket.org/repo/d9xzL8/images/4192496449-2015-08-27%2001.22.50%20am.png)
![2015-08-27 01.22.59 am.png](https://bitbucket.org/repo/d9xzL8/images/2359747551-2015-08-27%2001.22.59%20am.png)

###Download link ###

- [latest: v0.4 download] (https://bitbucket.org/zetxek/remote-kodi-os-x/downloads/Kodi_Remote.app_v0.4.zip) the app is now reporting crashes and tracking installs, to give devs more insight about how Kodi can be improved.
- [v0.3 download] (https://bitbucket.org/zetxek/remote-kodi-os-x/downloads/Kodi_Remote.app_v0.3.zip) the app is compatible now with OS X El Capitan, goodbye to the super crashes in the last OS X!
- [v0.2 download](https://bitbucket.org/zetxek/remote-kodi-os-x/downloads/Kodi_Remote.app_v0.2.zip) 2nd release of the app. Improvements in design, some changes in code to come.
- [v0.1 download](https://bitbucket.org/zetxek/remote-kodi-os-x/src/1a2bec5a9cb2ac86e6cf91dd997eb552ee1ef6cb/Releases/Kodi_Remote_v0.1-dev.zip?at=master) 1st release of the app. Pretty simple, complicated having less features and still being considered a remote, but might be useful to showcase the concept.


###TODO ###

* Buttons for home, volume
* Binary generation
* Code refactor for better software design