# Helper methods defined here can be accessed in any controller or view in the application

SysAdmin.helpers do
  # def simple_helper_method
  #  ...
  # end
  DEFAULT_PAGE = 1
  DEFAULT_PAGE_SIZE = 30
  DEFAULT_SORT = :_id
  
  def page_param
    page = params[:page].to_i
    page = DEFAULT_PAGE if page == 0
    page
  end
  
  def size_param
    size = params[:size].to_i
    size = DEFAULT_PAGE_SIZE if size == 0
    size
  end
  
  def sort_param
    sort = params[:sort] || DEFAULT_SORT
    field = sort.to_s.split(/_desc$/)[0]
    if sort =~ /_desc$/
      field.to_sym.desc
    else
      field.to_sym
    end
  end
  
end
