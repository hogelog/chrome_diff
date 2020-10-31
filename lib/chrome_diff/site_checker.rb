require "fileutils"

module ChromeDiff
  class SiteChecker
    def initialize(domains:, sizes:, paths:, options: {})
      @domains = domains
      @sizes = sizes
      @paths = paths
      @options = options
    end

    def run
      options = @options.dup
      @sizes.each do |size|
        shots_dir = File.join("shots", size.map(&:to_s).join("x"))
        FileUtils.mkdir_p(shots_dir)

        options.merge()
        timeout = options.delete(:timeout)
        debug = options.delete(:debug) || false
        session = ChromeDiff::Session.new(width: size[0], height: size[1], timeout: timeout, debug: debug)

        html = ""
        images = []
        @paths.each do |name, path|
          from = "#{@domains[0]}#{path}"
          to = "#{@domains[1]}#{path}"
          filename = "#{name}.png"
          output = File.join(shots_dir, filename)
          result = session.compare(from_url: from, to_url: to, output: output)
          puts "#{output} (%.2f%%)" % result.diff_percent

          title = "#{filename} (%.2f%%)" % result.diff_percent
          images << [name, title]
          html += <<~HTML
            <h2 id="#{ name }">#{ title }</h2>
            <ul>
              <li><a href="#{from}">#{from}</a></li>
              <li><a href="#{to}">#{to}</a></li>
              <li>
                <a href="#{ filename }">
                  <img src="#{ filename }">
                </a>
              </li>
            </ul>
          HTML
        end

        html = "<ul>\n" + images.map{|name, title| "<li><a href='##{ name }'>#{ title }</a></li>"}.join("\n") + "</ul>\n\n" + html

        File.write(File.join(shots_dir, "index.html"), html)
      end
    end
  end
end
