SysAdmin.controllers :admins, :conditions => {:protect => :require_admin} do
  
  get :index do
    page = page_param
    size = size_param
    sort = sort_param
    
    result_set = admin_remap_set Admin.sort(sort).limit(size).skip((page - 1) * size)
    r result_set, :total => Admin.count, :page => page, :size => size, :sort => sort
  end
  
  get :columns do
    admin_white_list.to_json
  end
end
