u1 = User.create!(email: 'fooobar@bar.com', full_name: 'Benne Blanco')
u2 = User.create!(email: 'spammy@bar.com', full_name: 'Marketing Mary')

t1 = Task.create!(name: 'surfing')
t2 = Task.create!(name: 'swimming')
t3 = Task.create!(name: 'hiking')

# User 1 has 3 tasks
UserTask.create!({user_id: u1.id, task_id: t1.id})
UserTask.create!(user_id: u1.id, task_id: t2.id)
UserTask.create!(user_id: u1.id, task_id: t2.id)

# User 2 has 1 task
UserTask.create!(user_id: u2.id, task_id: t1.id)

# Task 1 has 2 users
