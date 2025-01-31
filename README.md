API de Assistência Técnica

Esta é a API do sistema de assistência técnica desenvolvida em Ruby on Rails. A API permite o gerenciamento de clientes, dispositivos, tickets de reparo e geração de PDFs de orçamento.

Tecnologias Utilizadas

Backend (Ruby on Rails)

Ruby on Rails: Framework principal

PostgreSQL: Banco de dados

Devise API: Autenticação de usuários

RSpec: Testes automatizados

Docker: Contêinerização

Active Storage: Gerenciamento de arquivos anexados

i18n: Internacionalização das mensagens

Prawn: Geração de PDFs para orçamentos

Funcionalidades da API

A API fornece endpoints para:

Autenticação: Login e gerenciamento de usuários com devise_api

Clientes: Cadastro, busca e prevenção de duplicidade por CPF

Dispositivos: Relacionamento de aparelhos com clientes

Tickets: Criação, atualização e fechamento com registro de data de fechamento

Anexos: Upload de arquivos em tickets

PDFs: Geração dinâmica de orçamentos

Docker instruction

docker-compose build
docker-compose up
docker-compose run web rails db:create

A API foi desenvolvida com foco em performance, segurança e facilidade de uso, garantindo um fluxo eficiente no gerenciamento de assistência técnica.
