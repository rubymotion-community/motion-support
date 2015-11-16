# rubocop:disable Style/MethodName, Lint/UnusedMethodArgument, Lint/DuplicateMethods
class WordsViewController < UITableViewController
  WORDS = [
    [
      "Single words",
      %w{
        alias
        axis
        buffalo
        bus
        cat
        child
        cow
        crisis
        dog
        house
        man
        matrix
        mouse
        move
        octopus
        ox
        parenthesis
        person
        quiz
        series
        sex
        vertex
        zombie
      }
    ], [
      "Uncountable words",
      %w{
        equipment
        fish
        information
        jeans
        money
        police
        rice
        series
        sheep
        species
      }
    ], [
      "Programming",
      %w{
        app_delegate
        motion_support
        motion_support/inflector
        ruby_motion
      }
    ], [
      "Acronyms",
      %w{
        free_bsd
        html_api
        html_tidy
        ui_image
        ui_table_view_controller
        xml_http_request
      }
    ]
  ]

  def initWithParent(parent)
    @parent = parent

    self.title = "Select word"

    self
  end

  def numberOfSectionsInTableView(_tableView)
    WORDS.size
  end

  def tableView(_tableView, titleForHeaderInSection:section)
    WORDS[section].first
  end

  def tableView(_tableView, numberOfRowsInSection:section)
    WORDS[section].last.size
  end

  def tableView(_tableView, cellForRowAtIndexPath:indexPath)
    fresh_cell.tap do |cell|
      cell.textLabel.text = WORDS[indexPath.section].last[indexPath.row]
    end
  end

  def tableView(_tableView, didSelectRowAtIndexPath:indexPath)
    @parent.set_word(WORDS[indexPath.section].last[indexPath.row])
    navigationController.popViewControllerAnimated(true)
  end

  private

  def fresh_cell
    tableView.dequeueReusableCellWithIdentifier("Cell") ||
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, :reuseIdentifier => "Cell")
  end
end
# rubocop:enable Style/MethodName, Lint/UnusedMethodArgument, Lint/DuplicateMethods
