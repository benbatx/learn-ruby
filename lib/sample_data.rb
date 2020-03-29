class SampleData
  attr_reader :name
  def initialize(name)
    @name = name
  end
  def contents
    @contents ||= File.read(File.join(APP_PATH, 'data', name))
  end
  def distinct_len_words(count=5)
    _words = contents.split("\n").map(&:strip).map(&:downcase)
    _words = _words.shuffle.uniq{|word| word.length}
    _words.select!{|word| word.length < count * 1.5}
    _words[0..count-1]
  end
  def words(count=100)
    _words = contents.split("\n").map(&:strip).map(&:downcase)
    # words.select!{|word| word.match(/\A[a-z]+\Z/)}

    _words.sample(count)
  end
  def sentences
    _contents = contents.dup.downcase
    _contents.gsub!(/\.+/, '.')
    _contents.gsub!(/[^a-z\. ]/, ' ')
    _contents.gsub!(/ +/, ' ')
    _contents.split('.').map(&:strip).sample(100)
  end

  class << self
    def words(name)
      self.new(name).words
    end
  end
end
