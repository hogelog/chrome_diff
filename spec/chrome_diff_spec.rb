RSpec.describe ChromeDiff do
  let(:output) { File.join(tmp_path, "tmp.png") }

  describe "#run" do
    it "generates visual diff" do
      session = ChromeDiff::Session.new
      expect(session.run(from_url: "https://example.com/", to_url: "https://www.mozilla.org/", output: File.join(tmp_path, "diff.png"))).not_to be_success
      expect(session.run(from_url: "https://example.com/", to_url: "https://example.com/", output: File.join(tmp_path, "same.png"))).to be_success
    end
  end
end
