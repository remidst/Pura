module SpecsHelper

	def handicaps(spec)
		"身障(#{spec.handicap_physical.present? ? spec.handicap_physical : '　' })   療育(#{spec.handicap_rehabilitation.present? ? spec.handicap_rehabilitation : '　'})   精神(#{spec.handicap_psychological.present? ? spec.handicap_psychological : '　'})   難病(#{spec.handicap_disease.present? ? spec.handicap_disease : '　'})"
	end

	def spec_creation_date(spec)
		if spec.creation_date.present?
			"平成#{spec.creation_date.year - 1988}年#{spec.creation_date.month}月#{spec.creation_date.day}日"
		else
			""
		end
	end

	def spec_evaluation_date(spec)
		if spec.evaluation_date.present?
			"平成#{spec.evaluation_date.year - 1988}年#{spec.evaluation_date.month}月#{spec.evaluation_date.day}日"
		else
			""
		end
	end

	def spec_kaigo_validity_from(spec)
		if spec.kaigo_validity_from.present?
			"平成#{spec.kaigo_validity_from.year - 1988}年#{spec.kaigo_validity_from.month}月#{spec.kaigo_validity_from.day}日"
		else
			""
		end
	end

	def spec_kaigo_validity_until(spec)
		if spec.kaigo_validity_until.present?
			"平成#{spec.kaigo_validity_until.year - 1988}年#{spec.kaigo_validity_until.month}月#{spec.kaigo_validity_until.day}日"
		else
			""
		end
	end


end
