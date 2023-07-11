require_relative 'contact'

class ContactsList
  attr_reader :contacts

  def initialize
    @contacts = [
      Contact.new('João', '1234-5678'),
      Contact.new('Maria', '1234-5678'),
      Contact.new('José', '1234-5678')
    ]
  end

  def list
    @contacts
  end

  def add(_name, phone)
    raise 'Telefone já cadastrado!' if getByPhone(phone)

    @contacts << Contact.new(_name, phone)
  end

  def getByIndex(index)
    @contacts[index]
  end

  private def getByPhone(phone)
    @contacts.find { |contact| contact.phone == phone }
  end

  def update(index, name, phone)
    @contacts[index].name = name
    @contacts[index].phone = phone
  end

  def delete(index)
    @contacts.delete_at(index)
  end
end
