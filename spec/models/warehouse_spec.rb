require 'rails_helper'

RSpec.describe Warehouse, type: :model do

  context 'all fields are mandatory' do
    it 'name is mandatory'  do
      warehouse = Warehouse.new(name: '', code: 'MCZ', description: 'Ótimo galpão mas é frio',
      address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '87050-000',
      total_area: 5000, useful_area: 4000)

      expect(warehouse).not_to be_valid
    end

    it 'code is mandatory'  do
      warehouse = Warehouse.new(name: 'Curitiba', code: '', description: 'Ótimo galpão mas é frio',
      address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '87050-000',
      total_area: 5000, useful_area: 4000)

      expect(warehouse).not_to be_valid
    end

    it 'description is mandatory'  do
      warehouse = Warehouse.new(name: 'Curitiba', code: 'MCZ', description: '',
      address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '87050-000',
      total_area: 5000, useful_area: 4000)

      expect(warehouse).not_to be_valid
    end

    it 'address is mandatory'  do
      warehouse = Warehouse.new(name: 'Curitiba', code: 'MCZ', description: 'Ótimo galpão mas é frio',
      address: '', city: 'Curitiba', state: 'PR', zip_code: '87050-000',
      total_area: 5000, useful_area: 4000)

      expect(warehouse).not_to be_valid
    end

    it 'city is mandatory'  do
      warehouse = Warehouse.new(name: 'Curitiba', code: 'MCZ', description: 'Ótimo galpão mas é frio',
      address: 'Av Coritiba', city: '', state: 'PR', zip_code: '87050-000',
      total_area: 5000, useful_area: 4000)

      expect(warehouse).not_to be_valid
    end

    it 'state is mandatory'  do
      warehouse = Warehouse.new(name: 'Curitiba', code: 'MCZ', description: 'Ótimo galpão mas é frio',
      address: 'Av Coritiba', city: 'Curitiba', state: '', zip_code: '87050-000',
      total_area: 5000, useful_area: 4000)

      expect(warehouse).not_to be_valid
    end

    it 'zip_code is mandatory'  do
      warehouse = Warehouse.new(name: 'Curitiba', code: 'MCZ', description: 'Ótimo galpão mas é frio',
      address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '',
      total_area: 5000, useful_area: 4000)

      expect(warehouse).not_to be_valid
    end

    it 'total_area is mandatory'  do
      warehouse = Warehouse.new(name: 'Curitiba', code: 'MCZ', description: 'Ótimo galpão mas é frio',
      address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '87050-000',
      total_area: '', useful_area: 4000)

      expect(warehouse).not_to be_valid
    end

    it 'useful_area is mandatory'  do
      warehouse = Warehouse.new(name: 'Curitiba', code: 'MCZ', description: 'Ótimo galpão mas é frio',
      address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '87050-000',
      total_area: 5000, useful_area: '')

      expect(warehouse).not_to be_valid
    end
  end

  context 'some attributes must be unique' do
    it 'duplicate code' do

      Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
      address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL', zip_code: '57050-000',
      total_area: 10000, useful_area: 8000)
      warehouse = Warehouse.new(name: 'Curitiba', code: 'MCZ', description: 'Ótimo galpão mas é frio',
      address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '87050-000',
      total_area: 5000, useful_area: 4000)

      expect(warehouse).not_to be_valid
    end

    it 'duplicate name' do

      Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
      address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL', zip_code: '57050-000',
      total_area: 10000, useful_area: 8000)
      warehouse = Warehouse.new(name: 'Maceió', code: 'CTB', description: 'Ótimo galpão mas é frio',
      address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '87050-000',
      total_area: 5000, useful_area: 4000)

      expect(warehouse).not_to be_valid
    end
  end

  context 'valid zip_code format' do
    it 'zip_code equal to 7514-025' do

      warehouse = Warehouse.new(name: 'Curitiba', code: 'MCZ', description: 'Ótimo galpão mas é frio',
      address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '7514-025',
      total_area: 5000, useful_area: 4000)

      expect(warehouse).not_to be_valid
    end

    it 'zip_code equal to 75143-02533' do

      warehouse = Warehouse.new(name: 'Curitiba', code: 'MCZ', description: 'Ótimo galpão mas é frio',
      address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '75143-02533',
      total_area: 5000, useful_area: 4000)

      expect(warehouse).not_to be_valid
    end

    it 'zip_code equal to 1234a-025' do

      warehouse = Warehouse.new(name: 'Curitiba', code: 'MCZ', description: 'Ótimo galpão mas é frio',
      address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '1234a-025',
      total_area: 5000, useful_area: 4000)

      expect(warehouse).not_to be_valid
    end

    it 'zip_code equal to 12342025' do

      warehouse = Warehouse.new(name: 'Curitiba', code: 'MCZ', description: 'Ótimo galpão mas é frio',
      address: 'Av Coritiba', city: 'Curitiba', state: 'PR', zip_code: '12342025',
      total_area: 5000, useful_area: 4000)

      expect(warehouse).not_to be_valid
    end
  end
end
