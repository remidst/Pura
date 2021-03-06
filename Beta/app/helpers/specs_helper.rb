module SpecsHelper

	def handicaps(spec)
		"身障(#{spec.handicap_physical.present? ? spec.handicap_physical : '　' })   療育(#{spec.handicap_rehabilitation.present? ? spec.handicap_rehabilitation : '　'})   精神(#{spec.handicap_psychological.present? ? spec.handicap_psychological : '　'})   難病(#{spec.handicap_disease.present? ? spec.handicap_disease : '　'})"
	end

	def spec_creation_date(spec)
		if spec.creation_date.present?
			spec.creation_date.to_era("%O%E年%m月%d日")
		else
			""
		end
	end

	def spec_evaluation_date(spec)
		if spec.evaluation_date.present?
			spec.evaluation_date.to_era("%O%E年%m月%d日")
		else
			""
		end
	end

	def spec_kaigo_validity_from(spec)
		if spec.kaigo_validity_from.present?
			spec.kaigo_validity_from.to_era("%O%E年%m月%d日")
		else
			""
		end
	end

	def spec_kaigo_validity_until(spec)
		if spec.kaigo_validity_until.present?
			spec.kaigo_validity_until.to_era("%O%E年%m月%d日")
		else
			""
		end
	end

	def payment_ratio(spec)
		if spec.payment_ratio.present?
			if  spec.payment_ratio == 0
				"負担なし"
			else
				"#{spec.payment_ratio}割"
			end
		else
			""
		end
	end

	def spec_birthday(spec)
		"#{spec.birthday_year.present? ? spec.birthday_year : '　'}年#{spec.birthday_month.present? ? spec.birthday_month : '　　'}月#{spec.birthday_day.present? ? spec.birthday_day : '　　'}日"
	end

	def bday_era(spec)
		if spec.birthday_era.present?
			if spec.birthday_era == 1
				'明治'
			elsif spec.birthday_era == 2
				'大正'
			elsif spec.birthday_era == 3
				'昭和'
			elsif spec.birthday_era == 4
				'平成'
			else
			end
		else
			'M T S　'	
		end
	end


end
