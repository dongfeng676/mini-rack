require 'rack'
# 嵌套的概念。
app = Proc.new do |env|
  rand_num = rand(3)
  sleep(rand_num)
  ['200', {'Content-Type' => 'text/html'}, ["A barebones rack app. #{rand_num}"]]
end

class Timing
  def initialize(app)
    @app = app
  end

  def call(env)
    ts = Time.now
    status, headers, body = @app.call(env)
    elapsed_time = Time.now - ts
    puts "Timing: #{env['REQUEST_METHOD']} #{env['REQUEST_URI']} #{elapsed_time.round(3)}"
    [status, headers, body]
  rescue => e
    ['500', headers, 'server error']
  end
end

app = Timing.new(app)
Rack::Handler::WEBrick.run(app, Port: 5678)