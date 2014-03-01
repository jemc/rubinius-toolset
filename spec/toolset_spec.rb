describe "Rubinius::ToolSet.current" do
  it "returns a Module" do
    Rubinius::ToolSet.current.should be_an_instance_of(Module)
  end
end

describe "Rubinius::ToolSet.finish" do
  before do
    Rubinius::ToolSet.start
    module Rubinius::ToolSet.current::TS; end
  end

  it "adds name to the ToolSet map" do
    Rubinius::ToolSet.finish :testing
    Rubinius::ToolSet.map.keys.should include(:testing)
  end

  it "sets a constant on ToolSet with the capitalized name" do
    Rubinius::ToolSet.finish :name
    Rubinius::ToolSet::Name.should be_an_instance_of(Module)
  end
end

describe "Rubinius::ToolSet.create" do
  it "it resets $LOADED_FEATURES while running the block" do
    Rubinius::ToolSet.create do
      $LOADED_FEATURES.should == []
    end
  end

  it "yields an anonymous Module to the block if no name is given" do
    Rubinius::ToolSet.create do |m|
      m.should be_an_instance_of(Module)
      m.name.should be_nil
    end
  end

  it "sets .current to the module that is yielded to the block" do
    Rubinius::ToolSet.create do |m|
      m.should equal(Rubinius::ToolSet.current)
    end
  end

  it "accepts an optional name for the toolset module" do
    Rubinius::ToolSet.create :a_tool_set do |m|
      m.name.should == "Rubinius::ToolSet::AToolSet"
    end
  end

  it "creates a temporary module named 'TS' on the current toolset module" do
    Rubinius::ToolSet.create :spec do |m|
      m.should equal(m::TS)
      m::TS.name.should == "Rubinius::ToolSet::Spec"
    end
  end
end
