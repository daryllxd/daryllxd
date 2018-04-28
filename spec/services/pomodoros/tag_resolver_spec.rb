# frozen_string_literal: true

RSpec.describe Pomodoros::TagResolver, type: :service do
  context 'happy path' do
    let!(:programming_activity_tag) { create(:activity_tag, :programming) }
    let!(:daryllxd_activity_tag) { create(:activity_tag, :daryllxd) }

    it 'given a string, it resolves tags' do
      resolved_tags = execute.call(tag_string: 'pd')
      resolved_tags_reverse = execute.call(tag_string: 'dp')

      expect(resolved_tags).to match_array(
        [programming_activity_tag, daryllxd_activity_tag]
      )

      expect(resolved_tags).to be_valid

      expect(resolved_tags_reverse).to match_array(
        [programming_activity_tag, daryllxd_activity_tag]
      )
    end

    it 'performance: 1 query only' do
      expect { execute.call(tag_string: 'pd') }.to make_database_queries(count: 1)
    end
  end

  context 'errors' do
    context 'mix of find and didnt find' do
      let!(:programming_activity_tag) { create(:activity_tag, :programming) }

      it 'only returns what was found' do
        found_and_not_found_tags = execute.call(tag_string: 'ap')

        expect(found_and_not_found_tags).to match_array(
          [programming_activity_tag]
        )
      end
    end

    context 'unable to find tag' do
      it 'returns an empty array' do
        unresolved_tags = execute.call(tag_string: 'abc')

        expect(unresolved_tags).not_to be_valid
      end
    end

    context 'nil' do
      it 'returns an empty array' do
        unresolved_tags = execute.call(tag_string: nil)

        expect(unresolved_tags).not_to be_valid
      end
    end
  end
end
