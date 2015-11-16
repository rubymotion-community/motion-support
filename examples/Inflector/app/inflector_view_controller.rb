class InflectorViewController < Formotion::FormController
  def init
    initWithForm(build_form)
    self.title = "Inflector"
    @form.on_submit do |form|
      submit(form)
    end
    self
  end

  def submit(form)
    data = form.render
    original = String.new(data[:word])

    update_fields(original)

    form.row(:word).text_field.resignFirstResponder
  end

  def set_word(word)
    @form.values = { :word => word }
    update_fields(word)
  end

  def update_fields(original)
    @form.values = {
      :singular => original.singularize,
      :plural => original.pluralize,
      :camelized => original.camelize,
      :lower_camelized => original.camelize(:lower),
      :underscored => original.underscore,
      :classified => original.classify,
      :dasherized => original.dasherize,
      :titleized => original.titleize,
      :humanized => original.humanize
    }
  end

  private

  def build_form
    @form ||= Formotion::Form.persist(:sections => [{
                                        :rows => [{
                                          :title => "Word",
                                          :key => :word,
                                          :type => :string,
                                          :placeholder => "Enter a word",
                                          :auto_correction => :no,
                                          :auto_capitalization => :none
                                        }, {
                                          :title => "Select",
                                          :type => :button,
                                          :key => :select
                                        }]
                                      }, {
                                        :rows => [{
                                          :title => "Inflect",
                                          :type => :submit
                                        }]
                                      }, {
                                        :title => "Inflections",
                                        :rows => [{
                                          :title => "Singular",
                                          :key => :singular,
                                          :type => :static
                                        }, {
                                          :title => "Plural",
                                          :key => :plural,
                                          :type => :static
                                        }]
                                      }, {
                                        :title => "Transformations",
                                        :rows => [{
                                          :title => "Camelized",
                                          :key => :camelized,
                                          :type => :static
                                        }, {
                                          :title => "Lower-Camelized",
                                          :key => :lower_camelized,
                                          :type => :static
                                        }, {
                                          :title => "Underscored",
                                          :key => :underscored,
                                          :type => :static
                                        }, {
                                          :title => "Classified",
                                          :key => :classified,
                                          :type => :static
                                        }, {
                                          :title => "Dasherized",
                                          :key => :dasherized,
                                          :type => :static
                                        }, {
                                          :title => "Titleized",
                                          :key => :titleized,
                                          :type => :static
                                        }, {
                                          :title => "Humanized",
                                          :key => :humanized,
                                          :type => :static
                                        }]
                                      }])
    @form.row(:select).on_tap do
      navigationController.pushViewController(
        WordsViewController.alloc.initWithParent(self), :animated => true
      )
    end
    @form
  end
end
