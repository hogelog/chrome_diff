RSpec.describe SeleniumDiff do
  let(:output) { File.join(tmp_path, "tmp.png") }

  describe "#run" do
    it "generates visual diff" do
      session = SeleniumDiff::Session.new
      expect(session.run(from_url: "https://www.google.com/?q=hello", to_url: "https://www.google.com/?q=world", output: File.join(tmp_path, "diff.png"))).to eq(false)
      expect(session.run(from_url: "https://www.google.com/?q=hello", to_url: "https://www.google.com/?q=hello", output: File.join(tmp_path, "same.png"))).to eq(true)
    end
  end
end
