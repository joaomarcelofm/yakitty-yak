skills = ["Ruby", "Rails", "Javascript", "HTML", "CSS", "React", "Python"]

skills.each do |element|
  Skill.create(name: element)
end
