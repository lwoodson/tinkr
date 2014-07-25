module Tinkr
  class SourceLoader
    include Debugging

    def initialize(*paths)
      @paths = paths
    end

    attr_reader :paths

    def reload!
      no_warnings do
        paths.each do |source|
          debug("loading #{source}")
          begin
            load(source)
          rescue StandardError => e
            debug("ERROR: #{e}")
          end
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
