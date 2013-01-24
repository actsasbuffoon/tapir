require_relative 'spec_helper.rb'

describe Tapir::Snout::Parser do
  
  let(:lexer) { Tapir::Snout::Lexer.new }
  let(:parser) { Tapir::Snout::Parser.new }
  
  it "parses an empty array" do
    parser.parse([]).should == []
  end

  it "raises an error when it encounters an unparsable statement" do
    nodes = lexer.tokenize %q{foo bar baz bat}

    expect { parser.parse nodes }.to raise_error(Tapir::Snout::ParseError)
  end

  describe "EQ statement" do
    it "parses correctly without a table prefix" do
      nodes = lexer.tokenize %q{role_id eq 4}

      parser.parse(nodes).should == [
        {
          operation: :EQ,
          field: {:type => :IDENTIFIER, :value => 'role_id'},
          values: [ {:type => :INTEGER, :value => '4'} ]
        }
      ]
    end

    it "parses correctly with a table prefix" do
      nodes = lexer.tokenize %q{user.role_id eq 4}

      parser.parse(nodes).should == [
        {
          operation: :EQ,
          field: {:type => :FIELD, :value => 'user.role_id'},
          values: [ {:type => :INTEGER, :value => '4'} ]
        }
      ]
    end

    it "raises an exception when the right-side argument isn't a field/identifier" do
      nodes = lexer.tokenize %q{20 eq 42}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /left-side argument can only be of types field, identifier/i)
    end

    it "raises an exception when no field is provided" do
      nodes = lexer.tokenize %q{eq 20}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /field name required/i)
    end

    it "raises an exception when no arguments are provided" do
      nodes = lexer.tokenize %q{role_id eq}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /At least 1 argument required/i)
    end

    it "raises an exception when too many arguments are provided" do
      nodes = lexer.tokenize %q{role_id eq 20 42}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /no more than 1 argument allowed/i)
    end

    it "raises an exception when the arguments are of the wrong type" do
      nodes = lexer.tokenize %q{role_id eq foo}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /only decimal, integer, null, string arguments are allowed/i)
    end
  end

  describe "GT statement" do
    it "parses correctly without a table prefix" do
      nodes = lexer.tokenize %q{role_id gt 4}

      parser.parse(nodes).should == [
        {
          operation: :GT,
          field: {:type => :IDENTIFIER, :value => 'role_id'},
          values: [ {:type => :INTEGER, :value => '4'} ]
        }
      ]
    end

    it "parses correctly with a table prefix" do
      nodes = lexer.tokenize %q{user.role_id gt 4}

      parser.parse(nodes).should == [
        {
          operation: :GT,
          field: {:type => :FIELD, :value => 'user.role_id'},
          values: [ {:type => :INTEGER, :value => '4'} ]
        }
      ]
    end

    it "raises an exception when no field is provided" do
      nodes = lexer.tokenize %q{gt 20}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /field name required/i)
    end

    it "raises an exception when no arguments are provided" do
      nodes = lexer.tokenize %q{role_id gt}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /At least 1 argument required/i)
    end

    it "raises an exception when too many arguments are provided" do
      nodes = lexer.tokenize %q{role_id gt 20 42}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /no more than 1 argument allowed/i)
    end

    it "raises an exception when the arguments are of the wrong type" do
      nodes = lexer.tokenize %q{role_id gt 'foo'}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /only decimal, integer arguments are allowed/i)
    end
  end

  describe "GE statement" do
    it "parses correctly without a table prefix" do
      nodes = lexer.tokenize %q{role_id ge 4}

      parser.parse(nodes).should == [
        {
          operation: :GE,
          field: {:type => :IDENTIFIER, :value => 'role_id'},
          values: [ {:type => :INTEGER, :value => '4'} ]
        }
      ]
    end

    it "parses correctly with a table prefix" do
      nodes = lexer.tokenize %q{user.role_id ge 4}

      parser.parse(nodes).should == [
        {
          operation: :GE,
          field: {:type => :FIELD, :value => 'user.role_id'},
          values: [ {:type => :INTEGER, :value => '4'} ]
        }
      ]
    end

    it "raises an exception when no field is provided" do
      nodes = lexer.tokenize %q{ge 20}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /field name required/i)
    end

    it "raises an exception when no arguments are provided" do
      nodes = lexer.tokenize %q{role_id ge}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /At least 1 argument required/i)
    end

    it "raises an exception when too many arguments are provided" do
      nodes = lexer.tokenize %q{role_id ge 20 42}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /no more than 1 argument allowed/i)
    end

    it "raises an exception when the arguments are of the wrong type" do
      nodes = lexer.tokenize %q{role_id ge 'foo'}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /only decimal, integer arguments are allowed/i)
    end
  end

  describe "LT statement" do
    it "parses correctly without a table prefix" do
      nodes = lexer.tokenize %q{role_id lt 4}

      parser.parse(nodes).should == [
        {
          operation: :LT,
          field: {:type => :IDENTIFIER, :value => 'role_id'},
          values: [ {:type => :INTEGER, :value => '4'} ]
        }
      ]
    end

    it "parses correctly with a table prefix" do
      nodes = lexer.tokenize %q{user.role_id lt 4}

      parser.parse(nodes).should == [
        {
          operation: :LT,
          field: {:type => :FIELD, :value => 'user.role_id'},
          values: [ {:type => :INTEGER, :value => '4'} ]
        }
      ]
    end

    it "raises an exception when no field is provided" do
      nodes = lexer.tokenize %q{lt 20}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /field name required/i)
    end

    it "raises an exception when no arguments are provided" do
      nodes = lexer.tokenize %q{role_id lt}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /At least 1 argument required/i)
    end

    it "raises an exception when too many arguments are provided" do
      nodes = lexer.tokenize %q{role_id lt 20 42}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /no more than 1 argument allowed/i)
    end

    it "raises an exception when the arguments are of the wrong type" do
      nodes = lexer.tokenize %q{role_id lt 'foo'}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /only decimal, integer arguments are allowed/i)
    end
  end

  describe "LE statement" do
    it "parses correctly without a table prefix" do
      nodes = lexer.tokenize %q{role_id le 4}

      parser.parse(nodes).should == [
        {
          operation: :LE,
          field: {:type => :IDENTIFIER, :value => 'role_id'},
          values: [ {:type => :INTEGER, :value => '4'} ]
        }
      ]
    end

    it "parses correctly with a table prefix" do
      nodes = lexer.tokenize %q{user.role_id le 4}

      parser.parse(nodes).should == [
        {
          operation: :LE,
          field: {:type => :FIELD, :value => 'user.role_id'},
          values: [ {:type => :INTEGER, :value => '4'} ]
        }
      ]
    end

    it "raises an exception when no field is provided" do
      nodes = lexer.tokenize %q{le 20}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /field name required/i)
    end

    it "raises an exception when no arguments are provided" do
      nodes = lexer.tokenize %q{role_id le}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /At least 1 argument required/i)
    end

    it "raises an exception when too many arguments are provided" do
      nodes = lexer.tokenize %q{role_id le 20 42}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /no more than 1 argument allowed/i)
    end

    it "raises an exception when the arguments are of the wrong type" do
      nodes = lexer.tokenize %q{role_id le 'foo'}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /only decimal, integer arguments are allowed/i)
    end
  end

  describe "IN statement" do
    it "parses correctly without a table prefix" do
      nodes = lexer.tokenize %q{role_id in 4}

      parser.parse(nodes).should == [
        {
          operation: :IN,
          field: {:type => :IDENTIFIER, :value => 'role_id'},
          values: [ {:type => :INTEGER, :value => '4'} ]
        }
      ]
    end

    it "parses correctly with a table prefix" do
      nodes = lexer.tokenize %q{user.role_id in 4}

      parser.parse(nodes).should == [
        {
          operation: :IN,
          field: {:type => :FIELD, :value => 'user.role_id'},
          values: [ {:type => :INTEGER, :value => '4'} ]
        }
      ]
    end

    it "raises an exception when no field is provided" do
      nodes = lexer.tokenize %q{in 20}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /field name required/i)
    end

    it "raises an exception when no arguments are provided" do
      nodes = lexer.tokenize %q{role_id in}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /At least 1 argument required/i)
    end

    it "raises an exception when the arguments are of the wrong type" do
      nodes = lexer.tokenize %q{role_id in foo}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /only DECIMAL, INTEGER, NULL, STRING arguments are allowed/i)
    end
  end

  describe "NOT statement" do
    it "parses correctly without a table prefix" do
      nodes = lexer.tokenize %q{role_id not 4}

      parser.parse(nodes).should == [
        {
          operation: :NOT,
          field: {:type => :IDENTIFIER, :value => 'role_id'},
          values: [ {:type => :INTEGER, :value => '4'} ]
        }
      ]
    end

    it "parses correctly with a table prefix" do
      nodes = lexer.tokenize %q{user.role_id not 4}

      parser.parse(nodes).should == [
        {
          operation: :NOT,
          field: {:type => :FIELD, :value => 'user.role_id'},
          values: [ {:type => :INTEGER, :value => '4'} ]
        }
      ]
    end

    it "raises an exception when no field is provided" do
      nodes = lexer.tokenize %q{not 20}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /field name required/i)
    end

    it "raises an exception when no arguments are provided" do
      nodes = lexer.tokenize %q{role_id not}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /At least 1 argument required/i)
    end

    it "raises an exception when too many arguments are provided" do
      nodes = lexer.tokenize %q{role_id not 20 42}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /no more than 1 argument allowed/i)
    end

    it "raises an exception when the arguments are of the wrong type" do
      nodes = lexer.tokenize %q{role_id not foo}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /only decimal, integer, null, string arguments are allowed/i)
    end
  end

  describe "NIN statement" do
    it "parses correctly without a table prefix" do
      nodes = lexer.tokenize %q{role_id nin 4}

      parser.parse(nodes).should == [
        {
          operation: :NIN,
          field: {:type => :IDENTIFIER, :value => 'role_id'},
          values: [ {:type => :INTEGER, :value => '4'} ]
        }
      ]
    end

    it "parses correctly with a table prefix" do
      nodes = lexer.tokenize %q{user.role_id nin 4}

      parser.parse(nodes).should == [
        {
          operation: :NIN,
          field: {:type => :FIELD, :value => 'user.role_id'},
          values: [ {:type => :INTEGER, :value => '4'} ]
        }
      ]
    end

    it "raises an exception when no field is provided" do
      nodes = lexer.tokenize %q{nin 20}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /field name required/i)
    end

    it "raises an exception when no arguments are provided" do
      nodes = lexer.tokenize %q{role_id nin}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /At least 1 argument required/i)
    end

    it "raises an exception when the arguments are of the wrong type" do
      nodes = lexer.tokenize %q{role_id nin baz}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /only decimal, integer, null, string arguments are allowed/i)
    end
  end

  describe "LIKE statement" do
    it "parses correctly without a table prefix" do
      nodes = lexer.tokenize %q{role_id like "Mich%"}

      parser.parse(nodes).should == [
        {
          operation: :LIKE,
          field: {:type => :IDENTIFIER, :value => 'role_id'},
          values: [ {:type => :STRING, :value => 'Mich%'} ]
        }
      ]
    end

    it "parses correctly with a table prefix" do
      nodes = lexer.tokenize %q{user.role_id like "Mich%"}

      parser.parse(nodes).should == [
        {
          operation: :LIKE,
          field: {:type => :FIELD, :value => 'user.role_id'},
          values: [ {:type => :STRING, :value => 'Mich%'} ]
        }
      ]
    end

    it "raises an exception when no field is provided" do
      nodes = lexer.tokenize %q{like 20}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /field name required/i)
    end

    it "raises an exception when no arguments are provided" do
      nodes = lexer.tokenize %q{role_id like}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /At least 1 argument required/i)
    end

    it "raises an exception when too many arguments are provided" do
      nodes = lexer.tokenize %q{role_id like 20 42}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /no more than 1 argument allowed/i)
    end

    it "raises an exception when the arguments are of the wrong type" do
      nodes = lexer.tokenize %q{role_id like 42}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /only string arguments are allowed/i)
    end
  end

  describe "PAGE statement" do
    it "parses correctly without a table prefix" do
      nodes = lexer.tokenize %q{page 4}

      parser.parse(nodes).should == [
        {
          operation: :PAGE,
          values: [ {:type => :INTEGER, :value => '4'} ]
        }
      ]
    end

    it "parses correctly with a table prefix" do
      nodes = lexer.tokenize %q{user page 4}

      parser.parse(nodes).should == [
        {
          operation: :PAGE,
          field: {:type => :IDENTIFIER, :value => 'user'},
          values: [ {:type => :INTEGER, :value => '4'} ]
        }
      ]
    end

    it "raises an exception when no arguments are provided" do
      nodes = lexer.tokenize %q{role_id page}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /At least 1 argument required/i)
    end

    it "raises an exception when too many arguments are provided" do
      nodes = lexer.tokenize %q{role_id page 20 42}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /no more than 1 argument allowed/i)
    end

    it "raises an exception when the arguments are of the wrong type" do
      nodes = lexer.tokenize %q{role_id page 'foo'}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /only integer arguments are allowed/i)
    end
  end

  describe "PAGE_SIZE statement" do
    it "parses correctly without a table prefix" do
      nodes = lexer.tokenize %q{role_id page_size 4}

      parser.parse(nodes).should == [
        {
          operation: :PAGE_SIZE,
          field: {:type => :IDENTIFIER, :value => 'role_id'},
          values: [ {:type => :INTEGER, :value => '4'} ]
        }
      ]
    end

    it "only accepts table names, not fields" do
      nodes = lexer.tokenize %q{user.role_id page_size 4}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /Left-side argument can only be of type IDENTIFIER/)
    end

    it "raises an exception when no arguments are provided" do
      nodes = lexer.tokenize %q{role_id page_size}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /At least 1 argument required/i)
    end

    it "raises an exception when too many arguments are provided" do
      nodes = lexer.tokenize %q{role_id page_size 20 42}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /no more than 1 argument allowed/i)
    end

    it "raises an exception when the arguments are of the wrong type" do
      nodes = lexer.tokenize %q{role_id page_size 'foo'}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /only integer arguments are allowed/i)
    end
  end

  describe "SORT statement" do
    it "parses correctly without a table prefix" do
      nodes = lexer.tokenize %q{role_id sort}

      parser.parse(nodes).should == [
        {
          operation: :SORT,
          field: {:type => :IDENTIFIER, :value => 'role_id'}
        }
      ]
    end

    it "parses correctly with a table prefix" do
      nodes = lexer.tokenize %q{user.role_id sort}

      parser.parse(nodes).should == [
        {
          operation: :SORT,
          field: {:type => :FIELD, :value => 'user.role_id'}
        }
      ]
    end

    it "parses correctly with a direction" do
      nodes = lexer.tokenize %q{role_id sort desc}

      parser.parse(nodes).should == [
        {
          operation: :SORT,
          field: {:type => :IDENTIFIER, :value => 'role_id'},
          values: [{:type => :DIRECTION, :value => 'desc'}]
        }
      ]
    end

    it "parses correctly with a table prefix and direction" do
      nodes = lexer.tokenize %q{user.role_id sort asc}

      parser.parse(nodes).should == [
        {
          operation: :SORT,
          field: {:type => :FIELD, :value => 'user.role_id'},
          values: [{:type => :DIRECTION, value: 'asc'}]
        }
      ]
    end

    it "raises an exception when no field is provided" do
      nodes = lexer.tokenize %q{sort desc}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /field name required/i)
    end

    it "raises an exception when too many arguments are provided" do
      nodes = lexer.tokenize %q{role_id sort desc asc}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /no more than 1 argument allowed/i)
    end

    it "raises an exception when the arguments are of the wrong type" do
      nodes = lexer.tokenize %q{role_id sort 'foo'}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /only direction arguments are allowed/i)
    end
  end

  describe "INCLUDES statement" do
    it "parses correctly without a table prefix" do
      nodes = lexer.tokenize %q{includes roles}

      parser.parse(nodes).should == [
        {
          operation: :INCLUDES,
          values: [ {:type => :IDENTIFIER, :value => 'roles'} ]
        }
      ]
    end

    it "parses correctly with a table prefix" do
      nodes = lexer.tokenize %q{users includes roles}
      parser.parse(nodes).should == [
        {
          operation: :INCLUDES,
          field: {:type => :IDENTIFIER, :value => 'users'},
          values: [ {:type => :IDENTIFIER, :value => 'roles'} ]
        }
      ]
    end

    it "raises an exception when no arguments are provided" do
      nodes = lexer.tokenize %q{user includes}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /At least 1 argument required/i)
    end

    it "raises an exception when too many arguments are provided" do
      nodes = lexer.tokenize %q{users includes roles purchases}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /no more than 1 argument allowed/i)
    end

    it "raises an exception when the arguments are of the wrong type" do
      nodes = lexer.tokenize %q{users includes 'roles'}

      expect { parser.parse nodes }.to raise_exception(Tapir::Snout::ParseError, /only identifier arguments are allowed/i)
    end
  end

  it "parses statements joined with and" do
    nodes = lexer.tokenize %q{name eq 'Michael' and role_id ge 4}

    parser.parse(nodes).should == [
      {
        operation: :EQ,
        field: {:type => :IDENTIFIER, :value => 'name'},
        values: [ {:type => :STRING, :value => 'Michael'} ]
      },
      {
        operation: :GE,
        field: {:type => :IDENTIFIER, :value => 'role_id'},
        values: [ {:type => :INTEGER, :value => '4'} ]
      }
    ]
  end

  it "parses an operation with multiple values" do
    nodes = lexer.tokenize %q{role_id in 3, 4, 7}

    parser.parse(nodes).should == [
      {
        operation: :IN,
        field: {:type => :IDENTIFIER, :value => 'role_id'},
        values: [
          {:type => :INTEGER, :value => '3'},
          {:type => :INTEGER, :value => '4'},
          {:type => :INTEGER, :value => '7'}
        ]
      }
    ]
  end
end