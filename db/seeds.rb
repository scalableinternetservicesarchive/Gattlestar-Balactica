# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Document.create([{path: '/CS31/COM_SCI_32_Smallberg_2007_Winter_MT'}, {uploader_id: "1"}, {type: "Test"}, {quarter_year: '2010_Fall'}])
Course.create(department: 'Computer Science', course_id: '31', professor_last_name: 'Smallberg', professor_first_name: 'David', test_id: '5')
Course.create(department: 'Computer Science', course_id: '32', professor_last_name: 'Nachenberg', professor_first_name: 'Carey', test_id: '6')
Course.create(department: 'Computer Science and Biology', course_id: 'MLG', 
              professor_last_name: 'Shrek', professor_first_name: 'Spoderman', test_id: '7')
