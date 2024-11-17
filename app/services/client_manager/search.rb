module ClientManager
  class Search
    def initialize(params)
      @params = params
    end

    def call
      if @params[:q_cpf_cont].present?
        search_clients
      else
        { error: I18n.t("activerecord.errors.messages.cpf_blank"), status: :bad_request }
      end
    end

    private

    def search_clients
      cpf = normalize_cpf(@params[:q_cpf_cont])
      client = Client.find_by(cpf: cpf)
      if client.present?
        { clients: [client], status: :ok }
      else
        { error: I18n.t("activerecord.errors.messages.client_notfound_cpf"), status: :not_found }
      end
    end

    def normalize_cpf(cpf)
      cpf.gsub(/\D/, '')
    end
  end
end
