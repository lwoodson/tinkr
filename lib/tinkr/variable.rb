module Tinkr
  class Variable
    def initialize(name, factory)
      @name = name
      @factory = factory
    end

    attr_reader :name, :factory

    def define
      variable = self
      Kernel.send(:define_method, @name) do
        sources = SourceCollector.new(variable.evaluate).collect_sources
        SourceLoader.new(*sources).reload!
        variable.evaluate
      end
    end

    def evaluate
      factory.call
    end
  end
end
