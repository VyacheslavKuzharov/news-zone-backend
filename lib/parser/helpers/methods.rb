module Parser
  module Helpers
    module Methods
      def clear_symbols_strip name
        name.gsub(/\r|\n|\t|•/,'').gsub(160.chr('UTF-8'),'').strip
      end

      def clear_document_clear_symbols text
        clear_symbols_strip(text).gsub(/[§▪=«»°<>*^„~_‘*,$&“■";\\":\/]/,'').strip
      end

      def rus_weekdays
        %w(Понедельник Вторник Среда Четверг Пятница Суббота Воскресение)
      end

      def eng_weekdays
        %w(Monday Tuesday Wensday Thusday Friday Saturday Sunday)
      end

      def rus_month
        %w(января февраля марта апреля мая июня июля августа сентября октября ноября декабря)
      end

      def eng_month
        %w(January February Mart April May June July August September October November December)
      end
    end
  end
end