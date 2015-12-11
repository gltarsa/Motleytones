module MarkupHelper
  include ActionView::Helpers::UrlHelper

  # process "Motley Markup"
  def process_markup(raw)
    process_info(process_anchors(raw)).html_safe if raw
  end

  private

  # replace "@info" token with motleytones info address
  #
  def process_info(raw)
    info_re = /@info([^a-zA-Z])/
    mail_url = mail_to("info@motleytones.com")
    raw.gsub(info_re, "#{mail_url}\\1")
  end

  # Convert Markdown-like link format, "[link](addr)", into HTML
  #
  def process_anchors(raw)
    # anchor_re#match breaks line up into MatchData elements as follows
    #      [1]            [2]           [3]            [4]
    # |leading text| |[link name]| |(link address)| |trailing text|
    anchor_re = /(.*)\[(.*)\]\((.*)\)(.*)/
    matches = anchor_re.match(raw)

    if matches
      anchor = link_to(matches[2], matches[3])
      process_anchors("#{matches[1]}#{anchor}#{matches[4]}")
    else
      raw
    end
  end
end
