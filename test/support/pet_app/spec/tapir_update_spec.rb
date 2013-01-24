require_relative 'spec_helper.rb'

describe Tapir::Update do

  it "updates a single record" do
    pending
  end

  it "returns a 422 and doesn't save any records if a validation error occurs" do
    pending
  end

  it "can nest data for a single record" do
    pending
  end

  it "returns a 422 if nested data is invalid, and no records are saved" do
    pending
  end

  it "returns 422 if the model doesn't accept nested attributes for the nested data" do
    pending
  end

  it "can only nest data for models that are exposed via this API" do
    pending
  end

  it "returns a 422 if a record fails an enforced attribute check, and no records are saved" do
    pending
  end

  it "accepts 'ignored attributes', which will not be saved" do
    pending
  end

  it "only accepts an ignored attribute if the model has an accessor for it" do
    pending
  end

  it "returns a 401 if data includes an attribute that isn't writable" do
    pending
  end

  it "returns a 422 if data includes a non-existent attribute" do
    pending
  end

  it "respects attribute renaming in input" do
    pending
  end

  it "respects attribute renaming in output" do
    pending
  end

  it "can embed the return value of a method in output" do
    pending
  end

end
