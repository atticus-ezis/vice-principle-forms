# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Student.create([
  { student_name: "Johnny Pickles", parent_name: "Jane Pickles", grade: "5", teachers: "Mrs. Smith", sports: "Basketball", form_name: "Contact, Sports-Physical" },
  { student_name: "George Washington", parent_name: "Abe Washington", grade: "8", teachers: "Mr. Link", sports: "Cross Country", form_name: "Contact" },
  { student_name: "Alice Johnson", parent_name: "Robert Johnson", grade: "6", teachers: "Mr. Davis", form_name: "Contact" }
])