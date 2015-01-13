module Tictail
  class Printer
    def initialize(layout)
      @layout = layout
    end

    def print
      content = @layout.content

      File.open("theme.mustache", "w") do |f|
        f.write(content)
      end
      IO.popen('pbcopy', 'w').print content

      puts "Build successful! View your theme in theme.mustache (and it's added to your clipboard for convinient CMD+v into Tictail.com"
    end
  end
end
