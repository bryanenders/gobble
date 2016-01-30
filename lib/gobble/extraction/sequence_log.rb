module Gobble::Extraction
  class SequenceLog
    def initialize
      @hash = Hash.new
    end

    def add(sequence, word)
      if (repeating?(sequence, word))
        @hash.delete(sequence)
      else
        @hash[sequence] = word
      end
    end

    def result
      @hash.sort.to_h
    end

  private

    def repeating?(sequence, word)
      @hash[sequence] && @hash[sequence] != word
    end
  end
end
