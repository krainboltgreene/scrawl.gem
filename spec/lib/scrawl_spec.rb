require "spec_helper"

RSpec.describe Scrawl do
  let(:inputs) { [input] }
  let(:scrawl) { described_class.new(*inputs) }

  shared_context "for single input" do
    let(:input) do
      { "a" => "a" }
    end

    let(:output) do
      'a="a"'
    end
  end

  shared_context "for multiple input" do
    let(:input) do
      { "a" => "a", "b" => "b" }
    end

    let(:output) do
      'a="a" b="b"'
    end
  end

  shared_examples "for output" do
    it "joins the key value together with an ="  do
      expect(function).to eq(output)
    end
  end

  describe "#inspect" do
    let(:namespace) do
      nil
    end
    let(:function) do
      scrawl.inspect(namespace)
    end

    context "with single input" do
      context "with a namespace" do
        include_context "for single input"

        let(:namespace) do
          "a"
        end
        let(:output) do
          'a.a="a"'
        end

        it "combines the namespace keys" do
          expect(function).to eq(output)
        end
      end

      context "that is a string" do
        let(:input) do
          { "a" => "a" }
        end
        let(:output) do
          'a="a"'
        end

        include_examples "for output"
      end

      context "that is a nil" do
        let(:input) do
          { "a" => nil }
        end
        let(:output) do
          ''
        end

        include_examples "for output"
      end

      context "that is a numeric" do
        let(:input) do
          { "a" => 1 }
        end
        let(:output) do
          'a=1'
        end

        include_examples "for output"
      end

      context "that is a lambda" do
        let(:input) do
          { "a" => -> { "a" + "a" } }
        end
        let(:output) do
          'a="aa"'
        end

        include_examples "for output"
      end

      context "that is an empty hash" do
        let(:input) do
          { "a" => {} }
        end
        let(:output) do
          ''
        end

        include_examples "for output"
      end

      context "that is a hash" do
        let(:input) do
          { "a" => { "a" => "a" } }
        end
        let(:output) do
          'a.a="a"'
        end

        include_examples "for output"
      end

      context "that is a empty array" do
        let(:input) do
          { "a" => [] }
        end
        let(:output) do
          ''
        end

        include_examples "for output"
      end

      context "that is a array" do
        let(:input) do
          { "a" => ["b", "c"] }
        end
        let(:output) do
          'a.*="b" a.*="c"'
        end

        include_examples "for output"
      end

      context "that is a scrawl" do
        let(:input) do
          { "a" => Scrawl.new({ "a" => "a" }) }
        end
        let(:output) do
          'a.a="a"'
        end

        include_examples "for output"
      end
    end

    context "with multiple input" do
      context "that are strings" do
        let(:input) do
          { "a" => "a", "b" => "b" }
        end
        let(:output) do
          'a="a" b="b"'
        end

        include_examples "for output"
      end

      context "that are nils" do
        let(:input) do
          { "a" => nil, "b" => nil }
        end
        let(:output) do
          ''
        end

        include_examples "for output"
      end

      context "that are numerics" do
        let(:input) do
          { "a" => 1, "b" => 2 }
        end
        let(:output) do
          'a=1 b=2'
        end

        include_examples "for output"
      end

      context "that are lambdas" do
        let(:input) do
          { "a" => -> { "a" + "a" }, "b" => -> { "b" + "b" } }
        end
        let(:output) do
          'a="aa" b="bb"'
        end

        include_examples "for output"
      end

      context "that are empty hashs" do
        let(:input) do
          { "a" => {}, "b" => {} }
        end
        let(:output) do
          ''
        end

        include_examples "for output"
      end

      context "that are hashs" do
        let(:input) do
          { "a" => { "a" => "a" }, "b" => { "b" => "b" } }
        end
        let(:output) do
          'a.a="a" b.b="b"'
        end

        include_examples "for output"
      end

      context "that are empty arrays" do
        let(:input) do
          { "a" => [], "b" => [] }
        end
        let(:output) do
          ''
        end

        include_examples "for output"
      end

      context "that are arrays" do
        let(:input) do
          { "a" => ["b", "c"], "b" => ["e", "f"] }
        end
        let(:output) do
          'a.*="b" a.*="c" b.*="e" b.*="f"'
        end

        include_examples "for output"
      end

      context "that are scrawls" do
        let(:input) do
          { "a" => Scrawl.new({ "a" => "a" }), "b" => Scrawl.new({ "b" => "b" }) }
        end
        let(:output) do
          'a.a="a" b.b="b"'
        end

        include_examples "for output"
      end
    end
  end

  describe "#to_s" do
    include_context "for single input"
    it "uses inspect with no namespace" do
      expect(scrawl).to receive(:inspect).with(nil)
      scrawl.to_s
    end
  end

end
