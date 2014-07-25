module Tinkr
  ##
  # Given a target object, this will fetch all of the source
  # files within
  class SourceCollector
    def initialize(target)
      @target = target
    end

    def collect_sources
      instance_method_objects
        .map(&to_source_path)
        .compact
        .map(&:first)
        .uniq
    end

    def instance_method_objects
      instance_method_names.map(&to_method_obj(@target))
    end

    def instance_method_names
      if @target.instance_of?(Class)
        @target.instance_methods
      else
        @target.methods
      end
    end

    private
      def to_method_obj(target)
        lambda {|name| target.method(name)}
      end

      def to_source_path
        lambda {|method| method.source_location}
      end
  end
end
