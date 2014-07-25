module Tinkr
  module Debugging
    class << self
      def on?
        @on ||= false
      end

      def on!
        @on = true
      end

      def off!
        @off = false
      end
    end

    def debugging?
      Tinkr::Debugging.on?
    end

    def debug(msg)
      puts(msg) if debugging?
    end
  end
end
