class ProblemSpec < Struct.new(:path, keyword_init: true)
  def comment_header_lines
    content = File.read(specs_file_path)
    lines = content.split("\n")
    non_comment_lines = 0
    at_begin = true
    second_non_comment_line_no = lines.index do |line|
      if line[0] != '#'
        if at_begin
          at_begin = false
          next false
        end
        next true
      end
      false
    end
    comment_lines = if second_non_comment_line_no
      lines[0..second_non_comment_line_no - 1]
    else
      lines
    end
    hi_index
  end
end
