# -*- encoding: utf-8 -*-
# stub: wei-backend 0.1.4 ruby lib

Gem::Specification.new do |s|
  s.name = "wei-backend"
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Wang Chao"]
  s.date = "2014-03-28"
  s.description = "wei-backend is a DSL for quickly creating weixin open platform backend system."
  s.email = "cwang8023@gmail.com"
  s.homepage = "https://github.com/charleyw/weixin-sinatra"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "Best DSL for weixin development"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>, ["~> 1.4.4"])
      s.add_runtime_dependency(%q<nokogiri>, ["~> 1.6.0"])
      s.add_runtime_dependency(%q<haml>, ["~> 4.0.4"])
      s.add_runtime_dependency(%q<json>, ["~> 1.8"])
    else
      s.add_dependency(%q<sinatra>, ["~> 1.4.4"])
      s.add_dependency(%q<nokogiri>, ["~> 1.6.0"])
      s.add_dependency(%q<haml>, ["~> 4.0.4"])
      s.add_dependency(%q<json>, ["~> 1.8"])
    end
  else
    s.add_dependency(%q<sinatra>, ["~> 1.4.4"])
    s.add_dependency(%q<nokogiri>, ["~> 1.6.0"])
    s.add_dependency(%q<haml>, ["~> 4.0.4"])
    s.add_dependency(%q<json>, ["~> 1.8"])
  end
end
