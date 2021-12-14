require 'rails_helper'

RSpec.describe Warehouse, type: :model do

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
end
