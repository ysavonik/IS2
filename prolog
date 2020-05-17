team(realmadrid, madrid).
team(juventus, torino).
team(galatasaray, istanbul).
team(kobenhavn, copenhagen).
team(manutd, manchester).
team(realsociedad, sansebastian).
team(shaktard, donetsk).
team(bleverkusen, leverkusen).
team(omarseille, marseille).
team(arsenal, london).
team(fcnapoli, napoli).
team(bdortmund, dortmund).

league(uefa, realmadrid).
league(uefa, juventus).
league(uefa, manutd).
league(ua, shaktard).

leaguePlayerWinner(uefa, bale).

manager(realmadrid, zidane).
manager(juventus, sarri).

player(bale, realmadrid).
player(ronaldo, juventus).

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

match(1, manutd, 4, bleverkusen, 1).
match(1, manutd, 3, shaktard, 1).
match(1, bdortmund, 3, omarseille, 0).
match(1, arsenal, 2, omarseille, 0).
match(1, juventus, 3, omarseille, 2).

match(2, juventus, 2, galatasaray, 2).
match(2, realmadrid, 4, kobenhavn, 0).
match(2, realmadrid, 2, manutd, 3).
match(2, bleverkusen, 1, realsociedad, 1).
match(2, bdortmund, 3, omarseille, 1).
match(2, arsenal, 2, fcnapoli, 0).

match(3, galatasaray, 3, shaktard, 1).
match(3, realmadrid, 2, juventus, 1).
match(3, manutd, 1, realsociedad, 0).
match(3, bleverkusen, 4, realsociedad, 0).
match(3, omarseille, 1, fcnapoli, 2).
match(3, arsenal, 1, bdortmund, 2).

match(4, kobenhavn, 1, galatasaray, 0).
match(4, juventus, 2, realmadrid, 2).
match(4, bleverkusen, 0, manutd, 5).
match(4, shaktard, 4, realsociedad, 0).
match(4, fcnapoli, 4, omarseille, 2).
match(4, bdortmund, 0, arsenal, 1).

match(5, realmadrid, 4, galatasaray, 1).
match(5, juventus, 3, kobenhavn, 1).
match(5, realsociedad, 0, manutd, 0).
match(5, shaktard, 0, bleverkusen, 0).
match(5, bdortmund, 3, fcnapoli, 1).
match(5, arsenal, 2, omarseille, 0).

match(6, galatasaray, 1, juventus, 0).
match(6, kobenhavn, 0, realmadrid, 2).
match(6, manutd, 1, shaktard, 0).
match(6, realsociedad, 2, bleverkusen, 0).
match(6, omarseille, 1, bdortmund, 2).
match(6, fcnapoli, 2, arsenal, 0).

isTeam(Team):- team(Team,_).

% playedMatches(Team, Week, Mathes):- 

wins(Team,Week,List,Number) :- findall(OtherTeam,(match(CurWeek,Team,Score1,OtherTeam,Score2),Score1>Score2,CurWeek=<Week),List1),findall(OtherTeam2,(match(CurWeek2,OtherTeam2,Score3,Team,Score4),Score4>Score3,CurWeek2=<Week),List2),append(List1,List2,List),length(List,Number).
% WINS: wins(manutd, 1, [bleverkusen,shaktard], 2)

losses(Team,Week,List,Number) :- findall(OtherTeam,(match(CurWeek,Team,Score1,OtherTeam,Score2),Score1<Score2,CurWeek=<Week),List1),findall(OtherTeam2,(match(CurWeek2,OtherTeam2,Score3,Team,Score4),Score4<Score3,CurWeek2=<Week),List2),append(List1,List2,List),length(List,Number).
% LOSSES: losses(omarseille, 1, [bdortmund,arsenal,juventus], 3)

draws(Team,Week,List,Number) :- findall(OtherTeam,(match(CurWeek,Team,Score1,OtherTeam,Score2),Score1=:=Score2,CurWeek=<Week),List1),findall(OtherTeam2,(match(CurWeek2,OtherTeam2,Score3,Team,Score4),Score4=:=Score3,CurWeek2=<Week),List2),append(List1,List2,List),length(List,Number).
% DRAWS: draws(juventus, 2, [galatasaray], 1)

scored(Team,Week,Score):- findall(Score1,(match(CurWeek,Team,Score1,_,_),CurWeek=<Week),List1),findall(Score2,(match(CurWeek,_,_,Team,Score2),CurWeek=<Week),List2),append(List1,List2,List),listsum(List,Score).
% SCORED: scored(shaktard, 3, 2)

conceded(Team,Week,Score):- findall(Score1,(match(CurWeek,Team,_,_,Score1),CurWeek=<Week),List1),findall(Score2,(match(CurWeek,_,Score2,Team,_),CurWeek=<Week),List2),append(List1,List2,List),listsum(List,Score).
% CONCEDED: conceded(shaktard, 3, 7)

average(Team,Week,Average):- scored(Team,Week,Scored), conceded(Team,Week,Conceded), Average is Scored-Conceded.
% average(shaktard, 3, -5)

listsum([], 0).
% base case
listsum([Head | Tail], Total) :-
listsum(Tail, Sum),
Total is Head + Sum.
