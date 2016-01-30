require 'gobble/extraction/sequence_log'

module Gobble::Extraction
  class << self
    def perform(words, insensitive: false)
      words = words.map(&:downcase) if (insensitive)
      result = process(words)
      {sequences: result.keys, words: result.values}
    end

  private

    def process(words)
      log = SequenceLog.new
      words.each { |word| sequences(word).each { |seq| log.add(seq, word) } }
      log.result
    end

    def sequences(word)
      word.scan(/(?=([A-z][A-z][A-z][A-z]))/).flatten
    end
  end
end
