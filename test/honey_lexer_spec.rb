require_relative 'spec_helper.rb'

describe Apiary::Honey::Lexer do
  
  let(:lexer) {Apiary::Honey::Lexer.new}

  it "tokenizes a blank string" do
    lexer.tokenize("").should == []
  end

  it "tokenizes an identifier" do
    lexer.tokenize("foo").should == [
      {
        :type => :IDENTIFIER,
        :value => 'foo'
      }
    ]
  end

  it "tokenizes a keyword" do
    lexer.tokenize("eq").should == [
      {
        :type => :EQ,
        :value => 'eq'
      }
    ]
  end

  it "tokenizes a double-quoted string" do
    lexer.tokenize(%q{"foo bar baz"}).should == [
      {
        :type => :STRING,
        :value => 'foo bar baz'
      }
    ]
  end

  it "tokenizes a single-quoted string" do
    lexer.tokenize(%q{'foo bar baz'}).should == [
      {
        :type => :STRING,
        :value => 'foo bar baz'
      }
    ]
  end

  it "tokenizes a single-quoted string that contains a double-quoted string" do
    lexer.tokenize(%q{'foo "bar" baz'}).should == [
      {
        :type => :STRING,
        :value => 'foo "bar" baz'
      }
    ]
  end

  it "tokenizes a double-quoted string that contains a single-quoted string" do
    lexer.tokenize(%q{"foo 'bar' baz"}).should == [
      {
        :type => :STRING,
        :value => "foo 'bar' baz"
      }
    ]
  end

  it "tokenizes a single-quoted string that contains escaped single-quotes" do
    lexer.tokenize(%q{'foo \'bar\' baz'}).should == [
      {
        :type => :STRING,
        :value => "foo 'bar' baz"
      }
    ]
  end

  it "tokenizes a double-quoted string that contains escaped double-quotes" do
    lexer.tokenize(%q{"foo \"bar\" baz"}).should == [
      {
        :type => :STRING,
        :value => 'foo "bar" baz'
      }
    ]
  end

  it "single-quoted strings are not greedily consumed" do
    lexer.tokenize(%q{foo 'bar' baz 'bat'}).should == [
      {:type => :IDENTIFIER, :value => 'foo'},
      {:type => :STRING, :value => 'bar'},
      {:type => :IDENTIFIER, :value => 'baz'},
      {:type => :STRING, :value => 'bat'},
    ]
  end

  it "single-quoted strings are not greedily consumed" do
    lexer.tokenize(%q{foo "bar" baz "bat"}).should == [
      {:type => :IDENTIFIER, :value => 'foo'},
      {:type => :STRING, :value => 'bar'},
      {:type => :IDENTIFIER, :value => 'baz'},
      {:type => :STRING, :value => 'bat'}
    ]
  end

  it "tokenizes a 1 digit number" do
    lexer.tokenize(%q{4}).should == [
      {:type => :INTEGER, :value => '4'}
    ]
  end

  it "tokenizes a multi digit number" do
    lexer.tokenize(%q{4242}).should == [
      {:type => :INTEGER, :value => '4242'}
    ]
  end

  it "tokenizes a decimal number" do
    lexer.tokenize(%q{42.42}).should == [
      {:type => :DECIMAL, :value => '42.42'}
    ]
  end

  it "tokenizes a table/field name" do
    lexer.tokenize(%q{user.first_name}).should == [
      {:type => :FIELD, :value => 'user.first_name'}
    ]
  end

  it "tokenizes an eq statement" do
    lexer.tokenize(%q{name eq "Phil"}).should == [
      {:type => :IDENTIFIER, :value => 'name'},
      {:type => :EQ, :value => 'eq'},
      {:type => :STRING, :value => 'Phil'}
    ]
  end

  it "tokenizes lists correctly" do
    lexer.tokenize(%q{name in "Phil", "Tom", "Ed"}).should == [
      {:type => :IDENTIFIER, :value => 'name'},
      {:type => :IN, :value => 'in'},
      {:type => :STRING, :value => 'Phil'},
      {:type => :STRING, :value => 'Tom'},
      {:type => :STRING, :value => 'Ed'}
    ]
  end

  it "tokenizes directions correctly" do
    lexer.tokenize(%q{asc desc}).should == [
      {:type => :DIRECTION, :value => 'asc'},
      {:type => :DIRECTION, :value => 'desc'}
    ]
  end

  it "tokenizes keywords correctly" do
    lexer.tokenize(%q{eq not gt lt ge le includes sort page_size page in nin like and null}).should == [
      {:type => :EQ, :value => 'eq'},
      {:type => :NOT, :value => 'not'},
      {:type => :GT, :value => 'gt'},
      {:type => :LT, :value => 'lt'},
      {:type => :GE, :value => 'ge'},
      {:type => :LE, :value => 'le'},
      {:type => :INCLUDES, :value => 'includes'},
      {:type => :SORT, :value => 'sort'},
      {:type => :PAGE_SIZE, :value => 'page_size'},
      {:type => :PAGE, :value => 'page'},
      {:type => :IN, :value => 'in'},
      {:type => :NIN, :value => 'nin'},
      {:type => :LIKE, :value => 'like'},
      {:type => :AND, :value => 'and'},
      {:type => :NULL, :value => 'null'}
    ]
  end

  it "raises an exception when it hits an unrecognized token" do
    expect { lexer.tokenize(%q{This is Sparta ^}) }.to raise_error(Apiary::Honey::ParseError)
  end

end