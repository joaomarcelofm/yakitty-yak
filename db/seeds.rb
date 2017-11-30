Skill.destroy_all
Interest.destroy_all

skills = ["Ruby", "Rails", "Javascript", "HTML", "CSS", "React", "Python"]
interests = ["Ruby", "Rails", "Javascript", "HTML", "CSS", "React", "Python", "Frontend", "Design", "Freelancing"]

skills.each do |element|
  Skill.create(name: element)
end

interests.each do |element|
  Interest.create(name: element)
end
