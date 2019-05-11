RSpec.describe SeleniumDiff do
  let(:from_url) { "https://www.google.com/?q=hello" }
  let(:to_url) { "https://www.google.com/?q=world" }
  let(:output) { File.join(tmp_path, "tmp.png") }

  describe "#run" do
    it "generates visual diff" do
      diff = SeleniumDiff.new
      diff.run(from_url: from_url, to_url: to_url, output: output)
    end
  end
end
