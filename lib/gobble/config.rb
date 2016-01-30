class Gobble::Config
  attr_reader :file

  def initialize(arguments)
    errors = nil
    arguments.each do |arg|
      case arg
        when '-i','--ignore-case'
          @insensitive = true
        when /\A-/
          errors = true
        else
          if @file
            errors = true
          else
            @file = arg
          end
      end
    end
    if errors or !@file or !File.file?(@file)
      puts USAGE
      exit
    end
  end

  def insensitive?
    @insensitive || false
  end
end


Gobble::Config::USAGE = <<ENDUSAGE
usage: gobble [-i] dictionary

       -i, --ignore-case  Perform case insensitive matching.  By default, gobble
                          is case sensitive.
ENDUSAGE
