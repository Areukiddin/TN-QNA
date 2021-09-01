module AttachmentsHelper
  def delete_link(attachment)
    link_to "Delete", attachment.record_type.eql?('Answer') ? delete_answer_attachment_file_path(id: attachment.record_id ,file_id: attachment.id) : delete_attachment_file_path(file_id: attachment.id), method: :delete, remote: true
  end
end
