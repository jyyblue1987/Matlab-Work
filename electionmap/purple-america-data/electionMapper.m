function electionMapper

mapBoundaries = getBoundaryDataFromFile('data/NC.txt')

regionColor = regionPureColor('data/NC2012.txt')

plotMap(regionColor, mapBoundaries, 'NC')


