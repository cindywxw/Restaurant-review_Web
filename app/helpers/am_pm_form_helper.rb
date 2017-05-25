module AmPmFormHelper
  	#pass start:Fixnum in the options hash to set the first drop down selection
 	def am_pm_hour_select(object, options = {}, html_options = {})
   		select_options = [ ["11am", 11], ["12pm", 12], ["1pm", 13], ["2pm", 14], ["3pm", 15], ["4pm", 16], ["5pm", 17], ["6pm", 18], ["7pm", 19], ["8pm", 20], ["9pm", 21], ["10pm", 22] ]
   		unless options[:start].nil?
 			shift_if_needed = Proc.new{|hour, start| hour<start ? hour+24 : hour} 
 			select_options.sort!{|x, y| shift_if_needed.call(x.last,options[:start]) <=> shift_if_needed.call(y.last, options[:start]) }
    	end

    	object.select(select_options,options = {})
 	end	
end