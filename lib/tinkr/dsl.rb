module Tinkr
  module Dsl
    def let(name, &factory)
      Variable.new(name, Proc.new(&factory)).define
    end
  end
end
