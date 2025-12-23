🚀 Konnector.ai – School Management Platform

Konnector.ai is a role-based school management system built with Ruby on Rails.
It supports Admin, School Admin, and Student roles, includes a web dashboard and a RESTful API, and demonstrates real-world authorization, enrollment workflows, and pagination.

🧱 Tech Stack

Ruby 3.2.x

Rails 8.x

PostgreSQL

Devise – Authentication

Pundit – Authorization

Kaminari – Pagination

Tailwind CSS – UI

RSpec – Test Suite

ActiveModelSerializers – API serialization

👥 User Roles & Permissions
🔑 Admin

Login via Devise

Create & manage Schools

View all schools via UI and API

Full system visibility

🏫 School Admin

Login via Devise

Manages only their own school

Create & manage:

Courses

Batches

View enrollment requests

Approve / Reject student enrollments

Add students directly to batches

Access via UI and API

🎓 Student

Login via Devise

View available batches

Request enrollment into a batch

View:

Enrollment status (Pending / Approved / Rejected)

Classmates in same batch

Progress of classmates (if enrolled)

🔐 Authentication & Authorization

Devise handles user authentication

Roles are managed via enum in User model

Pundit policies enforce:

Role-based access

Ownership-based restrictions (school_admin → own school only)

API uses token-based authentication

🖥️ Web Features (UI)
Admin Panel

Schools listing

Create / Edit schools

Dashboard overview

School Admin Panel

Courses CRUD

Batches CRUD (nested under courses)

Enrollment requests page

Approve / Reject enrollment

Add student to batch

Student Panel

Dashboard

View enrollment status

Request enrollment

View classmates & progress

🔌 API Features (v1)
Authentication
POST /api/v1/login

Schools
GET  /api/v1/schools
POST /api/v1/schools

Courses
GET  /api/v1/courses
POST /api/v1/courses

Batches
GET  /api/v1/batches
POST /api/v1/batches
GET  /api/v1/batches/:id/classmates

Enrollments
POST  /api/v1/enrollments        # Student requests enrollment
PATCH /api/v1/enrollments/:id/approve
PATCH /api/v1/enrollments/:id/reject


✔ All list endpoints support pagination

📦 Database Schema (Core Models)

User

role: admin | school_admin | student

School

belongs_to :school_admin

Course

belongs_to :school

Batch

belongs_to :course

Enrollment

belongs_to :user

belongs_to :batch

status: pending | approved | rejected

Progress

tracks student completion per batch

⚙️ Setup Instructions
1️⃣ Clone Repository
git clone https://github.com/ArtikaBusa/konnector_ai.git
cd konnector_ai

2️⃣ Install Dependencies
bundle install

3️⃣ Database Setup
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed

4️⃣ Start Server
bin/dev


Visit:

http://localhost:3000

🔑 Seeded Users (Development)
Role	        Email	                    Password

Admin	        admin@test.com            password

School Admin	school@test.com           password

Student	      student1@test.com          password

🧪 Running Tests

bundle exec rspec


✔ Includes request specs for:

Authentication

Authorization

Pagination

Enrollment workflow

🧠 Key Design Highlights

Clean separation of Web vs API

Token-based API authentication

Strict authorization via Pundit

Nested resources where appropriate

Scalable role-based architecture

Real-world enrollment approval flow

🚧 Future Enhancements

Progress tracking UI

Notifications for enrollment status

Admin analytics dashboard

API versioning expansion

Background jobs (email notifications)

🏁 Conclusion

This project demonstrates:

Real-world Rails architecture

Secure role-based access

API + UI in the same application

Clean authorization patterns

Production-ready structure
