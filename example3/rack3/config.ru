require './hello'
require './timing'
# rackup 命令来源于rack gem
use Timing
# 这里是gem rack 中的类 Rack::Builder
run Hello

