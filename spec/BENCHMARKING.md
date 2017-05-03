## Benchmarking

- Use `benchmark` before you try out things randomly.

Example:

    n = 2000
    Benchmark.bmbm(7) do |x|
      x.report('delegator') { n.times {
        MatchPresenter.new(model: match).present
        }

      x.report('passing') { n.times {
      MatchPresenterNew.new(model: match).present
        }
      }
      }
    end
