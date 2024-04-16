class FilesController < ApplicationController
  def songbook
    songbook_name = "motleytones-songbook-v2.4.pdf"
    songbook_file = "#{Rails.root}/app/assets/documents/#{songbook_name}"
    send_file(songbook_file, filename: songbook_name, type: "application/pdf", disposition: 'attachment')
  end
end
