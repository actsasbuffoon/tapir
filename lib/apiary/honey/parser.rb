module Apiary
  module Honey
    class Parser

      def parse(nodes)
        statements = nodes.slice_before {|node| node[:type] == :AND}.to_a
        statements.map.with_index do |s, i|
          if i == 0
            parse_statement s
          else
            parse_statement s[1..-1]
          end
        end
      end

      private

      OPERATIONS = {
        EQ: {
          :left => {
            types: [:IDENTIFIER, :FIELD],
            required: true
          },
          :right => {
            :max => 1,
            :min => 1,
            :types => [:NULL, :INTEGER, :DECIMAL, :STRING]
          }
        },
        GT: {
          :left => {
            :types => [:IDENTIFIER, :FIELD],
            :required => true
          },
          :right => {
            :max => 1,
            :min => 1,
            :types => [:INTEGER, :DECIMAL]
          }
        },
        GE: {
          :left => {
            types: [:IDENTIFIER, :FIELD],
            required: true
          },
          :right => {
            :max => 1,
            :min => 1,
            :types => [:INTEGER, :DECIMAL]
          }  
        },
        LT: {
          :left => {
            types: [:IDENTIFIER, :FIELD],
            required: true
          },
          :right => {
            :max => 1,
            :min => 1,
            :types => [:INTEGER, :DECIMAL]
          }
        },
        LE: {
          :left => {
            types: [:IDENTIFIER, :FIELD],
            required: true
          },
          :right => {
            :max => 1,
            :min => 1,
            :types => [:INTEGER, :DECIMAL]
          }
        },
        IN: {
          :left => {
            types: [:IDENTIFIER, :FIELD],
            required: true
          },
          :right => {
            :max => false,
            :min => 1,
            :types => [:NULL, :STRING, :INTEGER, :DECIMAL]
          }  
        },
        NOT: {
          :left => {
            types: [:IDENTIFIER, :FIELD],
            required: true
          },
          :right => {
            :max => 1,
            :min => 1,
            :types => [:NULL, :INTEGER, :DECIMAL, :STRING]
          }
        },
        NIN: {
          :left => {
            types: [:IDENTIFIER, :FIELD],
            required: true
          },
          :right => {
            :max => false,
            :min => 1,
            :types => [:NULL, :STRING, :INTEGER, :DECIMAL]
          }
        },
        LIKE: {
          :left => {
            types: [:IDENTIFIER, :FIELD],
            required: true
          },
          :right => {
            :max => 1,
            :min => 1,
            :types => [:STRING]
          }
        },
        PAGE: {
          :left => {
            types: [:IDENTIFIER],
            required: false
          },
          :right => {
            :max => 1,
            :min => 1,
            :types => [:INTEGER]
          }
        },
        PAGE_SIZE: {
          :left => {
            types: [:IDENTIFIER],
            required: false
          },
          :right => {
            :max => 1,
            :min => 1,
            :types => [:INTEGER]
          }
        },
        SORT: {
          :left => {
            types: [:IDENTIFIER, :FIELD],
            required: true
          },
          :right => {
            :max => 1,
            :min => 0,
            :types => [:DIRECTION]
          }
        },
        INCLUDES: {
          left: {
            types: [:IDENTIFIER],
            required: false
          },
          right: {
            max: 1,
            min: 1,
            types: [:IDENTIFIER]
          }
        }
      }

      def parse_statement(nodes)
        sections = nodes.chunk { |node| OPERATIONS.keys.include?(node[:type]) if node[:type] }.to_a
        if sections.length == 2
          if sections.first.first
            parse_operation [], sections.first.last.first, sections.last.last
          else
            parse_operation sections.first.last.first, sections.last.last.first, []
          end
        elsif sections.length == 3 && sections[1].first
          parse_operation sections.first.last.first, sections[1].last.first, sections.last.last
        else
          raise ParseError, "Cannot parse statement: #{nodes.inspect}"
        end
      end

      def parse_operation(left, operation, right)
        op = OPERATIONS[operation[:type]]
        raise ParseError, "field name required" if left.length == 0 && op[:left][:required]
        raise ParseError, "no more than #{op[:right][:max]} argument#{'s' unless op[:right][:max] == 1} allowed" if op[:right][:max] && right.length > op[:right][:max]
        raise ParseError, "At least #{op[:right][:min]} argument#{'s' unless op[:right][:min] == 1} required" if right.length < op[:right][:min]
        raise ParseError, "Left-side argument can only be of type#{'s' if op[:left][:types].length != 1} #{op[:left][:types].sort.join ', '}" if left.length > 0 && !op[:left][:types].include?(left[:type])
        raise ParseError, "Only #{op[:right][:types].sort.join ', '} arguments are allowed" if right.length > 0 && !right.any? {|r| op[:right][:types].include? r[:type]}
        r = {operation: operation[:type]}
        r[:values] = right if right.length > 0
        r[:field] = left if left.length > 0
        r
      end

    end
  end
end