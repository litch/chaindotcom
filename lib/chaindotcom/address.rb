module Chaindotcom::Ghostly
  module Macros
    private
    def lazy_accessor(*names)
      names.each do |name|
        attr_writer name
        define_method(name) do
          load
          instance_variable_get("@#{name}")
        end
      end
    end
  end

  def self.included(other)
    other.extend(Macros)
  end

  attr_accessor :data_source
  attr_writer   :load_state

  def load_state
    @load_state ||= :ghost
  end

  def load
    return if load_state == :loaded
    data_source.load(self)
  end
end

class Chaindotcom::Address
  include Chaindotcom::Ghostly

  attr_accessor :hash

  lazy_accessor :balance,
                :received,
                :sent,
                :unconfirmed_received,
                :unconfirmed_sent,
                :unconfirmed_balance

  def initialize(attributes={})
    attributes.each do |key, value|
      public_send("#{key}=", value)
    end
    @data_source ||= Chaindotcom::AddressMapper.new
  end

  def to_s
    inspect
  end

  def ==(other)
    other.is_a?(Address) && other.hash == hash
  end

end
