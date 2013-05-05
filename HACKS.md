# Hacks to be removed ASAP

On every RubyMotion upgrade, check if the following things can be resolved/removed:

* Warning about automatic dependency detection (ADD). Currently, ADD does not work out of the box with MotionSupport. There are already a few suggested fixes, so we expect a fix to be released soon.
* `Object#__in_workaround`. If we define Object#in? directly, we get strange errors when running specs.
* `Date` class. There is a stub of a reimplementation of that class in MotionSupport. This should removed as soon as RubyMotion gets its own `Date` class (if ever). Otherwise, the implementation should be completed.
