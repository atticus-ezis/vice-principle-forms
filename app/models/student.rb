class Student < ApplicationRecord
    has_many_attached :form_files # uploaded file 

    # checks essential info 
    validates :student_name, :parent_name, :grade, presence: true 
    # checks form_name is correct if present 
    validate :validate_form_names
    
    after_save :update_status 
    
    private

    # create a list of allowed form names, if a name is entered outside this list, return error
    def validate_form_names
        allowed_form_names = ['Contact', 'Sports-Physical']
        # Split form_name into an array of individual names, removing extra spaces
        submitted_form_names = form_name.to_s.split(',').map(&:strip)
    
        # Check if any submitted form names are invalid
        invalid_form_names = submitted_form_names - allowed_form_names
        if invalid_form_names.any?
          errors.add(:form_name, "contains invalid entries: #{invalid_form_names.join(', ')}. Allowed values are: #{allowed_form_names.join(', ')}")
        end
    end
    
    # Updates status based on form names and attached files
    def update_status  
        # must have contact and sports form if sport mentioned
        form_names_valid = form_name&.include?('Contact') && (sports.blank? || form_name&.include?('Sports-Physical'))
        # get number of forms
        form_types = form_name.to_s.split(',').map(&:strip)
        # are there enough form files for the forms listed
        all_files_present = form_files.count == form_types.count  
        # Set status to true only if both conditions are met
        update_column(:status, form_names_valid && all_files_present)
    

        Rails.logger.debug "HHHHHH Form files attached: #{form_files.map(&:filename).join(', ')}"
        Rails.logger.debug "HHHHHH Form file count: #{form_files.count}"
        Rails.logger.debug "HHHHHH Form names valid? #{form_names_valid}"
        Rails.logger.debug "HHHHHH All required files present? #{all_files_present}"
        Rails.logger.debug "HHHHHH Final status: #{form_names_valid && all_files_present}"
    end
      
      
    
end
    
  