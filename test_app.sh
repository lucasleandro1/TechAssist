#!/bin/bash

echo "=== TESTE AUTOMATIZADO DO TECHASSIST ==="
echo "Data: $(date)"
echo

BASE_URL="http://localhost:3001"

echo "1. Testando página inicial..."
response=$(curl -s -w "%{http_code}" -o /dev/null "$BASE_URL")
if [ "$response" = "200" ]; then
    echo "✅ Página inicial funcionando (HTTP $response)"
else
    echo "❌ Página inicial com problema (HTTP $response)"
fi

echo
echo "2. Testando API de clientes..."
response=$(curl -s -w "%{http_code}" -o /dev/null "$BASE_URL/api/v1/clients")
if [ "$response" = "200" ]; then
    echo "✅ API de clientes funcionando (HTTP $response)"
    echo "📋 Primeiros clientes:"
    curl -s "$BASE_URL/api/v1/clients" | jq '.[0:2] | .[] | {id: .id, nome: .nome, cpf: .cpf}' 2>/dev/null || echo "   Dados retornados mas jq não disponível"
else
    echo "❌ API de clientes com problema (HTTP $response)"
fi

echo
echo "3. Testando API de dispositivos móveis..."
response=$(curl -s -w "%{http_code}" -o /dev/null "$BASE_URL/api/v1/mobile_devices")
if [ "$response" = "200" ]; then
    echo "✅ API de dispositivos funcionando (HTTP $response)"
else
    echo "❌ API de dispositivos com problema (HTTP $response)"
fi

echo
echo "4. Testando busca de clientes (CPF: 3628646548)..."
response=$(curl -s -w "%{http_code}" -o /dev/null "$BASE_URL/api/v1/search_clients?q_cpf_cont=3628646548")
if [ "$response" = "200" ]; then
    echo "✅ Busca de clientes funcionando (HTTP $response)"
    result=$(curl -s "$BASE_URL/api/v1/search_clients?q_cpf_cont=3628646548")
    if [ "$result" != "[]" ]; then
        echo "📋 Cliente encontrado!"
    else
        echo "⚠️  Nenhum cliente encontrado com este CPF"
    fi
else
    echo "❌ Busca de clientes com problema (HTTP $response)"
fi

echo
echo "5. Testando interface web de busca de clientes..."
response=$(curl -s -w "%{http_code}" -o /dev/null "$BASE_URL/search_clients?q_cpf_cont=3628646548")
if [ "$response" = "200" ]; then
    echo "✅ Interface web de busca funcionando (HTTP $response)"
else
    echo "❌ Interface web de busca com problema (HTTP $response)"
fi

echo
echo "6. Testando busca de dispositivos (IMEI: exemplo)..."
response=$(curl -s -w "%{http_code}" -o /dev/null "$BASE_URL/search_mobile_devices?q_imei_cont=123456")
if [ "$response" = "200" ]; then
    echo "✅ Interface web de busca de dispositivos funcionando (HTTP $response)"
else
    echo "❌ Interface web de busca de dispositivos com problema (HTTP $response)"
fi

echo
echo "=== RESUMO DOS TESTES ==="
echo "🌐 Aplicação disponível em: $BASE_URL"
echo "📱 Use o navegador para testar a interface completa"
echo "🔍 Teste os formulários de busca na página inicial"
echo "📊 APIs disponíveis:"
echo "   - GET $BASE_URL/api/v1/clients"
echo "   - GET $BASE_URL/api/v1/mobile_devices"
echo "   - GET $BASE_URL/api/v1/tickets"
echo "   - GET $BASE_URL/api/v1/search_clients?q_cpf_cont=CPF"
echo "   - GET $BASE_URL/api/v1/search_mobile_devices?q_imei_cont=IMEI"