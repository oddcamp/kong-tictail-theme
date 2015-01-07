description = "Script usage: rake fetch TICTAIL_EMAIL=<tictail-email> TICTAIL_PASSWORD=<tictail-password>"
require_relative '../../app'

desc description
task :fetch do
  if !ENV['TICTAIL_EMAIL'] && !ENV['TICTAIL_PASSWORD']
    puts description
    exit
  end

  fetcher = Tictail::Fetcher.new(ENV['TICTAIL_EMAIL'], ENV['TICTAIL_PASSWORD'])
  fetcher.save
end
