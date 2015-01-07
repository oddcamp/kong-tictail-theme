fetch_description = "Script usage: rake fetch TICTAIL_EMAIL=<tictail-email> TICTAIL_PASSWORD=<tictail-password>"
require_relative '../../app'

desc fetch_description
task :fetch do
  if !ENV['TICTAIL_EMAIL'] || !ENV['TICTAIL_PASSWORD']
    puts fetch_description
    exit
  end

  fetcher = Tictail::Fetcher.new(ENV['TICTAIL_EMAIL'], ENV['TICTAIL_PASSWORD'])
  fetcher.save
end

desc "Print your theme into theme.mustache (and clipboard)"
task :print do
  Tictail::Printer.new
end
