# Helper methods defined here can be accessed in any controller or view in the application

SysAdmin.helpers do
  # def simple_helper_method
  #  ...
  # end
  @@admin_white_list = { 
    :_id => lambda { |model| model._id },
    :fullname => lambda { |model| "Dummy" } 
  } 
  
  def admin_white_list
    @@white_list.keys
  end
  
  def admin_remap(admin, attr_list = @@white_list.keys)
    result = {}
    attr_list.each do |a|
      result[a] = @@admin_white_list[a].call(admin) if @@admin_white_list.has_key?(a)
    end
    result
  end
  
  def admin_remap_set(admins, attr_list = @@admin_white_list.keys)
    admins.map { |admin| admin_remap(admin, attr_list) }
  end
  
end
