module Tinkr
  module RestrictedClasses
    ##
    # These are classes that should not be reloaded due to it destabilizing
    # ruby itself.
    #
    # TODO Create a rake task that will autopopulate this to easily using
    # ObjectSpace.each_object.to_a.map(&:class).uniq
    #
    # TODO Can I find an easier way to limit all core and standard lib classes?
    #
    RESTRICTED_CLASSES = [
      String,
      Gem::Requirement,
      Array,
      Gem::Dependency,
      Gem::StubSpecification,
      Hash,
      Gem::Version,
      Gem::StubSpecification::StubLine,
      RubyVM::InstructionSequence,
      Time,
      Regexp,
      Gem::Specification,
      Proc,
      RubyVM::Env,
      MatchData,
      Class,
      Module,
      Enumerator,
      Mutex,
      Encoding,
      Complex,
      ThreadGroup,
      IOError,
      Binding,
      Thread,
      RubyVM,
      NoMemoryError,
      SystemStackError,
      Bignum,
      Random,
      ARGF.class,
      IO,
      Data,
      Object,
      Float,
      Range,
      Gem::Platform,
      Monitor,
      Gem::PathSupport,
      File,
      NameError,
      Gem::BasicSpecification,
      Numeric,
      StandardError,
      Exception,
      Integer,
      BasicObject,
    ]
  end
end
