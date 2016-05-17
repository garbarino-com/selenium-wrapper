require "selenium/wrapper/version"

module Selenium    
	class Wrapper < Selenium::WebDriver::Support::AbstractEventListener

  def after_navigate_to(url, driver)
    add_growl(driver)
    display_growl(driver, "Navigated to #{url}")
  end

  def before_find(by, what, driver)
    display_growl(driver, "Finding element #{by}: #{what}")
  end

  # def after_find(by, what, driver)
  #   display_growl(driver, "Found element #{what}")
  # end

  def before_click(element, driver)
    display_growl(driver, "Clicking on #{element.text}")
    @pre_click_url = driver.current_url
  end

  def after_click(element, driver)
    unless @pre_click_url == driver.current_url
      add_growl(driver)
      display_growl(driver, "URL changed to #{driver.current_url}")
    end
  end

  # def before_navigate_to(url, driver) end
  # def after_navigate_to(url, driver) end
  # def before_navigate_back(driver) end
  # def after_navigate_back(driver) end
  # def before_navigate_forward(driver) end
  # def after_navigate_forward(driver) end
  # def before_find(by, what, driver) end
  # def after_find(by, what, driver) end
  # def before_click(element, driver) end
  # def after_click(element, driver) end
  # def before_change_value_of(element, driver) end
  # def after_change_value_of(element, driver) end
  # def before_execute_script(script, driver) end
  # def after_execute_script(script, driver) end
  # def before_quit(driver) end
  # def after_quit(driver) end
  # def before_close(driver) end
  # def after_close(driver) end


  private

  def add_growl(driver)
     driver.execute_script("if (!window.jQuery) {
        var jquery = document.createElement('script'); jquery.type = 'text/javascript';
        jquery.src = 'https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js';
        document.getElementsByTagName('head')[0].appendChild(jquery);
      }")

    driver.execute_script(
"$.getScript('https://ksylvest.github.io/jquery-growl/javascripts/jquery.growl.js')")

    driver.execute_script("$('head').append('<link href=\"https://ksylvest.github.io/jquery-growl/stylesheets/jquery.growl.css\" rel=\"stylesheet\" type=\"text/css\">');")

    sleep 1
  end

  def display_growl(driver, message)
    driver.execute_script("$.growl({ title: 'Selenium', message: '#{message}' });")
    sleep 0.5
  end

end




  end
end
