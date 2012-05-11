# coding: utf-8
module ApplicationHelper

	# datetile:整形対象の日付時刻値(Timeオブジェクト)
	# type:出力形式(日付時刻 :datetime、日付のみ :date、時刻のみ :time)
	def format_date(datetime, type = :datetime)
		return '' unless datetime

		case type
		when :datetime
			format = '%Y年%m月%d日 %H:%M:%S'
		when :date
			format = '%Y年%m月%d日'
		when :time
			format = '%H:%M:%S'
		end

		datetime.strftime(format)
	end

	# collection:リストのもととなるオブジェクト配列
	# prop:一覧するプロパティ名
	def list_tag(collection, prop)
		content_tag(:ul) do
			collection.each do |element|
				concat content_tag(:li, element.attributes[prop])
			end
		end
	end
end
