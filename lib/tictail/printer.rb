module Tictail
  class Printer
    def initialize(layout)
      @layout = layout
    end

    def print
      File.open("theme.mustache", "w") do |f|
        f.write(@layout.content)
      end
      IO.popen('pbcopy', 'w').print @layout.content

      puts "Build successful! View your theme in theme.mustache (and it's added to your clipboard for convinient CMD+v into Tictail.com"
    end
  end
end
