module Tinkr
  class ClassUnloader
    include RestrictedClasses
    include Debugging

    def initialize(target_class)
      @target_class = target_class
    end

    attr_reader :target_class

    def unload!
      puts "UNLOADING MOFO: #{target_class}"
      unless RESTRICTED_CLASSES.include?(target_class)
        debug("Unloading #{constant} from #{parent_namespace}")
        parent_namespace.send(:remove_const, constant.to_sym)
      end
    end

      private
      def parent_namespace
        return constantize("Object") if ancestors.empty?
        constantize(*ancestors)
      end

      def ancestors
        @ancestors ||= namespaces[0..-2]
      end

      def constant
        @constant ||= namespaces.last
      end

      def namespaces
        @namespaces ||= target_class.name.split("::")
      end

      def constantize(*names)
        names.inject(Object) do |const, name|
          const = const.const_get(name.to_sym)
        end
      end
  end
end
