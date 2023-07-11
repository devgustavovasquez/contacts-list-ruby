class ContactsList
  def initialize
    @contacts = [
      { name: 'João', phone: '123456789' },
      { name: 'Maria', phone: '987654321' }
    ]
  end

  def list_contacts
    @contacts.each_with_index do |contact, index|
      puts "#{index + 1} - #{contact[:name]} - #{contact[:phone]}"
    end
    puts "\n"
  end

  def list_view
    @contacts.each_with_index do |contact, index|
      puts "#{index + 1}: #{contact[:name]}"
    end
  end

  def add_contact
    puts 'Nome do contato:'
    name = gets.chomp
    puts 'Telefone do contato:'
    phone = gets.chomp

    system 'clear'
    puts "Contato adicionado com sucesso! \n\n"

    @contacts << { name:, phone: }
  end

  def validate_contact_index(contact_index)
    if contact_index > @contacts.length || contact_index <= 0
      system 'clear'
      puts 'Opção inválida. Escolha um contato abaixo:'
      return false
    end
    true
  end

  def get_contact
    puts 'Contatos:'
    list_view
    puts 'Qual contato você deseja ver?'
    contact_index = gets.chomp.to_i

    return get_contact unless validate_contact_index(contact_index)

    system 'clear'
    contact = @contacts[contact_index - 1]
    puts "#{contact[:name]} - #{contact[:phone]}"
    puts "\n"
  end

  def edit_contact
    puts 'Contatos:'
    list_view
    puts 'Qual contato você deseja editar?'
    contact_index = gets.chomp.to_i

    return edit_contact unless validate_contact_index(contact_index)

    puts 'Novo nome do contato:'
    name = gets.chomp
    puts 'Novo telefone do contato:'
    phone = gets.chomp

    @contacts[contact_index - 1] = { name:, phone: }

    system 'clear'
    puts "Contato editado com sucesso! \n\n"
  end

  def remove_contact
    puts 'Contatos:'
    list_view
    puts 'Qual contato você deseja remover?'
    contact_index = gets.chomp.to_i

    return remove_contact unless validate_contact_index(contact_index)

    @contacts.delete_at(contact_index - 1)

    system 'clear'
    puts "Contato removido com sucesso! \n\n"
  end
end

class Menu
  MENU_OPTIONS = ['Listar Contatos', 'Adicionar Contato', 'Ver Contato', 'Editar Contato', 'Remover Contato',
                  'Sair'].freeze

  def initialize
    @agenda = ContactsList.new
  end

  def show_menu
    puts 'MENU AGENDA'
    puts '------------------'
    MENU_OPTIONS.each_with_index do |option, index|
      return puts "0 - #{option}" if index == MENU_OPTIONS.length - 1

      puts "#{index + 1} - #{option}"
    end
  end

  def get_option
    option = gets.chomp

    if !option.match?(/\d/) || option.to_i > MENU_OPTIONS.length || option.to_i < 0
      system 'clear'
      puts 'Opção inválida. Escolha uma opção abaixo:'
      show_menu
      return get_option
    end

    option.to_i
  end

  def handle_option(option)
    system 'clear'

    case option
    when 0
      exit_app
    when 1
      @agenda.list_contacts
    when 2
      @agenda.add_contact
    when 3
      @agenda.get_contact
    when 4
      @agenda.edit_contact
    when 5
      @agenda.remove_contact
    end

    show_menu
    handle_option(get_option)
  end

  def exit_app
    puts 'Saindo...'
    exit
  end

  def start
    system 'clear'
    show_menu
    option = get_option
    handle_option(option)
  end
end

menu = Menu.new
menu.start
