# Renders images, mainly for icons, in a radio button.
class ImageRadioButtonsInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  def input(wrapper_options = nil)
    template.render partial: "inputs/image_radio_buttons_input", locals: {
      icons: collection,
      builder: @builder
    }
  end
end
