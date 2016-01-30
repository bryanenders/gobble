require 'spec_helper'

module Gobble
  describe Extraction do
    describe '::perform' do

      context 'given an empty list' do
        it 'returns empty lists of sequences and words' do
          result = Extraction.perform([])
          expect(result[:sequences]).to be_empty
          expect(result[:words]).to     be_empty
        end
      end

      context 'given a word' do
        context 'that is shorter than four letters' do
          it 'returns empty lists of sequences and words' do
            result = Extraction.perform(['cat'])
            expect(result[:sequences]).to be_empty
            expect(result[:words]).to     be_empty
          end
        end
        context 'that is four letters long' do
          it 'returns the word for both sequences and words' do
            result = Extraction.perform(['moon'])
            expect(result[:sequences]).to contain_exactly('moon')
            expect(result[:words]).to     contain_exactly('moon')
          end
        end
        context 'that is made of eight unique letters' do
          it 'returns five different sequences' do
            result = Extraction.perform(['abcdefgh'])
            expect(result[:sequences]).
              to eq(%w(abcd bcde cdef defg efgh))
            expect(result[:words]).
              to eq(%w(abcdefgh abcdefgh abcdefgh abcdefgh abcdefgh))
          end
        end
        context 'with repeating sequences' do
          it 'does not repeat the sequence' do
            result = Extraction.perform(['Mississippi'])
            expect(result[:sequences]).to eq(
              %w(Miss ippi issi sipp siss ssip ssis)
            )
            expect(result[:words]).to eq(
              %w(Mississippi Mississippi Mississippi Mississippi Mississippi
                 Mississippi Mississippi)
            )
          end
        end
        context 'with differently-cased repeating sequences' do
          let(:words) { ['BaNanANA'] }
          it 'repeats the sequence' do
            result = Extraction.perform(words)
            expect(result[:sequences]).
              to eq(%w(BaNa NanA aNan anAN nANA))
            expect(result[:words]).
              to eq(%w(BaNanANA BaNanANA BaNanANA BaNanANA BaNanANA))
          end
          context 'when I set "insensitive: true"' do
            it 'does not repeat the sequence' do
              result = Extraction.perform(words, insensitive: true)
              expect(result[:sequences]).to eq(%w(anan bana nana))
              expect(result[:words]).to eq(%w(bananana bananana bananana))
            end
          end
        end
      end

      context 'given two words' do
        it 'returns sorted sequences for both words' do
          result = Extraction.perform(['brain', 'heart'])
          expect(result[:sequences]).to eq(%w(brai eart hear rain))
          expect(result[:words]).to eq(%w(brain heart heart brain))
        end
        it 'omits sequences shared by both words' do
          result = Extraction.perform(['arrows', 'carrots'])
          expect(result[:sequences]).
            to eq(%w(carr rots rows rrot rrow))
          expect(result[:words]).
            to eq(%w(carrots carrots arrows carrots arrows))
        end
        context 'with differently-cased sequences shared by both words' do
          let(:words) { ['ARROWS', 'carrots'] }
          it 'does not omit the shared sequences' do
            result = Extraction.perform(words)
            expect(result[:sequences]).
              to eq(%w(ARRO ROWS RROW arro carr rots rrot))
            expect(result[:words]).
              to eq(%w(ARROWS ARROWS ARROWS carrots carrots carrots carrots))
          end
          context 'when I set "insensitive: true"' do
            it 'omits the shared sequences' do
              result = Extraction.perform(words, insensitive: true)
              expect(result[:sequences]).
                to eq(%w(carr rots rows rrot rrow))
              expect(result[:words]).
                to eq(%w(carrots carrots arrows carrots arrows))
            end
          end
        end
      end
    end
  end
end
