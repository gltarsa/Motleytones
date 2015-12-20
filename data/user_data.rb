STARTER_PASSWORD ||= ENV["STARTER_PASSWORD"]

User.create!({
  name: "Greg Tarsa",
  email: "flintz@motleytones.com",
  admin: true,
  password: STARTER_PASSWORD,
  password_confirmation: STARTER_PASSWORD,
  tone_name: "Flintz Tone",
  band_start_date: "Fri, 09 Jul 2010" })
User.create!({
  name: "Kat Tarsa",
  email: "ring@motleytones.com",
  admin: true,
  password: STARTER_PASSWORD,
  password_confirmation: STARTER_PASSWORD,
  tone_name: "Flintz Tone",
  band_start_date: "01 Apr 2011"})
User.create!({
  name: "Non-Admin",
  email: "nonadmin@motley.com",
  admin: false,
  password: STARTER_PASSWORD,
  password_confirmation: STARTER_PASSWORD,
  tone_name: "Not An Admin Tone",
  band_start_date: "Fri, 19 Jul 2010"})
