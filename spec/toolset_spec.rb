describe "Rubinius::ToolSets.current" do
  it "returns a Module" do
    Rubinius::ToolSets.create do
      Rubinius::ToolSets.current.should be_an_instance_of(Module)
    end
  end
end

describe "Rubinius::ToolSets.create" do
  it "it resets $LOADED_FEATURES while running the block" do
    Rubinius::ToolSets.create do
      $LOADED_FEATURES.should == []
    end
  end

  it "yields an anonymous Module to the block if no name is given" do
    Rubinius::ToolSets.create do |m|
      m.should be_an_instance_of(Module)
      m.name.should be_nil
    end
  end

  it "sets .current to the module that is yielded to the block" do
    Rubinius::ToolSets.create do |m|
      m.should equal(Rubinius::ToolSets.current)
    end
  end

  it "accepts an optional name for the toolset module" do
    Rubinius::ToolSets.create :a_tool_set do |m|
      m.name.should == "Rubinius::ToolSets::AToolSet"
    end
  end

  it "sets the 'ToolSet' constant on the yielded module to refer to itself" do
    Rubinius::ToolSets.create :spec do |m|
      m.should equal(m::ToolSet)
      m::ToolSet.name.should == "Rubinius::ToolSets::Spec"
    end
  end
end
