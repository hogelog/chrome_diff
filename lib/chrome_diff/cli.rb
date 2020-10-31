require "optparse"

module ChromeDiff
  class CLI
    def self.run(argv)
      opts = ChromeDiff::DEFAULT_OPTIONS.merge(parse_argv(argv.dup))
      result = ChromeDiff.run(**opts)
      output = opts[:output]

      unless opts[:quiet]
        if result.success?
          message = "There is no difference (%.2f%%)" % result.diff_percent
        else
          message = "There are some diffefences (%.2f%%)" % result.diff_percent
        end
        message += ": #{output}" if output
        puts message
      end

      result
    end

    def self.parse_argv(argv)
      opts = {}
      parser = OptionParser.new
      parser.on("-f [FROM_URL]", "--from-url", "From url") {|v| opts[:from_url] = v }
      parser.on("-t [TO_URL]", "--to-url", "To url") {|v| opts[:to_url] = v }
      parser.on("-o [OUTPUT]", "--output", "Output file") {|v| opts[:output] = v }
      parser.on("-w [WIDTH]", "--width", "Window width (default 800)") {|v| opts[:width] = v.to_i }
      parser.on("-h [HEIGHT]", "--height", "Window height (default 600)") {|v| opts[:height] = v.to_i }
      parser.on("-q", "--quiet", "Quiet mode") {|v| opts[:quiet] = v }
      parser.on("--fuzz [FUZZ]", "Fuzz factor percent (default 5%)") {|v| opts[:fuzz] = v.to_f }
      parser.on("--debug", "Debug mode (default false)") {|v| opts[:debug] = !!v }
      parser.on("--no-output", "Don't output diff file") {|v| opts[:output] = v }
      parser.parse(argv)

      required(opts, :from_url)
      required(opts, :to_url)

      opts
    rescue ArgumentError => e
      STDERR.puts(e.message)
      puts(parser.help)
      exit 1
    end

    def self.required(opts, key)
      arg_key = "--#{key.to_s.gsub("_", "-")}"
      opts[key] or raise ArgumentError, "#{arg_key} is required"
    end
  end
end
