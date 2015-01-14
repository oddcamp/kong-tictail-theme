module Tictail
  class Printer
    def initialize(layout, file = "theme.mustache")
      @layout = layout
      @file = file
    end

    def print
      content = @layout.content

      File.open(@file, "w") do |f|
        f.write(content)
      end
      IO.popen('pbcopy', 'w').print content

      puts "Build successful! View your theme in #{@file} (and it's added to your clipboard for convinient CMD+v into Tictail.com"
    end
  end
end
