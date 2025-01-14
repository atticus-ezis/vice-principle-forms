# README

Goal:
  This project allows users to update student records with required forms 
  which changes their status from "INCOMPLETE" to "COMPLETE"

  ** Note if a sport is listed two files must be uploaded - 'Contact' and 'Sport-Physical' 
  The titles of these files must match exactly -- (files can be any format or name) ***

Includes:
  rails 
  postgresql database (hosted on AWS) 

Steps:
  Database Configuration:
    1) created rails project and specified PostgreSQL
    rails new StudentRecordsTest –database=postgresql
    2) created a hidden url key to connect my Neon database 
    added .env file with database url info 
    3) added “ gem ‘dotenv-rails’  ” to Gemfile - ran ‘bundle install’
    4) configured database.yml with 
          default: &default
           adapter: postgresql
           encoding: unicode
           pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
           url: <%= ENV['DATABASE_URL'] %> 

  5) verified my Neon database connection
        created “test_table” in Neon with mock data
        successfully accessed the records from a test_table in the rails console 
        ActiveRecord::Base.connection.execute(“SELECT * FROM test_table”).to_a

   6) considered building the dataset in Neon vs Rails, chose Rails.
   7) created a Student model in rails with column name and type
        command line - rails generate model Student student_name:string parent_name:string grade:string teachers:string sports:string form_name:string             status:boolean 
        added set default of ‘status’ to false in migration
        ran db migration to create database
        populated sample data inside seeds.rb file to perform analysis
        successfully viewed records in console to verify seeded data

  8) clean data and added logic in Student model
       in student.rb file…
          require essential details, names etc
          require “Contact” form always and “Sports-Physical” when sport is listed
          when the correct forms are present and multiple files have been submitted status is true, else false
  9) display data 
     create CRUD functionality with scaffold command on existing model by adding ‘skip’ commands
     rails generate scaffold Student --skip-model --skip-migration --skip-collision-check
     created data table in html to display the data for each student with <% @students.each do |student| %> <%= student.student_name %> etc… 

  10) submit form 
        populated a _form.html partial with editable fields and a file submit option
        allow multiple files to be submitted
            controller → form_files: [] 
             _form.html → form_file, multiple
            student model →has_many_attached :form_files
        allow files to be uploaded and stored with 
              bin/rails active_storage:install
              bin/rails db:migrate


