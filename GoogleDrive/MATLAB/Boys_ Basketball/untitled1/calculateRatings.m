function data= calcs(data)


massey = masseyRating(data);
colley = colleyRating(data);
elo = eloRating(data);
data.Massey = massey;
data.Colley = colley;
data.Elo = elo;