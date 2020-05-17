# IS2

IS LAB 2.

PROLOG.

playerLeague(X, Y):- player(X, Team), league(Y, Team).  
% league(uefa, realmadrid)

playersManager(X, Y):- player(X, Team), manager(Team, Y).
% playersManager(ronaldo, sarri)

managerTeamLeague(X, Y, Z):- manager(Y, X), league(Z, Y).
% managerTeamLeague(sarri, juventus, uefa)

cityPlayer(X, Y):- team(Team, X), player(Y, Team).
% cityPlayer(madrid, bale)

cityWonLeague(X, Y):- leaguePlayerWinner(Y, Player1), player(Player1, Team), team(Team, X).
% cityWonLeague(madrid, uefa)

