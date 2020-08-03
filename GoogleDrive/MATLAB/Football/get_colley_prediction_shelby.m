function predMargin= get_colley_prediction_shelby(homeRating,visitRating,HFA)

%Conversion factor applied so that a one-point difference in ratings will
%be equivalent to a one-point predicted margin
a=100;
c=60;

homeRatingAdjusted = a+c.*(homeRating-0.5);

visitRatingAdjusted= a+c.*(visitRating-0.5);


%Add home field advantage constant to the home team's rating 
homeRatingAdjusted= homeRatingAdjusted +HFA;

predMargin=abs(homeRatingAdjusted - visitRatingAdjusted);

if predMargin>21
    alpha=0.8;
    predMarginAdjusted = ceil(21+(1/alpha).*[(predMargin-20)^alpha -1]);
end