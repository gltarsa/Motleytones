# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
User.create({
  name: "Greg Tarsa",
  email: "flintz@motleytones.com",
  admin: true,
  password: STARTER_PASSWORD,
  password_confirmation: STARTER_PASSWORD,
  tone_name: "Flintz Tone",
  band_start_date: "Fri, 09 Jul 2010" })
User.create({
  name: "Kat Tarsa",
  email: "ring@motleytones.com",
  admin: true,
  password: STARTER_PASSWORD,
  password_confirmation: STARTER_PASSWORD,
  tone_name: "Flintz Tone",
  band_start_date: "01 Apr 2011"})
User.create({
  name: "Non-Admin",
  email: "gltarsa@gmail.com",
  admin: false,
  password: STARTER_PASSWORD,
  password_confirmation: STARTER_PASSWORD,
  tone_name: "Not An Admin Tone",
  band_start_date: "Fri, 19 Jul 2010"})


# complete 2015 schedule as of 11/23/2015
Gig.create({
  published: true,
  date: "10 Jan 2015",
  name:"Private Birthday Party- email @info to book your own!" })
Gig.create({
  published: true,
  date: "9 Jan 2015",
  name: "Corporate Luncheon - 10am-2pm",
  location: "Durham, NC" })
Gig.create({
  published: true,
  date: "28 Feb 2015",
  name: "[Arrlene the Pirate Mermaid Colonial Seaport Fundraiser for the Luna](https://www.facebook.com/events/1578589885710131/)",
  note: "Williamsburg Regional Library",
  location: "Williamsburg, VA" })
Gig.create({
  published: true,
  date: "10 Apr 2015",
  days: 2,
  name: "[Greenville Piratefest](http://www.piratefestnc.info)",
  location: "Greenville, NC" })
Gig.create({
  published: true,
  date: "26 Apr 2015",
  name: "[Washington Harbor District Art Walk](http://www.littlewashingtonnc.com/organizer/washington-harbor-district-alliance)",
  location: "Washington,, NC" })
Gig.create({
  published: true,
  date: "1 May 2015",
  name: "[Volunteers of America](http://www.voa.org) Fundraiser)",
  location: "Virginia Beach, VA" })
Gig.create({
  published: true,
  date: "2 May 2015",
  name: "[Onslow Beach State Park Piratefest](http://www.onslowcountync.gov/WorkArea/linkit.aspx?LinkIdentifier=id&ItemID=28167&libID=28108)",
  location: "Swansboro, NC" })
Gig.create({
  published: true,
  date: "15 May 2015",
  name: "[Belhaven Buccaneer Festival](http://www.piratesonpungo.org)",
  location: "Belhaven, NC" })
Gig.create({
  published: true,
  date: "17 May 2015",
  days: 2,
  name: "[NCMA Family Renaissance Faire](http://ncartmuseum.org/calendar/event/2014/06/01/family_renaissance_fair/1300)",
  location: "Raleigh, NC" })
Gig.create({
  published: true,
  date: "29 May 2015",
  days: 2,
  name: "[Blackbeard Pirate Jamboree](http://www.hampton.gov/blackbeard)",
  location: "Hampton, VA" })
Gig.create({
  published: true,
  date: "20 Jun 2015",
  name: "[Cary Farmer's Market](http://www.caryfarmersmarket.com)",
  location: "NC" })
Gig.create({
  published: true,
  date: "25 Jul 2015",
  name: "Ice Cream Social: [Cary Farmer's Market](http://www.caryfarmersmarket.com)",
  location: "NC" })
Gig.create({
  published: true,
  date: "31 Jul 2015",
  days: 2,
  name: "[Old Baldy Fundraiser](http://www.baldheadisland.com/events)",
  location: "Bald Head Island, NC" })
Gig.create({
  published: true,
  date: "5 Aug 2015",
  name: "[Chesterbrook Academy](http://www.chesterbrookacademy.com/elementary/raleigh-durham/north-raleigh)",
  location: "Raleigh, NC" })
Gig.create({
  published: true,
  date: "7 Aug 2015",
  days: 2,
  name: "[Beaufort Pirate Invasion](http://www.beaufortpirateinvasion.com)",
  location: "Beaufort, NC" })
Gig.create({
  published: true,
  date: "21 Aug 2015",
  name: "Private corporate event" })
Gig.create({
  published: true,
  date: "22 Aug 2015",
  name: "[Cary Lazy Daze Festival](http://www.townofcary.org/departments/parks__recreation___cultural_resources/events/festivals/lazy_daze_arts_and_crafts_festival.htm)",
  location: "Cary, NC" })
Gig.create({
  published: true,
  date: "19 Sep 2015",
  name: "[Day in the Park](http://highpointarts.org/arts/community-outreach-programs/day-in-the-park)",
  location: "High Point NC (International Talk Like A Pirate Day!)" })
Gig.create({
  published: true,
  date: "17 Oct 2015",
  name: "Private Wedding" })
Gig.create({
  published: true,
  date: "30 Oct 2015",
  days: 2,
  name: "[Blackbeard Pirate Jamboree](http://piratejamboree.com)",
  location: "Ocracoke Island, NC" })
Gig.create({
  published: true,
  date: "14 Nov 2015",
  name: "Oyster Roast for Ada Mae Centenary",
  location: "New Bern, NC" })
Gig.create({
  published: true,
  date: "6 Dec 2015",
  name: "[Ole Time Winter Festival](http://www.heartofcary.org/ole-time-winter-festival)",
  location: "Cary, NC" })
