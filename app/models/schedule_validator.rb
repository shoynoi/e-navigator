class ScheduleValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, "can't be in the past") if value < DateTime.now
  end
end
