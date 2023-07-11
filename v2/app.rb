require_relative 'contacts-list'

class App
  MENU_OPTIONS = [
    'Listar contatos',
    'Adicionar contato',
    'Buscar contato',
    'Editar contato',
    'Remover contato',
    'Sair'
  ]

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

  def list_contacts
    @agenda.list.each_with_index do |contact, index|
      puts "#{index + 1} - #{contact.name} - #{contact.phone}"
    end
  end

  def list_indexed_contacts
    @agenda.list.each_with_index do |contact, index|
      puts "#{index} - #{contact.name}"
    end
  end

  def add_contact
    puts 'Digite o nome do contato:'
    name = gets.chomp
    puts 'Digite o telefone do contato:'
    phone = gets.chomp

    @agenda.add(name, phone)

    system 'clear'
    puts 'Contato adicionado com sucesso!'
    puts ''
  end

  def find_contact
    puts 'Digite o índice do contato que deseja buscar:'
    list_indexed_contacts
    index = gets.chomp.to_i

    if index > @agenda.list.length - 1 || index < 0

      system 'clear'
      puts 'Índice inválido. Escolha uma opção abaixo:'
      list_indexed_contacts
      return find_contact
    end

    contact = @agenda.getByIndex(index)

    system 'clear'
    puts "Nome: #{contact.name}"
    puts "Telefone: #{contact.phone}"
    puts ''
  end

  def edit_contact
    puts 'Digite o índice do contato que deseja editar:'
    list_indexed_contacts
    index = gets.chomp.to_i

    if index > @agenda.list.length - 1 || index < 0
      system 'clear'
      puts 'Índice inválido. Escolha uma opção abaixo:'
      list_indexed_contacts
      return edit_contact
    end

    contact = @agenda.getByIndex(index)

    puts 'Digite o novo nome do contato (ou aperte ENTER para manter o mesmo):'
    name = gets.chomp
    puts 'Digite o novo telefone do contato (ou aperte ENTER para manter o mesmo):'
    phone = gets.chomp

    @agenda.update(index, name == '' ? contact.name : name, phone == '' ? contact.phone : phone)

    system 'clear'
    puts 'Contato atualizado com sucesso!'
    puts ''
  end

  def remove_contact
    puts 'Digite o índice do contato que deseja remover:'
    list_indexed_contacts
    index = gets.chomp.to_i

    if index > @agenda.list.length - 1 || index < 0
      system 'clear'
      puts 'Índice inválido. Escolha uma opção abaixo:'
      list_indexed_contacts
      return remove_contact
    end

    @agenda.delete(index)

    system 'clear'
    puts 'Contato removido com sucesso!'
    puts ''
  end

  def handle_option(option)
    system 'clear'

    case option
    when 0
      exit_app
    when 1
      list_contacts
    when 2
      add_contact
    when 3
      find_contact
    when 4
      edit_contact
    when 5
      remove_contact
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

app = App.new
app.start
