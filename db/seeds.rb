# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
User.create({"name"=>"Greg Tarsa",
             "email"=>"gltarsa@gmail.com",
             "admin"=>true,
             "password"=>PASSWORD,
             "password_confirmation"=>PASSWORD,
             "tone_name"=>"Flintz Tone",
             "band_start_date"=>"Fri, 09 Jul 2010"})
