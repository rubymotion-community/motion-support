module MotionSupport
  class << self
    def array_files
      %w(
        core_ext/array
        core_ext/array/wrap
        core_ext/array/access
        core_ext/array/conversions
        core_ext/array/extract_options
        core_ext/array/grouping
        core_ext/array/prepend_and_append
      ).map { |file| self.map_core_ext_file_to_motion_dir(file) }
    end
    
    def class_files
      %w(
        core_ext/class/attribute
        core_ext/class/attribute_accessors
      ).map { |file| self.map_core_ext_file_to_motion_dir(file) }
    end

    def hash_files
      %w(
        core_ext/ns_dictionary
        core_ext/object/to_param
        core_ext/hash/deep_merge
        core_ext/hash/except
        core_ext/hash/indifferent_access
        core_ext/hash/keys
        core_ext/hash/reverse_merge
        core_ext/hash/slice
        core_ext/hash/deep_delete_if
        hash_with_indifferent_access
        core_ext/module/delegation
      ).map { |file| self.map_core_ext_file_to_motion_dir(file) }
    end

    def integer_files
      %w(
        core_ext/integer/multiple
        core_ext/integer/inflections
        core_ext/integer/time
      ).map { |file| self.map_core_ext_file_to_motion_dir(file) }
    end

    def module_files
      %w(
        core_ext/module/aliasing
        core_ext/module/introspection
        core_ext/module/anonymous
        core_ext/module/reachable
        core_ext/module/attribute_accessors
        core_ext/module/attr_internal
        core_ext/module/delegation
        core_ext/module/remove_method
      ).map { |file| self.map_core_ext_file_to_motion_dir(file) }
    end

    def numeric_files
      %w(
        duration
        core_ext/numeric/bytes
        core_ext/numeric/conversions
        core_ext/numeric/time
      ).map { |file| self.map_core_ext_file_to_motion_dir(file) }
    end

    def object_files
      %w(
        _stdlib/cgi
        core_ext/object/acts_like
        core_ext/object/blank
        core_ext/object/deep_dup
        core_ext/object/duplicable
        core_ext/object/inclusion
        core_ext/object/try
        core_ext/object/instance_variables
        core_ext/object/to_json
        core_ext/object/to_param
        core_ext/object/to_query
      ).map { |file| self.map_core_ext_file_to_motion_dir(file) }
    end

    def range_files
      %w(
        core_ext/range/include_range
        core_ext/range/overlaps
      ).map { |file| self.map_core_ext_file_to_motion_dir(file) }
    end

    def string_files
      %w(
        core_ext/ns_string
        core_ext/string/access
        core_ext/string/behavior
        core_ext/string/exclude
        core_ext/string/filters
        core_ext/string/indent
        core_ext/string/starts_ends_with
        core_ext/string/inflections
        core_ext/string/strip
        core_ext/module/delegation
      ).map { |file| self.map_core_ext_file_to_motion_dir(file) }
    end

    def time_files
      %w(
        _stdlib/date
        _stdlib/time
        core_ext/time/acts_like
        core_ext/time/calculations
        core_ext/time/conversions
        core_ext/date/acts_like
        core_ext/date/calculations
        core_ext/date/conversions
        core_ext/date_and_time/calculations
        core_ext/integer/time
        core_ext/numeric/time
        core_ext/object/acts_like
        duration
      ).map { |file| self.map_core_ext_file_to_motion_dir(file) }
    end
    
    def map_core_ext_file_to_motion_dir(file)
      File.expand_path(File.join(File.dirname(__FILE__), "/../../../motion", "#{file}.rb"))
    end
  end
end
