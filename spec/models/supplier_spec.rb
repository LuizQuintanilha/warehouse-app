require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid' do
    context 'presence' do
      it 'falso quando razão social não é preenchido' do
        supplier = Supplier.new(corporate_name: '', brand_name: 'ACME', registration_number: '2000230501',
                                full_address: 'Avenida dos Coqueiros, 1000', zip: '23550-000',
                                city: 'Rio de Janeiro', state: 'RJ', email: 'acheacme@email.com')

        result = supplier.valid?
        expect(result).to eq(false)
      end
      it 'falso quando marca não é preenchido' do
        supplier = Supplier.new(corporate_name: 'ACHE LDTA', brand_name: '', registration_number: '2000230501',
                                full_address: 'Avenida dos Coqueiros, 1000', zip: '23550-000',
                                city: 'Rio de Janeiro', state: 'RJ', email: 'acheacme@email.com')

        result = supplier.valid?
        expect(result).to eq(false)
      end
      it 'falso quando Número de registro não é preenchido' do
        supplier = Supplier.new(corporate_name: 'ACHE LDTA', brand_name: 'ACME', registration_number: '',
                                full_address: 'Avenida dos Coqueiros, 1000', zip: '23550-000',
                                city: 'Rio de Janeiro', state: 'RJ', email: 'acheacme@email.com')

        result = supplier.valid?
        expect(result).to eq(false)
      end
      it 'falso quando endereço não é preenchido' do
        supplier = Supplier.new(corporate_name: 'ACHE LDTA', brand_name: 'ACME', registration_number: '2000230501',
                                full_address: '', zip: '23550-000',
                                city: 'Rio de Janeiro', state: 'RJ', email: 'acheacme@email.com')

        result = supplier.valid?
        expect(result).to eq(false)
      end
      it 'falso quando cep não é preenchido' do
        supplier = Supplier.new(corporate_name: 'ACHE LDTA', brand_name: 'ACME', registration_number: '2000230501',
                                full_address: 'Avenida dos Coqueiros, 1000', zip: '',
                                city: 'Rio de Janeiro', state: 'RJ', email: 'acheacme@email.com')

        result = supplier.valid?
        expect(result).to eq(false)
      end
      it 'falso quando cidade não é preenchido' do
        supplier = Supplier.new(corporate_name: 'ACHE LDTA', brand_name: 'ACME', registration_number: '2000230501',
                                full_address: 'Avenida dos Coqueiros, 1000', zip: '23550-000',
                                city: '', state: 'RJ', email: 'acheacme@email.com')

        result = supplier.valid?
        expect(result).to eq(false)
      end
      it 'falso quando estado não é preenchido' do
        supplier = Supplier.new(corporate_name: 'ACHE LDTA', brand_name: 'ACME', registration_number: '2000230501',
                                full_address: 'Avenida dos Coqueiros, 1000', zip: '23550-000',
                                city: 'Rio de Janeiro', state: '', email: 'acheacme@email.com')

        result = supplier.valid?
        expect(result).to eq(false)
      end
      it 'falso quando email não é preenchido' do
        supplier = Supplier.new(corporate_name: 'ACHE LDTA', brand_name: 'ACME', registration_number: '2000230501',
                                full_address: 'Avenida dos Coqueiros, 1000', zip: '23550-000',
                                city: 'Rio de Janeiro', state: 'RJ', email: '')

        result = supplier.valid?
        expect(result).to eq(false)
      end
    end
    context 'uniqueness' do
      it 'falso quando número de registro existe' do
        # arrange
        supplier = Supplier.create!(corporate_name: 'ACHE LTDA', brand_name: 'ACME', registration_number: '2000230501',
                                    full_address: 'Avenida dos Coqueiros, 1000', zip: '23550-000',
                                    city: 'Rio de Janeiro', state: 'RJ', email: 'acheacme@email.com')

        second_supplier = Supplier.new(corporate_name: 'BOLT LTDA', brand_name: 'ThunderBolt', registration_number: '2000230501',
                                       full_address: 'Rua da Olimpíada, 2016', zip: '12000-000',
                                       city: 'Fortaleza', state: 'CE', email: 'boltthunder@email.com')
        # act
        result = second_supplier.valid?
        # assert
        expect(result).to eq(false)
      end
      it 'falso quando razão social já existe' do
        # arrange
        supplier = Supplier.create!(corporate_name: 'ACHE LTDA', brand_name: 'ACME', registration_number: '2000230501',
                                    full_address: 'Avenida dos Coqueiros, 1000', zip: '23550-000',
                                    city: 'Rio de Janeiro', state: 'RJ', email: 'acheacme@email.com')

        second_supplier = Supplier.new(corporate_name: 'ACHE LTDA', brand_name: 'ThunderBolt', registration_number: '2000230502',
                                       full_address: 'Rua da Olimpíada, 2016', zip: '12000-000',
                                       city: 'Fortaleza', state: 'CE', email: 'boltthunder@email.com')

        result = second_supplier.valid?
        # assert
        expect(result).to eq(false)
      end
    end
  end
end
