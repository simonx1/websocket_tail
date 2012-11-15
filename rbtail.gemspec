$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name          = "RbTail"
  s.summary       = "File tail with WebSocket Server."
  s.description   = <<-eof
    File tail with WebSocket Server.
  eof
  s.version       = '0.0.1'
  s.date          = Time.now.strftime('%Y-%m-%d')
  s.author        = "Szymon Kurcab"
  s.email         = "skurcab@antennasoftware.com"
  s.homepage      = "http://www.antennasoftware.com"
  s.platform      = Gem::Platform::RUBY
  s.files         = Dir.glob("{bin,vendor}/**/*") +
    ['rbtail_ex.rb', 'index.html', 'Gemfile', 'Gemfile.lock', 'tail.rb', 'README.md', __FILE__]
  s.require_paths = ['lib']
  s.executables   = ['rbtail']
  s.has_rdoc      = 'nodoc'
  s.rubyforge_project = 'none'
end

