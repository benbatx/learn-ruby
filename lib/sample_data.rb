class SampleData
  attr_reader :name
  def initialize(name)
    @name = name
  end
  def contents
    @contents ||= File.read(File.join(APP_PATH, 'data', name))
  end
  def sample_words(count=100)
    words = contents.split("\n").map(&:strip).map(&:downcase)
    words.select!{|word| word.match(/\A[a-z]+\Z/)}

    words.sample(count)
  end
  def sample_sentences
    _contents = contents.dup.downcase
    _contents.gsub!(/\.+/, '.')
    _contents.gsub!(/[^a-z\. ]/, ' ')
    _contents.gsub!(/ +/, ' ')
    _contents.split('.').map(&:strip).sample(100)
  end

  class << self
    def words(name)
      self.new(name).sample_words
    end
  end
end
