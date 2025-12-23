admin = User.find_or_create_by!(email: "admin@test.com") do |u|
  u.name = "Super Admin"
  u.password = "password"
  u.role = :admin
  u.confirmed_at = Time.current
end

school_admin = User.find_or_create_by!(email: "school@test.com") do |u|
  u.name = "School Admin"
  u.password = "password"
  u.role = :school_admin
  u.confirmed_at = Time.current
end

school = School.find_or_create_by!(name: "Konnector School") do |s|
  s.address = "Mumbai"
  s.school_admin = school_admin
end

User.create!(
  name: "Student One",
  email: "student1@test.com",
  password: "password",
  role: :student
)

User.create!(
  name: "Student Two",
  email: "student2@test.com",
  password: "password",
  role: :student
)
