require 'rails_helper'

describe 'warehouse API' do

  context 'GET /api/v1/warehouses/1' do
    it 'com sucesso' do

      warehouse = Warehouse.create!(
        name: 'Aeroporto SP',
        code: 'GRU',
        city: 'Guarulhos',
        area: 100_000,
        address: 'Avenida do Aeroporto, 1000',
        cep: '17352-000',
        description: 'Galpão destinado a cargas internacionais'
      )

      get "/api/v1/warehouses/#{warehouse.id}"
      json_response = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(json_response["name"]).to eq('Aeroporto SP')
      expect(json_response["code"]).to eq('GRU')
      expect(json_response.keys).not_to include("created_at")
      expect(json_response.keys).not_to include("updated_at")
    end

    it 'falha se warehouse não foi encontrada' do

      get "/api/v1/warehouses/999999"

      expect(response.status).to eq 404

    end
  end

  context 'GET /api/v1/warehouses' do
    it 'com sucesso e em ordem alfabética' do
      Warehouse.create(
        name: 'Rio',
        code: 'SDU',
        city: 'Rio de Janeiro',
        area: 60_000,
        address: 'Av. Santos Dummont, 1000',
        cep: '23500-000',
        description: 'Galpão do Aeroporto do Rio'
      )
      Warehouse.create(
        name: 'Maceio',
        code: 'MCZ',
        city: 'Maceio',
        area: 50_000,
        address: 'Av. Alagoas, 1000',
        cep: '22350-000',
         description: 'Galpão do do Estado de Maceio'
        )

        get '/api/v1/warehouses' 

        expect(response.status).to eq 200
        expect(response.content_type).to include 'application/json'
        json_response = JSON.parse(response.body)
        expect(json_response.length).to eq 2
        expect(json_response[1]["name"]).to eq 'Rio'
        expect(json_response[0]["name"]).to eq 'Maceio'
    end

    it 'retorna vazio se não houver warehouse' do
      get '/api/v1/warehouses' 

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
  end

  context 'POST /api/v1/warehouse' do
    it 'com sucesso' do
      warehouse_params = { warehouse: {
        name: 'Maceio',
        code: 'MCZ',
        city: 'Maceio',
        area: 50_000,
        address: 'Av. Alagoas, 1000',
        cep: '22350-000',
        description: 'Galpão do do Estado de Maceio'
      }}
      post '/api/v1/warehouses', params: warehouse_params

      expect(response).to have_http_status(201)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq 'Maceio'
      expect(json_response["code"]).to eq 'MCZ'
      expect(json_response["address"]).to eq 'Av. Alagoas, 1000'
      expect(json_response["city"]).to eq 'Maceio'
      expect(json_response["cep"]).to eq '22350-000'
      expect(json_response["description"]).to eq 'Galpão do do Estado de Maceio'
      expect(json_response["area"]).to eq(50_000)
    end

    it 'sem sucesso se parametros estão incompletos' do
      warehouse_params = { warehouse: {
        name: 'Galpão ES',
        code: 'MCZ',
        city: '',
        area: '',
        address: '',
        cep: '',
        description: ''
      }}

      post '/api/v1/warehouses', params: warehouse_params

      expect(response.status).to eq 412
      expect(response.body).to include 'Endereço não pode ficar em branco'
      expect(response.body).to include 'Cidade não pode ficar em branco'
    end

    it 'falha se houver erros internos' do
      allow(Warehouse).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)
      warehouse_params = { warehouse: {
        name: 'Maceio',
        code: 'MCZ',
        city: 'Maceio',
        area: 50_000,
        address: 'Av. Alagoas, 1000',
        cep: '22350-000',
        description: 'Galpão do do Estado de Maceio'
      }}

      post '/api/v1/warehouses', params: warehouse_params

      expect(response.status).to eq 500
    end
  end
end
