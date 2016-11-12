Role::NAMES.each { |name| Role.where(name: name).first_or_create }
User.where(role_id: Role.where(name: 'admin').first.id, email: 'admin@mail.com', name: 'Admin').first_or_create(password: 'password')

(1..3).each do |n|
  role = Role.where(name: 'operator').first
  name = "user #{n}"
  email = "user#{n}@mail.com"
  User.where(name: name, role_id: role.id, email: email).first_or_create(password: "password#{n}")
end

machine = Machine.where(name: 'machine1').first_or_create
['black',
  'red',
  'green',
  'blue'
].each {|color| Color.where(name: color).first_or_create }
(1..10).each do |n|
  part_number = PartNumber.where(name:"FoxCun#{n}", number: n, color_id: Color.order("RAND()").first.id).first_or_create
  MachinePartNumber.where(machine_id: machine.id, part_number_id: part_number.id).first_or_create
end

