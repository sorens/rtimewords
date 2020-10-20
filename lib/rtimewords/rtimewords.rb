require 'time'

module RTimeWords
    A_LONG_TIME_AGO = "a long time ago"
    JUST_NOW = "just now"
    SPACE_AGO = " ago"
    SPACE_AND_SPACE = " and "

    def ago(t)
        return A_LONG_TIME_AGO if t.year < 1970
        seconds = Time.now - t
        return JUST_NOW if seconds > -1 && seconds < 1
        return '' if seconds <= -1
        pair = pair(seconds)
        ary = singularize(pair)
        ary.size == 0 ? '' : ary.join(SPACE_AND_SPACE) << SPACE_AGO
    end

    def pair(s)
        [[60, :seconds], [60, :minutes], [24, :hours], [100_000, :days]].map{ |count, name|
          if s > 0
            s, n = s.divmod(count)
            "#{n.to_i} #{name}"
          end
        }.compact.reverse[0..1]
    end

    def singularize(p)
        if p.size == 1
          p.map! {|part| part[0, 2].to_i == 1 ? part.chomp('s') : part }
        else
          p.map! {|part| part[0, 2].to_i == 1 ? part.chomp('s') : part[0, 2].to_i == 0 ? nil : part }
        end
        p.compact
    end
end
