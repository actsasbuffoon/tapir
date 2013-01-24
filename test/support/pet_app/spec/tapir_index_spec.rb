require_relative 'spec_helper.rb'

describe Tapir::Index do

  it "returns a single record it if exists" do
    pending
  end

  it "returns multiple records it they exist" do
    pending
  end

  it "respects attribute renaming" do
    pending
  end

  it "can embed the return value of a method" do
    pending
  end

  describe "query" do
    describe "pagination" do
      it "has a default page size" do
        pending
      end

      it "has a maximum page size" do
        pending
      end

      it "can have its maximum page size disabled" do
        pending
      end

      it "brings the page size back down to the max if it is higher" do
        pending
      end

      it "returns a 422 if the page size is less than 1" do
        pending
      end

      it "accepts a max page size argument" do
        pending
      end
    end

    describe "filtering" do
      it "can show only records where a field matches a given value" do
        pending
      end

      it "can show only records where a field is NULL" do
        pending
      end

      it "can show only records where a field is not NULL" do
        pending
      end

      it "can show only records where a field does not match a given value" do
        pending
      end

      it "can show only records where a field is greater than a given value" do
        pending
      end

      it "can show only records where a field is less than a given value" do
        pending
      end

      it "can show only records where a field is greater than or equal to a given value" do
        pending
      end

      it "can show only records where a field is less than or equal to a given value" do
        pending
      end

      it "can show only records where a field is contained in a set of values" do
        pending
      end

      it "can show only records where a field is not contained in a set of values" do
        pending
      end

      it "can show only records where a field matches a SQL 'LIKE' query" do
        pending
      end

      it "returns a 401 if attempting to filter a field that is protected" do
        pending
      end
    end

    describe "sorting" do
      it "can sort data by a field" do
        pending
      end

      it "can sort in reverse" do
        pending
      end

      it "returns a 401 if attempting to sort by a field that is protected" do
        pending
      end
    end

    describe "nesting" do
      it "can nest models" do
        pending
      end

      it "returns a 422 if the model doesn't have an activerecord relationship with a nested model" do
        pending
      end

      it "can only nest data for models that are exposed via this API" do
        pending
      end

      it "can set independant page sizes for nested models" do
        pending
      end

      it "respects different page size settings in nested models" do
        pending
      end

      it "returns a 422 if the page size is less than one in a nested model" do
        pending
      end

      it "can filter included models independantly" do
        pending
      end

      it "returns a 401 is a nested model is filtered by a disallowed attribute" do
        pending
      end

      it "can sort nested models independantly" do
        pending
      end

      it "returns a 401 if a nested model is sorted by a disallowed attribute" do
        pending
      end

      it "respects attribute renaming" do
        pending
      end

      it "can embed the return value of a method" do
        pending
      end
    end    
  end
  
end
