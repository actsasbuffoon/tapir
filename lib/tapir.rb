require_relative 'tapir/version'
require_relative 'tapir/permissions'
require_relative 'tapir/snout'
require_relative 'tapir/actions/create'
require_relative 'tapir/actions/destroy'
require_relative 'tapir/actions/update'
require_relative 'tapir/actions/show'
require_relative 'tapir/actions/index'

module Tapir
  @apis = {}

  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def api(name)
      
    end
  end

end