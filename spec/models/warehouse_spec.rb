require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do 
    context 'presence' do 
      it 'false when name is empty' do
        #arrange
        warehouse = Warehouse.new(name:'', code: 'RIO', address: 'Endereço', city: 'Rio de Janeiro', 
                                  area: 40000, cep: '25000-000', description: 'descrição')
        #act
        result = warehouse.valid?
        #assert
        expect(result).to eq false
      end
      it 'false when code is empty' do
        #arrange
        warehouse = Warehouse.new(name:'Rio', code: '', address: 'Endereço', city: 'Rio de Janeiro', 
                                  area: 40000, cep: '25000-000', description: 'descrição')
       
        expect(warehouse).not_to be_valid
      end
      it 'false when address is empty' do
        #arrange
        warehouse = Warehouse.new(name:'Rio', code: 'RIO', address: '', city: 'Rio de Janeiro', 
                                  area: 40000, cep: '25000-000', description: 'descrição')
        #assert
        expect(warehouse.valid?).to eq false
      end
      it 'false when city is empty' do
        #arrange
        warehouse = Warehouse.new(name:'Rio', code: 'RIO', address: 'Endereço', city: '', 
                                  area: 40000, cep: '25000-000', description: 'descrição')
        #assert
        expect(warehouse.valid?).to eq false
      end
      it 'false when area is empty' do
        #arrange
        warehouse = Warehouse.new(name:'Rio', code: 'RIO', address: 'Endereço', city: 'Rio de Janeiro', 
                                  area: '', cep: '25000-000', description: 'descrição')
        #assert
        expect(warehouse.valid?).to eq false
      end
      it 'false when cep is empty' do
        #arrange
        warehouse = Warehouse.new(name:'Rio', code: 'RIO', address: 'Endereço', city: 'Rio de Janeiro', 
                                  area: 40000, cep: '', description: 'descrição')
        #assert
        expect(warehouse.valid?).to eq false
      end
      it 'false when cep is empty' do
        #arrange
        warehouse = Warehouse.new(name:'Rio', code: 'RIO', address: 'Endereço', city: 'Rio de Janeiro', 
                                  area: 40000, cep: '25000-000', description: '')
        #assert
        expect(warehouse.valid?).to eq false
      end
    end

      
    it 'false when code  is already in use' do
      #arrange
      first_warehouse = Warehouse.create(name:'Rio', code:'RIO', address: 'Av. das Américas, 1000', city: 'Rio de Janeiro', 
        area: 40000, cep: '25000-000', description: 'Galpão do Rio')

      second_warehouse = Warehouse.new(name:'Niteroi', code: 'RIO', address: 'Av. Niteroi, 100', city: 'Niteroi', 
                                area: 35000, cep: '25000-100', description: 'descrição')
      #act
      result = second_warehouse.valid?
      #assert
      expect(result).to eq false
    end
  end
end
