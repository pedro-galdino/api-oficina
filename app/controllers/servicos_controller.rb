class ServicosController < AdminController
  before_action :set_servico, only: %i[ show edit update destroy ]

  # GET /servicos or /servicos.json
  def index
    @servicos = Servico.all
  end

  # GET /servicos/1 or /servicos/1.json
  def show
  end

  # GET /servicos/new
  def new
    @servico = Servico.new
  end

  # GET /servicos/1/edit
  def edit
  end

  # POST /servicos or /servicos.json
  def create
    @servico = Servico.new(servico_params)

    respond_to do |format|
      if @servico.present? && current_user.can_access?(@servico)
        format.html { redirect_to servico_url(@servico), notice: "Serviço cadastrado com sucesso." }
      else
        format.html { redirect_to root_path, alert: "Acesso negado." }
      end
    end
  end

  # PATCH/PUT /servicos/1 or /servicos/1.json
  def update
    respond_to do |format|
      if @servico.update(servico_params)
        format.html { redirect_to servico_url(@servico), notice: "Servico editado com sucesso." }
        format.json { render :show, status: :ok, location: @servico }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @servico.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /servicos/1 or /servicos/1.json
  def destroy
    @servico.destroy!

    respond_to do |format|
      format.html { redirect_to servicos_url, notice: "Servico excluído com sucesso." }
      format.json { head :no_content }
    end
  end

  private
end
# Use callbacks to share common setup or constraints between actions.
def set_servico
  @servico = Servico.find_by(id: params[:id])
  if @servico.nil?
    redirect_to servicos_path, notice: "Serviço não encontrado."
  end

  # Only allow a list of trusted parameters through.
  def servico_params
    params.require(:servico).permit(:codigo, :nome, :descricao, :preco)
  end
end
