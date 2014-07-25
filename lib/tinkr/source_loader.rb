module Tinkr
  class SourceLoader
    def initialize(*paths)
      @paths = paths
    end

    def reload!
      no_warnings do
        @paths.each do |source|
          load(source)
        end
      end
    end

      private
      def no_warnings
        original_verbosity = $VERBOSE
        $VERBOSE = nil
        result = yield
        $VERBOSE = original_verbosity
        result
      end
  end
end
