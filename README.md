# MotionSupport

This is a very small library that sits loosely on top of BubbleWrap to extend the core RubyMotion classes, i.e. no user interface classes. It is somewhat inspired by ActiveSupport, but right now, not a lot is implemented.

To see what's there, look into the lib folder. There is documentation, also most everything is tested.

# Differences to ActiveSupport

* Module#mattr_accessor has no support for instance accessors yet, since they are really cumbersome to implement without eval.

# Forking

Feel free to fork and submit pull requests!
