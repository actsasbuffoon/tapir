require_relative 'spec_helper.rb'

describe Tapir::Create do

  it "creates a single record" do
    pending
  end

  it "creates multiple records" do
    pending
  end

  it "returns a 422 and doesn't save any records if a validation error occurs" do
    pending
  end

  it "can nest data for a single record" do
    pending
  end

  it "can nest data for multiple records" do
    pending
  end

  it "can only nest data for models that are exposed via this API" do
    pending
  end

  it "returns a 422 if nested data is invalid, and no records are saved" do
    pending
  end

  it "returns 422 if the model doesn't accept nested attributes for the nested data" do
    pending
  end

  it "returns a 422 if a record fails an enforced attribute check, and no records are saved" do
    pending
  end

  it "can set attributes to a default if they are empty" do
    pending
  end

  it "doesn't override a provided attribute with a default" do
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

  it "respects attribute renaming for input" do
    pending
  end

  it "respects attribute renaming for output" do
    pending
  end

  it "can embed the return value of a method in output" do
    pending
  end

end
