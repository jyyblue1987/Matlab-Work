function electionMapper

mapBoundaries = getBoundaryDataFromFile('data/NC.txt')

regionColor = regionPureColor('data/NC2012.txt', 'NC')

plotMap(regionColor, mapBoundaries, 'NC')


