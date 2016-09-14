class V1::ArenasController < V1::V1Controller
  before_action :authenticate_user!
  before_action :check_admin_permissions, only: [:create, :update]  
  before_action :check_arena, only: [:show, :update] 

  def index
    @arenas = Arena.all
    respond_with @arenas
  end

  def show
    respond_with @arena
  end


  #Admin only RESTful create
  def create
    @arena = Arena.new(arena_params)
    @arena.updated_by = account_id
    @arena.created_by = account_id   

    return head(:internal_server_error) unless @arena.save

    respond_with @arena
  end


  #Admin only RESTful update
  def update
    @arena.updated_by = account_id

    return head(:internal_server_error) unless @arena.update(arena_params)

    respond_with @arena
  end

  private
    def check_arena
      @arena = Arena.find_by_id(params[:id])
      return head(:not_found) unless @arena.present?
    end

    def arena_params
      params.permit(:name, :description, :rated, :url, :port)
    end
end
