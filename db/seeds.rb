roles = Role.create([ {name: 'candidate'}, {name: 'assessor'}, {name: 'contentcreator'} ])
user = User.create(name: "Harsh", email:"h@g.c", password: "12341234")
user.roles << Role.find_by(name: "assessor")
user.roles << Role.find_by(name: "contentcreator")