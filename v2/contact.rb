class Contact
  attr_reader :name, :phone

  def initialize(name, phone)
    @name = name
    @phone = phone
  end

  def name=(new_name)
    raise 'Nome inválido! O nome deve ter no mínimo 2 caracteres' unless new_name.length >= 2
    raise 'Nome inválido! O nome deve ter no máximo 50 caracteres' unless new_name.length <= 50

    @name = new_name
  end

  def phone=(new_phone)
    raise 'Telefone inválido! O telefone deve ter no máximo 14 caracteres' unless new_phone.length <= 9
    raise 'Telefone inválido! O telefone deve ter no mínimo 8 caracteres' unless new_phone.length >= 8
    raise 'Telefone inválido! O telefone deve conter apenas números' unless new_phone.match?(/\A\d+\z/)

    @phone = new_phone
  end
end
