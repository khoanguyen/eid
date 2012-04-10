class ActiveModelBase
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveModel::Serialization
  include ActiveModel::MassAssignmentSecurity
  extend ActiveModel::Naming
  
  class << self
  def attribute(*args)
    @@attributes = []
    attr_accessor *args

    args.each do |a|
      @@attributes << a
    end
  end
  
  end
  
  def initialize(attributes = {})
    update(attributes)
  end
  
  def values
    Hash[@@attributes.collect { |a| [a, send("#{a.to_s}")] }]
  end
  
  def update(attributes = {})
    sanitize_for_mass_assignment(attributes)
    attributes.each do |name, value|
      send("#{name}=", value) if self.respond_to? :"#{name}="
    end
  end
end