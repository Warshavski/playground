module Books
  class Index
    def self.call
      Book.all
    end
  end 
end