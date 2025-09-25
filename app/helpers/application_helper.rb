module ApplicationHelper
  def status_color(status)
    case status
    when "Pendente"
      "warning"
    when "Em andamento"
      "info"
    when "Orçamento aprovado"
      "success"
    when "Orçamento reprovado"
      "danger"
    when "Pedido reprovado entregue"
      "secondary"
    when "Peça em transito"
      "primary"
    when "Reparo concluído"
      "success"
    when "Pedido entregue"
      "dark"
    else
      "secondary"
    end
  end


end
