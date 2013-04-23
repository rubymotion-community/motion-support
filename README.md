# MotionSupport

This is a port of the parts of ActiveSupport that make sense for RubyMotion.

To see what's there, generate the documentation with the `rdoc` command from the repository root, or look into the lib folder. Almost everything is tested.

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
* String#to_time, #to_date, #to_datetime are missing because they depend on Date#_parse
* String inquiry methods are missing
* String multibyte methods are missing
* String#html_safe and ERB extensions are not needed in RubyMotion

# Acknowledgements

ActiveSupport was originally written as part of Ruby on Rails by David Heinemeier Hansson. Over the years, countless contributors made many additions. They made this library possible.

# Forking

Feel free to fork and submit pull requests!
