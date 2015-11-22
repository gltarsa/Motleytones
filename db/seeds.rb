# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
User.create({"name"=>"Greg Tarsa",
             "email"=>"gltarsa@gmail.com",
             "admin"=>true,
             "password"=>PASSWORD,
             "password_confirmation"=>PASSWORD,
             "tone_name"=>"Flintz Tone",
             "band_start_date"=>"Fri, 09 Jul 2010"})
User.create({"name"=>"Non-Admin",
             "email"=>"nonadmin@motley.com",
             "admin"=>false,
             "password"=>PASSWORD,
             "password_confirmation"=>PASSWORD,
             "tone_name"=>"Not An Admin Tone",
             "band_start_date"=>"Fri, 19 Jul 2010"})


Gig.create( { published: true, date: "9 Jan 2015", name: "Corporate Luncheon - 10am-2pm", location: "Durham NC" })
Gig.create( { published: true, date: "10 Jan 2015", "name" => "Private Birthday Party- email @info to book your own!", published: true })
Gig.create( { published: true, date: "28 Feb 2015", name: "[Arrlene the Pirate Mermaid Colonial Seaport Fundraiser for the Luna](https://www.facebook.com/events/1578589885710131/)", note: "Williamsburg Regional Library", location: "Williamsburg VA" })
Gig.create( { published: true, date: "10 Apr 2015", name: "(2 days)[Greenville Piratefest](http://www.piratefestnc.info", location: "Greenville NC" })
Gig.create( { published: true, date: "26 Apr 2015", name: "[Washington Harbor District Art Walk](http://www.littlewashingtonnc.com/organizer/washington-harbor-district-alliance)", location: "Washington, NC" })
