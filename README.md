# MotionSupport

This is a very small library that sits loosely on top of BubbleWrap to extend the core RubyMotion classes, i.e. no user interface classes. It is somewhat inspired by ActiveSupport, but right now, not a lot is implemented.

To see what's there, look into the lib folder. There is documentation, also most everything is tested.

# Differences to ActiveSupport

In general:

* All I18n stuff was removed. Maybe it will be readded later.
* No support for the TimeWithZone class (iOS apps don't need advanced time zone support)
* No support for the DateTime class
* All deprecated methods have been removed

Specifically:

* Array#to_xml is missing
* Array#to_sentence does not accept a :locale parameter
* Time.current an alias for Time.now
* Date.current an alias for Date.today
* Date#to_time does not accept a timezone form (:local, :utc)
* Object#in? is missing. It is incompatible with Bacon, it will break specs.
* String#parameterize is missing because it needs to transliterate the string, which is dependent on the locale
* String#constantize is very slow. Cache the result if you use it.

# Forking

Feel free to fork and submit pull requests!
