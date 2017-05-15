module StravaLords
  class Tag
    include Comparable

    attr_reader :value

    def initialize(value:)
      @value = if integer?(value)
                 "#{value}rpe"
               else
                 value
               end
    end

    private

    def integer?(value)
      Integer(value)
    rescue
      false
    end

    def <=>(other)
      priority(value) <=> priority(other.value)
    end

    def priority(value)
      priority_words = [
        'long-ride', 'recovery', 'red-zone', 'fasted',
        'core', 'core-classes', 'yoga-classes', 'weights',
        'endurance', 'steady-state', 'tempo', '30m', 'stretched'
      ]

      priority_words.index(value) || 999
    end
  end
end
