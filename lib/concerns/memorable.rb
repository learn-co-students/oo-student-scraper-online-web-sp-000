module Memorable
  module ClassMethods
    def destroy_all
      all.clear
    end

    def count
      all.count
    end
  end
  module InstanceMethods
    def initialize
      self.class.all << self
    end

    def save
      self.class.all << self
    end
  end
end
