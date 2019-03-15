module ProjectManagement
  module Fakes
    class CommandStore
      def store(command)
        @commands.push(command)
      end

      private

      def initialize
        @commands = []
      end
    end
  end
end
