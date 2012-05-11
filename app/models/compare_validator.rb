# coding: utf-8
class CoparaValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		cmp = record.attributes[options[:compare_to]].to_i
		case options[:type]
		when :greater_than
			record.errors.add(attribute, 'は指定項目より大きくなければなりません。') unless vlaue > cmp
		when :less_than
			record.errors.add(attribute, 'は指定項目より小さくなければなりません。') unless vlaue < cmp
		when :equal
			record.errors.add(attribute, 'は指定項目等しくなければなりません。') unless vlaue == cmp
		else
			rails 'unknown type'
		end
	end
end

# validates :min_value,
#   :compare => { :compare_to => 'max_value', :type => :less_than
# のように使う
