module Tinkr
  ##
  # Given a target object, this will fetch all of the source
  # files within
  class SourceCollector
    include Debugging

    def initialize(target, last_eval)
      @target = target
      @last_eval = last_eval || Time.at(0)
    end

    attr_reader :target

    def collect_sources
      result = instance_method_objects
        .map(&to_source_path)
        .compact
        .map(&:first)
        .uniq
        .reject(&illegal_paths)
        .reject(&files_not_modified_since_last_eval)
      debug "Detected #{result.size} source files for #{target}"
      result
    end

    def instance_method_objects
      instance_method_names.map(&to_method_obj(target)).compact
    end

    def instance_method_names
      if target.instance_of?(Class)
        target.instance_methods
      else
        target.methods
      end
    end

    private
      def to_method_obj(target)
        lambda {|name| target.method(name) rescue nil}
      end

      def to_source_path
        lambda {|method| method.source_location}
      end

      def illegal_paths
        lambda do |source|
          # TODO find out why some activerecord path reload
          # breaks db connections
          source == "(eval)" || source.match(/activerecord/)
        end
      end

      def files_not_modified_since_last_eval
        last_eval = @last_eval
        lambda do |file|
          File.mtime(file).to_f <= last_eval.to_f
        end
      end
  end
end
