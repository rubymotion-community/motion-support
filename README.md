# MotionSupport

This is a port of the parts of ActiveSupport that make sense for RubyMotion.

To see what's there, generate the documentation with the `rdoc` command from the repository root, or look into the lib folder. Almost everything is tested.

# Differences to ActiveSupport

In general:

* All `I18n` stuff was removed. Maybe it will be readded later.
* No support for the `TimeWithZone` class (iOS apps don't need advanced time zone support)
* No support for the `DateTime` class
* All deprecated methods have been removed
* All `YAML` extensions were removed, since RubyMotion doesn't come with YAML support
* `Kernel#silence_warnings` and stream manipulation methods were removed
* Multibyte string handling methods have been removed
* All Rails-specific stuff was removed
* The dependency resolution code was removed. So was the dynamic code reloading code
* All marshalling code was removed
* All logging code was removed
* All extensions to `Test::Unit` were removed

Specifically:

* `Array#third` .. `Array#fourty_two` were removed
* `Array#to_xml` is missing
* `Array#to_sentence` does not accept a `:locale` parameter
* `Hash#extractable_options?` is missing
* `BigDecimal` conversions were removed
* `Time.current` an alias for `Time.now`
* `Date.current` an alias for `Date.today`
* `Date#to_time` does not accept a timezone form (`:local`, `:utc`)
* `Date#xmlschema` is missing
* `Object#in?` is missing. It is incompatible with Bacon, it will break specs.
* `String#parameterize` is missing because it needs to transliterate the string, which is dependent on the locale
* `String#constantize` is very slow. Cache the result if you use it.
* `String#to_time`, `#to_date`, `#to_datetime` are missing because they depend on `Date#_parse`
* String inquiry methods are missing
* String multibyte methods are missing
* `String#html_safe` and `ERB` extensions are not needed in RubyMotion
* `Object#to_json` and subclasses are missing
* `Range#to_s(:db)` was removed
* The `rfc822` time format was removed, since it relies on time zone support.
* Extensions to `LoadError` and `NameError` were removed
* The `ThreadSafe` versions of `Hash` and `Array` are just aliases to the standard classes

Things to do / to decide:

* RubyMotion lacks a `Date` class. in `_stdlib` there is a stub of a Date class that makes the `Date` extensions work. This stub needs to be completed.
* Implement `Object#to_json`, probably best if implemented on top of Cocoa APIs
* Implement `Object#to_xml`
* Implement `Hash#from_xml`
* Do we need `Hash#extractable_options?`?
* Do we need `Class#superclass_delegating_accessor`?
* Implement all `InfiniteComparable` extensions
* Do we need `File#atomic_write` for thread-safe file writing?
* Do we need `Kernel#class_eval` (it delegates to `class_eval` on this' singleton class)?
* Do we need `Module#qualified_const_defined?`? What is that even for?
* Implement `Numeric` conversions, especially `NumberHelper`
* Do we need `Object#with_options`?
* Implement `String#to_time`, `String#to_date`. In the original ActiveSupport, they make use of the `Date#_parse` method (which seems like it's supposed to be private). Here, they should be implemented on top of Cocoa APIs
* Do we need `String#parameterize`? If so, we need to find a way to transliterate UTF-8 characters.
* Do we need the `StringInquirer`? It allows things like `Rails.env.development?` instead of `Rails.env == 'development'`
* Do we need multibyte string handling extensions? AFAIK, all strings in RubyMotion are UTF-8. Is that true?
* Do we need `Struct#to_h`?
* Implement extensions to class `Thread` if they make sense.
* Port callbacks.rb
* Port concern.rb
* Do we need the `Configurable` module?
* Do we need the `DescendantsTracker` module?
* Do we need the `OrderedOptions` class?
* Go through documentation and remove or rewrite things not relevant to RubyMotion, especially examples mentioning Rails components

# Acknowledgements

ActiveSupport was originally written as part of Ruby on Rails by David Heinemeier Hansson. Over the years, countless contributors made many additions. They made this library possible.

# Forking

Feel free to fork and submit pull requests!
