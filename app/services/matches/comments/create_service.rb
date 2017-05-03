module Matches
  module Comments
    class CreateService < BaseService
      attr_reader :commenter, :match, :content

      def initialize(commenter:, match:, **comment_attributes)
        @commenter = commenter
        @match = match
        @content = comment_attributes[:content]
      end

      def call
        new_comment = Comment.create(
          commentable: match,
          commenter: commenter,
          content: content
        )

        if new_comment.valid?
          new_comment
        else
          record_invalid_error_from(new_comment)
        end
      end
    end
  end
end
