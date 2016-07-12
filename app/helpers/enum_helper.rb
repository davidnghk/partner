module EnumHelper

  def t_enum(inst, enum)
    value = inst.send(enum);
    t_enum_class(inst.class, enum, value)
  end

  def t_enum_class(klass, enum, value)
    unless value.blank?
      I18n.t("activerecord.enums.#{klass.to_s.demodulize.underscore}.#{enum}.#{value}")
    end
  end

  def options_for_enum(object, enum)
    options = enums_to_translated_options_array(object.class.name, enum.to_s)
    options_for_select(options, object.send(enum))
  end

  def enums_to_translated_options_array(klass, enum)
    klass.classify.safe_constantize.send(enum.pluralize).map {
        |key, value| [I18n.t("activerecord.enums.#{klass.downcase}.#{enum}.#{key}").humanize, key]
    }
  end

end