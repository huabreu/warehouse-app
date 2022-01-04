require 'rails_helper'

RSpec.describe ProductCategory, type: :model do
  it 'Name is mandatory' do
    category = ProductCategory.new(name: '')

    expect(category).not_to be_valid
  end

  it 'Name must be unique' do
    category1 = ProductCategory.create!(name: 'Especial')
    category2 = ProductCategory.new(name: 'Especial')

    expect(category2).not_to be_valid
  end
end
