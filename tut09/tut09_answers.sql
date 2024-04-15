-- 1
SELECT player_name
FROM players
WHERE batting_hand = 'Left_Hand' AND country_name = 'England'
ORDER BY player_name;

-- 2
SELECT player_name, 
       CAST((YEAR('2018-12-02') - YEAR(dob)) AS SIGNED) AS player_age
FROM players
WHERE bowling_skill = 'Legbreak googly' AND 
      CAST((YEAR('2018-12-02') - YEAR(dob)) AS SIGNED) >= 28
ORDER BY player_age DESC, player_name;



--  3
SELECT match_id, toss_winner
FROM matches
WHERE toss_decision = 'bat'
ORDER BY match_id;



-- 4
SELECT over_id, runs_scored
FROM ball_by_ball
WHERE match_id = 335987 AND runs_scored <= 7
ORDER BY runs_scored DESC, over_id ASC;



-- 5
SELECT DISTINCT players.player_name
FROM players
JOIN ball_out ON players.player_id = ball_out.player_out
ORDER BY players.player_name;



-- 6
SELECT matches.match_id, teams1.name AS team_1, teams2.name AS team_2, 
       winner_teams.name AS winning_team_name, win_margin
FROM matches
JOIN teams AS teams1 ON matches.team_1 = teams1.team_id
JOIN teams AS teams2 ON matches.team_2 = teams2.team_id
JOIN teams AS winner_teams ON matches.match_winner = winner_teams.team_id
WHERE win_margin >= 60
ORDER BY win_margin, match_id;




-- 7
SELECT player_name
FROM players
WHERE batting_hand = 'Left_Hand' AND 
      CAST(TIMESTAMPDIFF(YEAR, dob, '2018-12-02') AS SIGNED INTEGER) < 30
ORDER BY player_name;




-- 8
SELECT match_id, SUM(runs_scored) AS total_runs
FROM ball_by_ball
GROUP BY match_id
ORDER BY match_id;




-- 9
SELECT match_id, MAX(runs_scored) AS maximum_runs, players.player_name
FROM ball_by_ball
JOIN players ON ball_by_ball.bowler = players.player_id
GROUP BY match_id
ORDER BY match_id, maximum_runs, over_id;




-- 10
SELECT players.player_name, COUNT(*) AS number
FROM players
JOIN ball_out ON players.player_id = ball_out.player_out AND ball_out.kind_out = 'run out'
GROUP BY players.player_name
ORDER BY number DESC, players.player_name;




-- 11
SELECT kind_out, COUNT(*) AS number
FROM ball_out
GROUP BY kind_out
ORDER BY number DESC, kind_out;




-- 12
SELECT teams.name, COUNT(*) AS number
FROM matches
JOIN teams ON matches.man_of_the_match = teams.team_id
GROUP BY teams.name
ORDER BY teams.name;




-- 13
SELECT venue
FROM (
    SELECT venue, COUNT(*) AS wides_count
    FROM ball_by_ball
    WHERE extra_type = 'wide'
    GROUP BY venue
    ORDER BY wides_count DESC, venue
) 
LIMIT 1;




-- 14
SELECT venue
FROM (
    SELECT venue, COUNT(*) AS win_count
    FROM matches
    JOIN ball_by_ball ON matches.match_id = ball_by_ball.match_id
    WHERE innings_no = 1 AND match_winner = team_bowling
    GROUP BY venue
    ORDER BY win_count DESC, venue
);





-- 15
SELECT players.player_name
FROM ball_by_ball
JOIN players ON ball_by_ball.bowler = players.player_id
GROUP BY players.player_id
ORDER BY (SUM(runs_scored) * 1.0 / COUNT(DISTINCT ball_id)) ASC, players.player_name
LIMIT 1;




-- 16
SELECT players.player_name, teams.name
FROM matches
JOIN role ON matches.match_id = role.match_id
JOIN players ON role.player_id = players.player_id
JOIN teams ON role.team_id = teams.team_id
WHERE role = 'CaptainKeeper' AND match_winner = role.team_id
ORDER BY players.player_name;




-- 17
SELECT players.player_name, SUM(runs_scored) AS total_runs
FROM ball_by_ball
JOIN players ON ball_by_ball.striker = players.player_id
GROUP BY players.player_name
HAVING total_runs >= 50
ORDER BY total_runs DESC, players.player_name;




-- 18
SELECT players.player_name
FROM ball_out
JOIN players ON ball_out.player_out = players.player_id
JOIN matches ON ball_out.match_id = matches.match_id
JOIN ball_by_ball ON ball_out.match_id = ball_by_ball.match_id 
                AND ball_out.over_id = ball_by_ball.over_id 
                AND ball_out.ball_id = ball_by_ball.ball_id
WHERE runs_scored >= 100 AND outcome_type != 'normal'
ORDER BY players.player_name;




-- 19
SELECT match_id, venue
FROM matches
WHERE (team_1 = (SELECT team_id FROM teams WHERE name = 'KKR') OR 
      team_2 = (SELECT team_id FROM teams WHERE name = 'KKR')) AND
      match_winner != (SELECT team_id FROM teams WHERE name = 'KKR')
ORDER BY match_id;





--  20
SELECT player_name
FROM (
    SELECT player_name, 
           SUM(CASE WHEN innings_no = 1 THEN 1 ELSE 0 END) AS matches_batted,
           SUM(runs_scored) AS total_runs
    FROM ball_by_ball
    JOIN players ON ball_by_ball.striker = players.player_id
    JOIN matches ON ball_by_ball.match_id = matches.match_id
    WHERE season_id = 5
    GROUP BY player_name
    HAVING matches_batted > 0
) AS batting_stats
ORDER BY (total_runs * 1.0 / matches_batted) DESC, player_name
LIMIT 10;
