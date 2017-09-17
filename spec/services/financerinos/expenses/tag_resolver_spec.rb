# frozen_string_literal: true
RSpec.describe Financerinos::Expenses::TagResolver, type: :service do
  context 'happy path' do
    let!(:food_budget_tag) { create(:budget_tag, :food) }
    let!(:uber_budget_tag) { create(:budget_tag, :uber) }

    it 'given a string, it resolves tags' do
      resolved_tags = execute.call(tag_string: 'fu')
      resolved_tags_reverse = execute.call(tag_string: 'uf')

      expect(resolved_tags).to match_array(
        [food_budget_tag, uber_budget_tag]
      )

      expect(resolved_tags_reverse).to match_array(
        [food_budget_tag, uber_budget_tag]
      )
    end
  end

  context 'errors' do
    context 'mix of find and didnt find' do
      let!(:food_budget_tag) { create(:budget_tag, :food) }

      it 'only returns what was found' do
        found_and_not_found_tags = execute.call(tag_string: 'fx')

        expect(found_and_not_found_tags).to match_array(
          [food_budget_tag]
        )
      end
    end

    context 'unable to find tag' do
      it 'returns an empty array' do
        unresolved_tags = execute.call(tag_string: 'abc')

        expect(unresolved_tags).to be_empty
      end
    end

    context 'nil' do
      it 'returns an empty array' do
        unresolved_tags = execute.call(tag_string: nil)

        expect(unresolved_tags).to be_empty
      end
    end
  end
end
