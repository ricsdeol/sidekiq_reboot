#!/usr/bin/env ruby

apache_files = Dir.glob '/etc/apache2/sites-enabled/*.conf'

apache_files.each do |apache_file|
  apache_conf = File.read apache_file

  /(DocumentRoot)[[:space:]]*(?<app_path>[[:graph:]]*)\/public/ =~ apache_conf
  /(Env)[[:space:]]*(?<rails_env>[[:graph:]]*)/i =~ apache_conf

  command = <<-BASH
    cd #{app_path} ; nohup bundle exec sidekiq -e #{rails_env} -C  #{app_path}/config/sidekiq.yml -i 0 -P  #{app_path}/tmp/pids/sidekiq.pid >>  #{app_path}/log/sidekiq.log 2>&1 &
  BASH

  puts "#{Time.now}: #{system(command) ? 'sucesso' : 'erro'} - #{app_path}" if File.exist? "#{app_path}/config/sidekiq.yml"
end
