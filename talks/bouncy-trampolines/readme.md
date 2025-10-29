BACK-END WEB DEVELOPMENT
============================

![GeneralAssemb.ly](https://github.com/generalassembly/ga-ruby-on-rails-for-devs/raw/master/images/ga.png "GeneralAssemb.ly")


# Install Git, Ruby, and Heroku

## Mac Users

Commands that look like `this` should be entered into your Terminal
application. It can be found in Applications/Utilities.

In general we recommended running the latest version of OS X, which is 10.10, known as Mavericks.

1.  __Ensure you have an Apple ID__
  * You should have one from the pre-work, but if not, [create one now](https://appleid.apple.com/cgi-bin/WebObjects/MyAppleId.woa/wa/createAppleId).

2. __Install Command Line Tools__
  * We need to install Xcode 6.4 to provide a compiler. Xcode can be found in the Apple's AppStore, or downloaded for free [here](https://developer.apple.com/downloads/index.action).
  * Once Xcode is installed, you will need to install the Command Line Tools for Xcode. You can install it by running `xcode-select --install` from the command line or download them directly [here](https://developer.apple.com/downloads/index.action).

3. __Install Homebrew__
  * Homebrew is a package management library, which basically means it's an OSX app that lets us install other libraries and tools we need.
  * To install it, simply copy and paste this command into your Terminal application: `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
  * If you have issues, visit the Homebrew install page: [http://brew.sh/](http://brew.sh/)
  * NOTE: *For advanced users only*: If you have a _strong_ desire to use a different package management tool (such as MacPorts, or Fink), you may do so, but note that we may not be able to support you if you encounter any issues with your specific tool. Proceed with caution.

4.  __Install git__
  * In order to manage our code effectively, we need a source control management tool. There are a number of options out there, but Git is by far the best one today.
  * We will use Homebrew to install Git. Before we do so, let's update homebrew to get the latest 'recipes' for its available libraries:
    * `brew update`
  * Now lets install Git:
    * `brew install git`
  * Verify that it's been installed correctly by running `which git` and it should return `/usr/local/bin/git`. If it doesn't let one of the instructors know.

5.  __Configure Git with your Name and Email__
  * To ensure that all your interactions with Git are signed with your email and username, follow these guides:
      * [https://help.github.com/articles/setting-your-email-in-git](https://help.github.com/articles/setting-your-email-in-git)
      * [https://help.github.com/articles/setting-your-username-in-git](ttps://help.github.com/articles/setting-your-username-in-git)

6.  __Install RVM with Ruby 2.2.2__
  * OSX comes with Ruby 2.0.0 out of the box. However, for this class we want to use Ruby 2.2.2.
  * RVM is a simple tool that lets you manage which Ruby builds are installed on your machine (you can have multiple ones at the same time!)
  * We will use RVM to install Ruby 2.2.2, and then set it as the default Ruby.
  * To install Ruby 2.2.2 with RVM, run this command:
      * `\curl -sSL https://get.rvm.io | bash -s stable --ruby`
  * Now set Ruby 2.2.2 as your default Ruby build:
      * `rvm use 2.2.2 --default`
    * *OPTIONAL:* You may also remove Ruby 1.8.7, if you wish:
      * `rvm remove ruby-1.8.7`

7. __Install Heroku Toolbelt__
  * In order to delpoy our rails apps for others to use we'll need heroku
  * We will use Homebrew to install Heroku Tollbelt. Before we do so, let's update homebrew to get the latest 'recipes' for its available libraries:
    * `brew update`
  * Now lets install Heroku Toolbelt:
    * `brew install heroku-toolbelt`
    * Verify that it's been installed correctly by running `which heroku` and it should return `/usr/local/bin/heroku`. If it doesn't let one of the instructors know.

8.  __Restart Your Terminal__
  * To ensure all the changes you made so far take effect, restart your Terminal app (just quit the app and relaunch it).

9.  __Make sure the latest versions of RVM and Ruby were installed__
  * To verify that you have the latest RVM and Ruby, run the commands below:
    * For RVM: `rvm -v` (you should get rvm 1.26.11 or higher)
    * For Ruby: `ruby -v` (you should get ruby 2.2.2 or higher)
    * For Heroku: `heroku version` (yoush should get heroku-toolbelt 3.42.20 or higher)

10.  __Congrats! You're all set. Now go build something awesome :)__

## Ubuntu Linux Users

Commands that look like `this` should be entered into your Terminal
application.

1. __Open a terminal window__
  * http://askubuntu.com/questions/196212/how-do-you-open-a-command-line

2. __Install git__
  * `sudo apt-get install build-essential git-core`
  * Set your git name and email:
    * https://help.github.com/articles/setting-your-email-in-git
    * https://help.github.com/articles/setting-your-username-in-git

3. __Install curl__
  * `sudo apt-get install curl`

4. __Install RVM__
  * `\curl -sSL https://get.rvm.io | bash -s stable --ruby`
  * The backslash in font of "curl" is not a typo.
  * Close and reopen terminal
  * `rvm use 2.2.2 --default`
  * Make sure the latest versions of RVM and Ruby were installed, run the commands below:
    * For RVM
      * `rvm -v`
        You should get rvm 1.26.11 or higher.
    *   For Ruby

      * `ruby -v`
        You should get ruby 2.2.2 or higher.

5. __Install Heroku Toolbelt__
  * `wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh`
  * Close and reopen the terminal
  * `heroku version`
  * Make sure you get 3.42.20 or higher

## Windows Users

1. __Install VirtualBox__
  * https://www.virtualbox.org/wiki/Downloads

2. __Download Ubuntu Linux__
  * http://www.ubuntu.com/download/desktop
  * Version 14.04 is probably preferable but any version above 12.04 is fine.

3. __Create your virtual machine__
  * Open VirtualBox and click the "New" button
  * Enter any name
  * Select "Linux" as the type
  * Select either "Ubuntu" or "Ubuntu (64 bit)" as the version depending on
    which you downloaded.
  * Memory size is the amount of your RAM that will be used to run
    Linux. 1024MB should be more than enough, but if you have a lot of
    RAM you can boost this number. If your machine only has 1GB of RAM
    then 512MB will have to do. If you're not sure, don't worry because
    this value can be changed later.
  * Hard drive - Select "Create a virtual hard drive now" then use the
    "VDI" type and then the "Dynamically allocated" option. Name the
    virtual hard drive file anything and select an amount of hard drive
    space that your computer is capable of supporting. 8GB should be plenty.
  * After clicking "Create", select the new virtual machine you created
    in the left column and press the "Start" button.
  * In the "Select start-up disk" window, select the Ubuntu Linux .iso
    file you downloaded and press start. You can then follow the Ubuntu
    installation instructions.

4. __Setup Ubuntu__
  * Open the Devices menu, then click 'Insert Guest Additions CD image...'
  * You should a pop up asking if you want to start the auto run process, click Yes. You'll be prompted for your user password.
  * After the script completes restart your VM.

## Happy Coding :)

__You're ready for the first class.__
