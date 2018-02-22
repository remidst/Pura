module SpecsHelper

	def handicaps(spec)
		"身障(#{spec.handicap_physical.present? ? spec.handicap_physical : '　' })   療育(#{spec.handicap_rehabilitation.present? ? spec.handicap_rehabilitation : '　'})   精神(#{spec.handicap_psychological.present? ? spec.handicap_psychological : '　'})   難病(#{spec.handicap_disease.present? ? spec.handicap_disease : '　'})"
	end


end
