module MediaContactMessagesHelper

  def detect_who_sent(media_contact_message)
    if media_contact_message.originator == MediaContactMessage::ORIGIN[:user]
      bxg_user_name_for(media_contact_message)
    else
      media_contact_message.media_list.company
    end

  end


  def detect_recipient_for(media_contact_message)
    if media_contact_message.originator != MediaContactMessage::ORIGIN[:user]
      bxg_user_name_for(media_contact_message)
    else
      media_contact_message.media_list.company
    end
  end


  def bxg_user_name_for(media_contact_message)
    if media_contact_message.release.user == current_user
      'Me'
    else
      media_contact_message.release.user.full_name
    end
  end


end
