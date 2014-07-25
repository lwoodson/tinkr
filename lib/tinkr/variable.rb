module Tinkr
  class Variable
    include Debugging
    include RestrictedClasses

    def initialize(name, factory)
      @name = name
      @factory = factory
    end

    attr_reader :name, :factory, :last_evaluation
    attr_accessor :last_evaluation_time

    def define
      variable = self
      debug("Defining variable #{name}")
      Kernel.send(:define_method, name) do
        temp = variable.evaluate
        sources = SourceCollector.new(temp, @last_evaluation_time).collect_sources
        ClassUnloader.new(temp.class).unload!
        SourceLoader.new(*sources).reload!
        variable.last_evaluation_time = Time.now
        variable.evaluate
      end
    end

    def evaluate
      @last_evaluation = factory.call
    end
  end
end
