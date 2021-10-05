class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def initialize(*args, &block); end

  def call
    raise NotImplementedError
  end
end