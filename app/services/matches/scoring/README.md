## Matches::Scoring

- Think of this as another app where we only have values.
- External tables like `MatchParticipant` and `Submatch` are converted to value objects which are strings, arrays, and hashes. Check `adapters` and `values` directories for that.
- These are then passed into array generators (ex: `indie_match_array`) which compute both an array of scores and a final value.
- Computations between holes/array elements are usually placed inside the `computations` directory.
- Finally, presenters (`presenters` directory) combine these arrays and show them to the external Rails app.
