Role::NAMES.each { |name| Role.where(name: name).first_or_create }
User.create(role_id: Role.where(name: 'admin').first.id, email: admin@mail.com, password: 'password')