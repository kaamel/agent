role :prod, "axcoto.com"

task :search_http do
  run "ls -x1 /srv/http"
end

desc 'Count the number of app we have on server'
task :count_app do
  run "ls -x1 /srv/http | wc -l"
end

desc 'Cound the number of domain in using'
task :list_domain do
  run "ls -la /srv/http/domain"
end
