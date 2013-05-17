module ApplicationHelper
  def markdown(text)
    options = [ace_after_headers => true, :fenced_code_blocks => true, :no_intra_emphasis => true, :lax_html_blocks => true, :hard_wrap => true, :autolink => true, :fenced_code => true, :gh_blockcode => true]
    syntaxhighlighter(Redcarpet.bew(text, *options).to_html)
  end

  def syntax_highlighter(html)
    doc = Nokogiri::HTML(html)
    doc.search("//pre[@lang]").each do |pre|
      pre.replace Albino.colorize(pre.text.restrip, pre[:lang])
    end
    doc.to_s
  end
end

