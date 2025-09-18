#!/usr/bin/env ruby

require 'net/http'
require 'uri'

def test_route(path, description)
  begin
    uri = URI("http://localhost:3000#{path}")
    response = Net::HTTP.get_response(uri)
    status = response.code.to_i
    
    if status == 200
      puts "✅ #{description} - Status: #{status} - OK"
      return true
    elsif status == 302
      puts "🔄 #{description} - Status: #{status} - Redirect (normal para auth)"
      return true
    else
      puts "❌ #{description} - Status: #{status} - ERROR"
      return false
    end
  rescue => e
    puts "❌ #{description} - Error: #{e.message}"
    return false
  end
end

puts "=== TESTANDO VIEWS DA APLICAÇÃO ASSISTECH ==="
puts

# Testa rotas principais
routes_to_test = [
  ["/", "Página inicial (Home)"],
  ["/tickets", "Lista de tickets"],
  ["/tickets/new", "Novo ticket"],
  ["/clients", "Lista de clientes"],
  ["/clients/new", "Novo cliente"],
  ["/mobile_devices", "Lista de dispositivos móveis"],
  ["/mobile_devices/new", "Novo dispositivo móvel"],
  ["/tickets/status/Pendente", "Tickets pendentes"],
  ["/tickets/status/Em_Andamento", "Tickets em andamento"],
  ["/tickets/status/Concluido", "Tickets concluídos"],
  ["/clients/search", "Busca de clientes"],
  ["/mobile_devices/search", "Busca de dispositivos"]
]

successful_tests = 0
total_tests = routes_to_test.length

routes_to_test.each do |path, description|
  if test_route(path, description)
    successful_tests += 1
  end
  sleep 0.5  # Pausa pequena entre requisições
end

puts
puts "=== RESULTADO DOS TESTES ==="
puts "Testes executados: #{total_tests}"
puts "Testes bem-sucedidos: #{successful_tests}"
puts "Taxa de sucesso: #{(successful_tests.to_f / total_tests * 100).round(2)}%"

if successful_tests == total_tests
  puts "🎉 Todas as views estão funcionando corretamente!"
else
  puts "⚠️  Algumas views apresentaram problemas."
end