# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Document.create([{path: '/CS31/COM_SCI_32_Smallberg_2007_Winter_MT'}, {uploader_id: "1"}, {type: "Test"}, {quarter_year: '2010_Fall'}])
#Course.create(department: 'Computer Science', course_id: '31', professor_last_name: 'Smallberg', professor_first_name: 'David', test_id: '5')
#Course.create(department: 'Computer Science', course_id: '32', professor_last_name: 'Nachenberg', professor_first_name: 'Carey', test_id: '6')
#Course.create(department: 'Computer Science and Biology', course_id: 'MLG', 
#              professor_last_name: 'Shrek', professor_first_name: 'Spoderman', test_id: '7')
Document.create([{path: '/CS33/COM_SCI_33_Reinman_2009_Spring_MT.pdf', uploader_id: "1", doc_type: "Test", quarter_year: '2009_Spring'}, {path: '/CS33/COM_SCI_33_Reinman_2010_Spring_MT_1.pdf', uploader_id: "1", doc_type: "Test", quarter_year: '2010_Spring'}, {path: '/CS33/COM_SCI_33_Rohr_2008_Fall_MT.pdf', uploader_id: "1", doc_type: "Test", quarter_year: '2008_Fall'}])
Course.create([{department: 'Computer Science', course_id: '33', professor_last_name: 'Reinman', professor_first_name: 'Glen', test_id: '4'},{department: 'Computer Science', course_id: '33', professor_last_name: 'Reinman', professor_first_name: 'Glen', test_id: '5'}, {department: 'Computer Science', course_id: '33', professor_last_name: 'Rohr', professor_first_name: 'John', test_id: '6'}]) 

