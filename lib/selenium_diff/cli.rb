require "optparse"

class SeleniumDiff
  class CLI
    def self.run(argv)
      opts = parse_argv(argv.dup)

      from = opts[:from_url]
      to = opts[:to_url]
      output = opts[:output]

      status = SeleniumDiff.new.run(from_url: from, to_url: to, output: output)

      unless opts[:quiet]
        puts "Visual diff generated: #{output}"
        if status
          puts "No differences found: #{from} -> #{to}"
        else
          puts "There are some differences: #{from} -> #{to}"
        end
      end
    end

    def self.parse_argv(argv)
      opts = {}
      parser = OptionParser.new
      parser.on("-f [FROM_URL]", "--from-url", "From url") {|v| opts[:from_url] = v }
      parser.on("-t [TO_URL]", "--to-url", "To url") {|v| opts[:to_url] = v }
      parser.on("-o [OUTPUT]", "--output", "Output file") {|v| opts[:output] = v }
      parser.on("-q", "--quiet", "Quiet mode") {|v| opts[:quiet] = v }
      parser.parse(argv)

      required(opts, :from_url)
      required(opts, :to_url)
      opts[:output] ||= "diff.png"

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
