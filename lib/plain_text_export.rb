class PlainTextExport < Nanoc::Filter
  identifier :plain_text_export

  def run(content, params = {})
    content = content.lstrip
    content = "# #{params[:title]}\n\n#{content}" if params[:title]
    MdWrap.wrap(content, wrap_footnotes: true)
  end
end
