module ReleasesHelper

  def link_to_new_release
    if current_user.is_a_valid_subscriber?
      new_release_path
    elsif current_user.is_a_trial_subscriber? && current_user.try(:releases).try(:size) == 0
      new_release_path
    else
      plans_path
    end
  end

end
