require 'spec_helper'

module Tinkr
  describe Dsl do

    subject {Object.new.extend(Dsl)}

    describe "#let" do
      let(:test_class_source) {File.join('spec', 'test_class.rb')}

      around(:each) do |example|
        load(test_class_source)
        @original_contents = File.read(test_class_source)
        subject.let(:test_obj) {TestClass.new}
        subject.let(:hash) {{test_obj: test_obj}}

        example.run
        File.open(test_class_source, 'w') {|f| f.write(@original_contents)}
      end

      it "should define a variable that evaluates to the result of the passed block" do
        expect(subject.test_obj).to be_kind_of(TestClass)
      end

      it "should always evaluate the block freshly when accessing the variable" do
        expect(subject.test_obj.object_id).to_not eq(subject.test_obj.object_id)
      end

      it "should allow for the referencing of variables within other variables" do
        expect(subject.hash[:test_obj]).to be_kind_of(TestClass)
      end

      def add_foo_method_to_test_class
        contents = File.read(test_class_source).split("\n")
        contents.insert(1, "def foo", '1', "end")
        File.open(test_class_source, 'w') {|f| f.write(contents.join("\n"))}
      end

      it "should pick up changes to the class definition in its source file automagically" do
        add_foo_method_to_test_class
        expect(subject.test_obj.foo).to eq(1)
      end

      it "variables referencing other variables with source code changes should reflect them automagically" do
        expect(subject.hash[:test_obj].foo).to eq(1)
      end
    end
  end
end
