require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#description' do
    it 'exibe o nome e o email' do
      u = User.new(name: 'Luana Guarnier', email: 'luana@email.com')

      result = u.description

      expect(result).to eq 'Luana Guarnier - luana@email.com'
    end
  end
end
