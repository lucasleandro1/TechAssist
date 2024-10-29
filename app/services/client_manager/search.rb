module ClientManager
  class Search
    def initialize(params)
      @params = params
    end

    def call
      if @params[:q_cpf_cont].present?
        search_clients
      else
        { error: "CPF query parameter is missing.", status: :bad_request }
      end
    end

    private

    def search_clients
      cpf = normalize_cpf(@params[:q_cpf_cont])
      client = Client.find_by(cpf: cpf)
      if client.present?
        { clients: [client], status: :ok }
      else
        { error: "No clients found with the provided CPF.", status: :not_found }
      end
    end

    def normalize_cpf(cpf)
      cpf.gsub(/\D/, '')
    end
  end
end
