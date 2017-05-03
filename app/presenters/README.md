## Presenters

- Responsible for presenting json to the front-end
- Similar to ActiveModel::Serializers

## `BasePresenter`

- Delegates methods to the model in the constructor.  (ex: `MatchPresenter.new(model: match).match_participants` asks the `match` to call `match_participants`.)
