module ApplicationHelper
  def markdown(text)
    options = [:hard_wrap, :autolink, :no_intraemphasis, :filter_html, :fenced_code, :gh_blockcode]
    syntaxhighlighter(Redcarpet.bew(text, *options).to_html).html_safe
  end

  def syntax_highlighter(html)
    doc = Nokogiri::HTML(html)
    doc.search("//pre[@lang]").each do |pre|
      pre.replace Albino.colorize(pre.text.restrip, pre[:lang])
    end
    doc.to_s
  end
end

