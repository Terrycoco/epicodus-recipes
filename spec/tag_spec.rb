describe('Tag') do
  it('tells you what recipes are tagged as such') do
    Recipe.create({name: "Austin's diet"})
    Recipe.create({name: "Waffles"})
    tag = Tag.create({tag: "breakfast"})

    Recipe.all.each do |recipe|
      tag.recipes.push(recipe)
    end
  end
end
