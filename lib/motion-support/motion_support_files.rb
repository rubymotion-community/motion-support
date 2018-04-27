require_relative 'core_ext/core_ext_files'
module MotionSupport
  class << self

    def callbacks_files
      %w(
        _stdlib/array
        concern
        descendants_tracker
        callbacks
        core_ext/kernel/singleton_class
      ).map { |file| self.map_file_to_motion_dir(file) }
    end

    def concern_files
      ['concern'].map { |file| self.map_file_to_motion_dir(file) }
    end

    def core_ext_files
      base_files = %w(
        core_ext/enumerable
        core_ext/array
        core_ext/metaclass
        core_ext/ns_dictionary
        core_ext/ns_string
        core_ext/regexp
      ).map { |file| self.map_file_to_motion_dir(file) }
      
      (array_files + class_files + module_files + integer_files + hash_files +
        numeric_files + object_files + range_files + string_files + time_files + base_files).uniq
    end

    def inflector_files
      %w(
        inflector/inflections
        inflector/methods
        inflections
        core_ext/string/inflections
        core_ext/array/prepend_and_append
      ).map { |file| self.map_file_to_motion_dir(file) }
    end

    def requires
      base_files = %w(
        callbacks
        concern
        descendants_tracker
        duration
        hash_with_indifferent_access
        inflections
        logger
        number_helper
        version
      ).map { |file| self.map_file_to_motion_dir(file) }
      (callbacks_files + core_ext_files + inflector_files + base_files).uniq
    end

    def map_file_to_motion_dir(file)
      File.expand_path(File.join(File.dirname(__FILE__), "/../../motion", "#{file}.rb"))
    end
  end
end