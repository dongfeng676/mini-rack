require 'rack'
# 看一下env 内容
app = Proc.new do |env|
  p env
  ['200', {'Content-Type' => 'text/html'}, ['A barebones rack app.']]
end
Rack::Handler::WEBrick.run(app, Port: 5678)