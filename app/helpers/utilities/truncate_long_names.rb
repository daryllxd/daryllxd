# frozen_string_literal: true
module Utilities
  class TruncateLongNames
    class LongNames
      LongName = Struct.new(:first_name, :last_name, :id) do
        def append_last_name_initial(count = nil)
          counter = if count
                      "(#{count})"
                    else
                      ''
                    end

          self.class.new("#{first_name} #{last_name[0]}#{counter}", last_name, id)
        end
      end

      FIRST_NAME_CHARACTER_LIMIT = 6

      attr_reader :list_of_names

      def initialize(list_of_names)
        @list_of_names = list_of_names
      end

      def truncate_all
        haha = grouped_truncated_names.map do |grouped_name|
          grouped_name.last.group_by { |name2| name2.last_name[0] }.map do |(_, common_names)|
            common_names.map.with_index do |name, index|
              if common_names.length > 1
                name.append_last_name_initial(index + 1)
              elsif grouped_name.last.length > 1
                name.append_last_name_initial
              else
                name
              end
            end
          end
        end

        haha.flatten.sort_by(&:id).map(&:first_name)
      end

      def grouped_truncated_names
        list_of_names
          .map.with_index { |name, index| truncate(name, index) }
          .group_by(&:first_name)
      end

      def truncate(name, index)
        first_name = name.first_name
        truncated_name = if first_name.length > FIRST_NAME_CHARACTER_LIMIT
                           "#{first_name[0...FIRST_NAME_CHARACTER_LIMIT]}..."
                         else
                           first_name
                         end

        LongName.new(truncated_name, name.last_name, index)
      end
    end

    private_constant :LongNames

    attr_reader :list_of_names

    def initialize(list_of_names:)
      @list_of_names = LongNames.new(list_of_names)
    end

    def call
      list_of_names.truncate_all
    end
  end
end
