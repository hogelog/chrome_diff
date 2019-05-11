RSpec.describe SeleniumDiff do
  let(:output) { File.join(tmp_path, "tmp.png") }

  describe "#run" do
    it "generates visual diff" do
      diff = SeleniumDiff.new
      expect(diff.run(from_url: "https://www.google.com/?q=hello", to_url: "https://www.google.com/?q=world", output: output)).to eq(false)
      expect(diff.run(from_url: "https://www.google.com/?q=hello", to_url: "https://www.google.com/?q=hello", output: output)).to eq(true)
    end
  end
end
