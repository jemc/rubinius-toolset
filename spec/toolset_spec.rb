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
