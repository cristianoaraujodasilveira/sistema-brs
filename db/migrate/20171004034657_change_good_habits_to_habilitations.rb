class ChangeGoodHabitsToHabilitations < ActiveRecord::Migration
	def change
		good_habits = GoodHabit.all
		good_habits.each do |good_habit|
			Habilitation.find_or_create_by(:name => good_habit.name)
		end
	end
end
