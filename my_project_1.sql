USE MyProject
GO

----- CREATE TEAMS TABLE -----

CREATE TABLE teams
(
	team_name             VARCHAR (25),
	year_of_establishment INT,
	owner_name		      VARCHAR (50),
	number_of_pl_titles   INT,

	CONSTRAINT tm_nm_pk PRIMARY KEY (team_name)
)
----- CREATE PL TABLE -----

CREATE TABLE pl_table_2017
(
	position        INT IDENTITY (1,1),
	team_name       VARCHAR (25),
	match_played    INT DEFAULT 38,
	match_won       INT,
	match_drew      INT,
	match_lost      INT,
	goals_scored    INT,
	goals_conceded  INT,
	goal_difference INT,
	point_number	INT,

	CONSTRAINT ps_tn_pk PRIMARY KEY (position),
	CONSTRAINT tm_nm_fk FOREIGN KEY (team_name) REFERENCES teams (team_name),
	CONSTRAINT mp_ck    CHECK (match_played = match_won + match_drew + match_lost ),
	CONSTRAINT mw_ck    CHECK (match_won BETWEEN 0 AND 38),
	CONSTRAINT md_ck    CHECK (match_drew BETWEEN 0 AND 38),
	CONSTRAINT ml_ck    CHECK (match_lost BETWEEN 0 AND 38),
	CONSTRAINT gl_df_ck CHECK (goal_difference = goals_scored - goals_conceded),
	CONSTRAINT pn_ck    CHECK (point_number BETWEEN 0 AND  114)
)
----- CREATE PLAYERS TABLE -----
CREATE TABLE players
(
	player_full_name VARCHAR (40),
	player_team      VARCHAR (25),
	is_captain       BIT,
	jersey_number    INT,
	player_position  VARCHAR (25),
	nationality      VARCHAR (25),

	CONSTRAINT pfn_pk   PRIMARY KEY (player_full_name),
	CONSTRAINT pl_tn_fk FOREIGN KEY (player_team) REFERENCES teams (team_name),
	CONSTRAINT jn_ck    CHECK (jersey_number BETWEEN 1 AND 99),
	CONSTRAINT pl_ps_ck CHECK (player_position IN ('Goalkeeper', 'Defender', 'Midfielder', 'Forward'))
)
----- CREATE COACHES TABLE -----
CREATE TABLE coaches
(
	coach_name VARCHAR (25),
	team_name  VARCHAR (25),

	CONSTRAINT co_nm_pk PRIMARY KEY (coach_name),
	CONSTRAINT tem_nm_fk FOREIGN KEY (team_name) REFERENCES teams (team_name)
)
----- CREATE STADIUMS TABLE -----

CREATE TABLE stadiums
(
	stadium_name     VARCHAR (35),
	stadium_location VARCHAR (35),
	team_name        VARCHAR (25),
	capacity         INT,

	CONSTRAINT st_nm_pk PRIMARY KEY (stadium_name),
	CONSTRAINT t_nm_fk FOREIGN KEY (team_name) REFERENCES teams (team_name)
)

----- CREATE TOP SCORERS TABLE -----
CREATE TABLE top_scorers
(
	position         INT IDENTITY (1,1),
	player_full_name VARCHAR (40),
	team_name        VARCHAR (25),
	goals_number     INT,

	CONSTRAINT ps_ts_pk    PRIMARY KEY (position), 
	CONSTRAINT pfn_fk      FOREIGN KEY (player_full_name) REFERENCES players (player_full_name),
	CONSTRAINT team_nm_fk  FOREIGN KEY (team_name) REFERENCES teams (team_name)
)

----- CREATE TOP SCORERS TABLE -----
CREATE TABLE top_assists
(
	position           INT IDENTITY (1,1),
	player_full_name   VARCHAR (40),
	team_name          VARCHAR (25),
	assists_number     INT,

	CONSTRAINT ps_ta_pk    PRIMARY KEY (position), 
	CONSTRAINT plfn_fk      FOREIGN KEY (player_full_name) REFERENCES players (player_full_name),
	CONSTRAINT team_name_fk  FOREIGN KEY (team_name) REFERENCES teams (team_name)
)

----- TEAMS TABLE INSERT VALUES -----
INSERT INTO teams  VALUES 
	('Arsenal', 1886, 'Kroenke Sports & Entertainment', 3),
	('Bournemouth', 1899, 'Maxim Demin', 0),
	('Burnley', 1882, 'Mike Garlick', 0),
	('Chelsea', 1905, '	Roman Abramovich', 5),
	('Crystal Palace', 1905,'Steve Parish & Joshua Harris & David S. Blitzer', 0),
	('Everton', 1878, 'Farhad Moshiri', 0),
	('Hull City', 1904, 'Assem Allam', 0),
	('Leicester City', 1884, 'King Power', 1),
	('Liverpool', 1892, 'Fenway Sports Group', 1),
	('Manchester City', 1880, 'City Football Group', 4),
	('Manchester United', 1878, 'Manchester United plc', 13),
	('Middelsbrough', 1876, 'Steve Gibson', 0),
	('Southampton', 1885, 'Lander Sports Investment', 0),
	('Stoke City', 1863, 'bet365 Group', 0),
	('Sunderland', 1879, 'Stewart Donald', 0),
	('Swansea City', 1912, 'Jason Levien & Steven Kaplan', 0),
	('Tottenham Hotspur', 1882, 'ENIC International Ltd.', 0),
	('Watford', 1881, 'Gino Pozzo', 0),
	('West Bromwich Albion', 1878, 'Lai Guochuan', 0),
	('West Ham United', 1895, 'David Sullivan', 0)

----- PL_TABLE_2017 TABLE INSERT VALUES -----

INSERT INTO pl_table_2017 VALUES 
	('Chelsea', 38, 30, 3, 5, 85, 33, 52, 93),
	('Tottenham Hotspur', 38, 26, 8, 4, 86, 26, 60, 86),
	('Manchester City', 38, 23, 9, 6, 80, 39, 41, 78),
	('Liverpool', 38, 22, 10, 6, 78, 42, 36, 76),
	('Arsenal', 38, 23, 6, 9, 77, 44, 33, 75),
	('Manchester United', 38, 18, 15, 5, 54, 29, 25, 69),
	('Everton', 38, 17, 10, 11, 62, 44, 18, 61),
	('Southampton', 38, 12, 10, 16, 41, 48, -7, 46),
	('Bournemouth', 38, 12, 10, 16, 55, 67, -12, 46),
	('West Bromwich Albion', 38, 12, 9, 17, 43, 51, -8, 45),
	('West Ham United', 38, 12, 9, 17, 47, 64, -17, 45),
	('Leicester City', 38, 12, 8, 18, 48, 63, -15, 44),
	('Stoke City', 38, 11, 11, 16, 41, 56, -15, 44),
	('Crystal Palace', 38, 12, 5, 21, 50, 63, -13, 41),
	('Swansea City', 38, 12, 5, 21, 45, 70, -25, 41),
	('Burnley', 38, 11, 7, 20, 39, 55, -16, 40),
	('Watford', 38, 11, 7, 20, 40, 68, -28, 40),
	('Hull City', 38, 9, 7, 22, 37, 80, -43, 34),
	('Middelsbrough', 38, 5, 13, 20, 27, 53, -26, 28),
	('Sunderland', 38, 6, 6, 26, 29, 69, -40, 24)

----- PLAYERS TABLE INSERT VALUES -----
INSERT INTO players VALUES
    -- Arsenal players --
	('Alexis Sanchez', 'Arsenal', 'False', 7,'Forward', 'Chile'),
	('Nacho Monreal' , 'Arsenal', 'False', 18, 'Defender', 'Spain'),
	('Petr Cech', 'Arsenal', 'False', 33, 'Goalkeeper', 'Czech Republic'),
	('Mesut Ozil', 'Arsenal', 'False', 11, 'Midfielder', 'Germany'),
	('Laurent Koscielny' ,'Arsenal', 'True', 6, 'Defender', 'France'),
	('Hector Bellerin' ,'Arsenal', 'False', 24, 'Defender', 'Spain'),
	('Granit Xhaka' ,'Arsenal', 'False', 29, 'Midfielder', 'Switzerland'),
	('Shkodran Mustafi' ,'Arsenal', 'False', 20, 'Defender', 'Germany'),
	('Theo Walcott' ,'Arsenal', 'False', 14, 'Midfielder', 'England'),
	('Francis Coquelin' ,'Arsenal', 'False', 34, 'Midfielder', 'France'),
	('Alex Oxlade-Chamberlain' ,'Arsenal', 'False', 15, 'Midfielder', 'England'),
	-- Bournemouth players --
	('Steve Cook', 'Bournemouth', 'False', 3,'Defender', 'England'),
	('Artur Boruc', 'Bournemouth', 'False', 1,'Goalkeeper', 'Poland'),
	('Adam Smith', 'Bournemouth', 'False', 15,'Defender', 'England'),
	('Charlie Daniels', 'Bournemouth', 'False', 11,'Defender', 'England'),
	('Harry Arter', 'Bournemouth', 'False', 8,'Midfielder', 'England'),
	('Simon Francis', 'Bournemouth', 'True', 2,'Defender', 'England'),
	('Joshua King', 'Bournemouth', 'False', 17,'Forward', 'Norway'),
	('Jack Wilshere', 'Bournemouth', 'False', 10,'Midfielder', 'England'),
	('Andrew Surman', 'Bournemouth', 'False', 6,'Midfielder', 'South Africa'),
	('Ryan Fraser', 'Bournemouth', 'False', 24,'Midfielder', 'Scotland'),
	('Junior Stanislas', 'Bournemouth', 'False', 19,'Midfielder', 'England'),
	-- Burnley players --
	('Matthew Lowton', 'Burnley', 'False', 2,'Defender', 'England'),
	('Stephen Ward', 'Burnley', 'False', 23,'Defender', 'Ireland'),
	('Tom Heaton', 'Burnley', 'True', 1,'Goalkeeper', 'England'),
	('Ben Mee', 'Burnley', 'False', 6,'Defender', 'England'),
	('George Boyd', 'Burnley', 'False', 21,'Midfielder', 'Scotland'),
	('Jeff Hendrick', 'Burnley', 'False', 13,'Midfielder', 'Ireland'),
	('Andre Gray', 'Burnley', 'False', 7,'Forward', 'England'),
	('Scott Arfield', 'Burnley', 'False', 37,'Midfielder', 'Scotland'),
	('Sam Vokes', 'Burnley', 'False', 9,'Forward', 'Wales'),
	('Ashley Barnes', 'Burnley', 'False', 10,'Forward', 'England'),
	('Dean Marney', 'Burnley', 'False', 8,'Midfielder', 'England'),
	-- Chelsea players --
	('Cesar Azpilicueta', 'Chelsea', 'False', 28,'Defender', 'Spain'),
	('Gary Cahill', 'Chelsea', 'True', 24,'Defender', 'England'),
	('Thibaut Courtois', 'Chelsea', 'False', 13,'Goalkeeper', 'Belgium'),
	('Ngolo Kante', 'Chelsea', 'False', 7,'Midfielder', 'France'),
	('Diego Costa', 'Chelsea', 'False', 19,'Forward', 'Spain'),
	('Eden Hazard', 'Chelsea', 'False', 10,'Midfielder', 'Belgium'),
	('David Luiz', 'Chelsea', 'False', 30,'Defender', 'Brazil'),
	('Cesc Fabregas', 'Chelsea', 'False', 4,'Midfielder', 'Spain'),
	('Marcos Alonso', 'Chelsea', 'False', 3,'Defender', 'Spain'),
	('Victor Moses', 'Chelsea', 'False', 15,'Midfielder', 'Nigeria'),
	('Pedro Rodriguez', 'Chelsea', 'False', 11,'Midfielder', 'Spain'),
	-- Crystal Palace players --
	('Joel Ward', 'Crystal Palace', 'False', 2,'Defender', 'England'),
	('Christian Benteke', 'Crystal Palace', 'False', 17,'Forward', 'Belgium'),
	('Jason Puncheon', 'Crystal Palace', 'False', 42,'Midfielder', 'England'),
	('Wilfried Zaha', 'Crystal Palace', 'False', 11,'Midfielder', 'Ivory Coast'),
	('Wayne Hennessey', 'Crystal Palace', 'False', 13,'Goalkeeper', 'Wales'),
	('Andros Townsend', 'Crystal Palace', 'False', 10,'Midfielder', 'England'),
	('Yohan Cabaye', 'Crystal Palace', 'False', 7,'Midfielder', 'France'),
	('Martin Kelly', 'Crystal Palace', 'False', 34,'Defender', 'England'),
	('James McArthur', 'Crystal Palace', 'False', 18,'Midfielder', 'Scotland'),
	('Damien Delaney', 'Crystal Palace', 'False', 27,'Defender', 'Ireland'),
	('Scott Dann', 'Crystal Palace', 'True', 6,'Defender', 'England'),
	-- Everton players --
	('Romelu Lukaku', 'Everton', 'False', 10,'Forward', 'Belgium'),
	('Ashley Williams', 'Everton', 'False', 5,'Defender', 'Wales'),
	('Ross Barkley', 'Everton', 'False', 8,'Midfielder', 'England'),
	('Leighton Baines', 'Everton', 'False', 3,'Defender', 'England'),
	('Idrissa Gueye', 'Everton', 'False', 17,'Midfielder', 'Senegal'),
	('Seamus Coleman', 'Everton', 'False', 23,'Defender', 'Ireland'),
	('Phil Jagielka', 'Everton', 'True', 6,'Defender', 'England'),
	('Gareth Barry', 'Everton', 'False', 18,'Midfielder', 'England'),
	('Kevin Mirallas', 'Everton', 'False', 11,'Midfielder', 'Belgium'),
	('Tom Davies', 'Everton', 'False', 26,'Midfielder', 'England'),
	('Maarten Stekelenburg', 'Everton', 'False', 22,'Goalkeeper', 'Netherlands'),
	-- Hull City players --
	('Sam Clucas', 'Hull City', 'False', 11,'Midfielder', 'England'),
	('Andrew Robertson', 'Hull City', 'False', 3,'Defender', 'Scotland'),
	('Ahmed Elmohamady', 'Hull City', 'False', 27,'Defender', 'Egypt'),
	('Harry Maguire', 'Hull City', 'False', 5,'Defender', 'England'),
	('Curtis Davies', 'Hull City', 'False', 6,'Defender', 'England'),
	('Tom Huddlestone', 'Hull City', 'False', 8,'Midfielder', 'England'),
	('Eldin Jakupovic', 'Hull City', 'False', 16,'Goalkeeper', 'Switzerland'),
	('Michael Dawson', 'Hull City', 'True', 21,'Defender', 'England'),
	('Robert Snodgrass', 'Hull City', 'False', 10,'Midfielder', 'Scotland'),
	('Jake Livermore', 'Hull City', 'False', 14,'Midfielder', 'England'),
	('Abel Hernandez', 'Hull City', 'False', 9,'Forward', 'Uruguay'),
	-- Leicester City players --
	('Christian Fuchs', 'Leicester City', 'False', 28,'Defender', 'Austria'),
	('Danny Simpson', 'Leicester City', 'False', 17,'Defender', 'England'),
	('Robert Huth', 'Leicester City', 'False', 6,'Defender', 'Germany'),
	('Riyad Mahrez', 'Leicester City', 'False', 26,'Midfielder', 'Algeria'),
	('Jamie Vardy', 'Leicester City', 'False', 9,'Forward', 'England'),
	('Kasper Schmeichel', 'Leicester City', 'False', 1,'Goalkeeper', 'Denmark'),
	('Danny Drinkwater', 'Leicester City', 'False', 4,'Midfielder', 'England'),
	('Wes Morgan', 'Leicester City', 'True', 5,'Defender', 'Jamaica'),
	('Marc Albrighton', 'Leicester City', 'False', 11,'Midfielder', 'England'),
	('Daniel Amartey', 'Leicester City', 'False', 13,'Midfielder', 'Ghana'),
	('Shinji Okazaki', 'Leicester City', 'False', 20,'Forward', 'Japan'),
	-- Liverpool players
	('Nathaniel Clyne', 'Liverpool', 'False', 2,'Defender', 'England'),
	('James Milner', 'Liverpool', 'False', 7,'Defender', 'England'),
	('Roberto Firmino', 'Liverpool', 'False', 11,'Forward', 'Brazil'),
	('Georginio Wijnaldum', 'Liverpool', 'False', 5,'Midfielder', 'Netherlands'),
	('Dejan Lovren', 'Liverpool', 'False', 6,'Defender', 'Croatia'),
	('Simon Mignolet', 'Liverpool', 'False', 22,'Goalkeeper', 'Belgium'),
	('Joel Matip', 'Liverpool', 'False', 32,'Defender', 'Cameroon'),
	('Adam Lallana', 'Liverpool', 'False', 20,'Midfielder', 'England'),
	('Sadio Mane', 'Liverpool', 'False', 19,'Midfielder', 'Senegal'),
	('Philippe Coutinho', 'Liverpool', 'False', 10,'Midfielder', 'Brazil'),
	('Jordan Henderson', 'Liverpool', 'True', 14,'Midfielder', 'England'),
	-- Manchester City players --
	('Kevin De Bruyne', 'Manchester City', 'False', 17,'Midfielder', 'Belgium'),
	('David Silva', 'Manchester City', 'False', 21,'Midfielder', 'Spain'),
	('Fernandinho', 'Manchester City', 'False', 25,'Midfielder', 'Brazil'),
	('Nicolas Otamendi', 'Manchester City', 'False', 30,'Defender', 'Argentina'),
	('Aleksandar Kolarov', 'Manchester City', 'False', 11,'Defender', 'Serbia'),
	('Vincent Kompany', 'Manchester City', 'True', 4,'Defender', 'Belgium'),
	('Raheem Sterling', 'Manchester City', 'False', 7,'Midfielder', 'England'),
	('Kun Aguero', 'Manchester City', 'False', 10,'Forward', 'Argentina'),
	('Gael Clichy', 'Manchester City', 'False', 22,'Defender', 'France'),
	('Claudio Bravo', 'Manchester City', 'False', 1,'Goalkeeper', 'Chile'),
	('Yaya Toure', 'Manchester City', 'False', 42,'Midfielder', 'Ivory Coast'),
	-- Manchester United players --
	('David De Gea', 'Manchester United', 'False', 1,'Goalkeeper', 'Spain'),
	('Paul Pogba', 'Manchester United', 'False', 6,'Midfielder', 'France'),
	('Antonio Valencia', 'Manchester United', 'True', 25,'Defender', 'Ecuador'),
	('Ander Herrera', 'Manchester United', 'False', 21,'Midfielder', 'Spain'),
	('Zlatan Ibrahimovic', 'Manchester United', 'False', 9,'Forward', 'Sweden'),
	('Eric Bailly', 'Manchester United', 'False', 3,'Defender', 'Ivory Coast'),
	('Daley Blind', 'Manchester United', 'False', 17,'Defender', 'Netherlands'),
	('Marcus Rashford', 'Manchester United', 'False', 19,'Midfielder', 'England'),
	('Marcos Rojo', 'Manchester United', 'False', 5,'Defender', 'Argentina'),
	('Juan Mata', 'Manchester United', 'False', 8,'Midfielder', 'Spain'),
	('Marouane Fellaini', 'Manchester United', 'False', 27,'Midfielder', 'Belgium'),
	-- Middelsbrough players --
	('Ben Gibson', 'Middelsbrough', 'False', 6,'Defender', 'England'),
	('Alvaro Negredo', 'Middelsbrough', 'False', 10,'Forward', 'Spain'),
	('Adam Clayton', 'Middelsbrough', 'False', 8,'Midfielder', 'England'),
	('Marten de Roon', 'Middelsbrough', 'False', 14,'Midfielder', 'Netherlands'),
	('Grant Leadbitter', 'Middelsbrough', 'True', 7,'Midfielder', 'England'),
	('Victor Valdes', 'Middelsbrough', 'False', 26,'Goalkeeper', 'Spain'),
	('Stewart Downing', 'Middelsbrough', 'False', 19,'Midfielder', 'England'),
	('Antonio Barragan', 'Middelsbrough', 'False', 17,'Defender', 'Spain'),
	('Calum Chambers', 'Middelsbrough', 'False', 25,'Defender', 'England'),
	('George Friend', 'Middelsbrough', 'False', 3,'Defender', 'England'),
	('Fabio', 'Middelsbrough', 'False', 2,'Defender', 'Brazil'),
	-- Southampton players --
	('Fraser Forster', 'Southampton', 'False', 1,'Goalkeeper', 'England'),
	('Oriol Romeu', 'Southampton', 'False', 14,'Midfielder', 'Spain'),
	('Nathan Redmond', 'Southampton', 'False', 22,'Midfielder', 'England'),
	('Steven Davis', 'Southampton', 'True', 8,'Midfielder', 'Northern Ireland'),
	('Cedric Soares', 'Southampton', 'False', 2,'Defender', 'Portugal'),
	('Ryan Bertrand', 'Southampton', 'False', 21,'Defender', 'England'),
	('Dusan Tadic', 'Southampton', 'False', 11,'Midfielder', 'Serbia'),
	('Maya Yoshida', 'Southampton', 'False', 3,'Defender', 'Japan'),
	('James Ward-Prowse', 'Southampton', 'False', 16,'Midfielder', 'England'),
	('Virgil van Dijk', 'Southampton', 'False', 17,'Defender', 'Netherlands'),
	('Shane Long', 'Southampton', 'False', 7,'Forward', 'Ireland'),
	-- Stoke City players --
	('Bruno Martins Indi', 'Stoke City', 'False', 15,'Defender', 'Netherlands'),
	('Erik Pieters', 'Stoke City', 'False', 3,'Defender', 'Netherlands'),
	('Ryan Shawcross', 'Stoke City', 'True', 17,'Defender', 'England'),
	('Joe Allen', 'Stoke City', 'False', 4,'Midfielder', ' Wales'),
	('Marko Arnautovic', 'Stoke City', 'False', 10,'Forward', 'Austria'),
	('Lee Grant', 'Stoke City', 'False', 33,'Goalkeeper', 'England'),
	('Glenn Whelan', 'Stoke City', 'False', 6,'Midfielder', ' Ireland'),
	('Glen Johnson', 'Stoke City', 'False', 8,'Defender', 'England'),
	('Xherdan Shaqiri', 'Stoke City', 'False', 22,'Midfielder', 'Switzerland'),
	('Geoff Cameron', 'Stoke City', 'False', 20,'Defender', 'USA'),
	('Charlie Adam', 'Stoke City', 'False', 16,'Midfielder', 'Scotland'),
	-- Sunderland players --
	('Jermain Defoe', 'Stoke City', 'False', 18,'Forward', 'England'),
	('Lamine Kone', 'Stoke City', 'False', 23,'Defender', 'Ivory Coast'),
	('Jordan Pickford', 'Stoke City', 'False', 13,'Goalkeeper', 'England'),
	('Didier Ndong', 'Stoke City', 'False', 17,'Midfielder', 'Gabon'),
	('John Oshea', 'Stoke City', 'True', 16,'Defender', 'Ireland'),
	('Billy Jones', 'Stoke City', 'False', 2,'Defender', 'England'),
	('Jason Denayer', 'Stoke City', 'False', 4,'Defender', 'Belgium'),
	('Patrick van Aanholt', 'Stoke City', 'False', 3,'Defender', 'Netherlands'),
	('Fabio Borini', 'Stoke City', 'False', 9,'Forward', 'Italy'),
	('Adnan Januzaj', 'Stoke City', 'False', 44,'Midfielder', 'Belgium'),
	('Sebastian Larsson', 'Stoke City', 'False', 7,'Midfielder', 'Sweden'),
	-- Swansea City players --
	('Lukasz Fabianski', 'Swansea City', 'False', 1,'Goalkeeper', 'Poland'),
	('Gylfi Sigurosson', 'Swansea City', 'False', 23,'Midfielder', 'Iceland'),
	('Kyle Naughton', 'Swansea City', 'False', 26,'Defender', 'England'),
	('Fernando Llorente', 'Swansea City', 'False', 9,'Forward', 'Spain'),
	('Leroy Fer', 'Swansea City', 'False', 8,'Midfielder', 'Netherlands'),
	('Federico Fernandez', 'Swansea City', 'False', 33,'Defender', 'Argentina'),
	('Alfie Mawson', 'Swansea City', 'False', 6,'Defender', ' England'),
	('Jack Cork', 'Swansea City', 'False', 24,'Midfielder', 'England'),
	('Wayne Routledge', 'Swansea City', 'False', 15,'Midfielder', 'England'),
	('Leon Britton', 'Swansea City', 'True', 7,'Midfielder', 'England'),
	('Tom Carroll', 'Swansea City', 'False', 42,'Midfielder', 'England'),
	-- Tottenham Hotspur players --
	('Christian Eriksen', 'Tottenham Hotspur', 'False', 23,'Midfielder', 'Denmark'),
	('Dele Alli', 'Tottenham Hotspur', 'False', 20,'Midfielder', 'England'),
	('Victor Wanyama', 'Tottenham Hotspur', 'False', 12,'Midfielder', 'Kenya'),
	('Eric Dier', 'Tottenham Hotspur', 'False', 15,'Defender', 'England'),
	('Hugo Lloris', 'Tottenham Hotspur', 'True', 1,'Goalkeeper', 'France'),
	('Jan Vertonghen', 'Tottenham Hotspur', 'False', 5,'Defender', 'Belgium'),
	('Kyle Walker', 'Tottenham Hotspur', 'False', 2,'Defender', 'England'),
	('Toby Alderweireld', 'Tottenham Hotspur', 'False', 4,'Defender', 'Belgium'),
	('Harry Kane', 'Tottenham Hotspur', 'False', 10,'Forward', 'England'),
	('Mousa Dembele', 'Tottenham Hotspur', 'False', 19,'Midfielder', 'Belgium'),
	('Heung-min Son', 'Tottenham Hotspur', 'False', 7,'Midfielder', 'South Korea'),
	-- Watford  players --
	('Heurelho Gomes', 'Watford', 'False', 1,'Goalkeeper', 'Brazil'),
	('Etienne Capoue', 'Watford', 'False', 29,'Midfielder', 'France'),
	('Jose Cholevas', 'Watford', 'False', 25,'Defender', 'Greece'),
	('Sebastian Prodl', 'Watford', 'False', 5,'Defender', 'Austria'),
	('Troy Deeney', 'Watford', 'True', 9,'Forward', 'England'),
	('Miguel Britos', 'Watford', 'False', 3,'Defender', 'Uruguay'),
	('Valon Behrami', 'Watford', 'False', 11,'Midfielder', ' Switzerland'),
	('Nordin Amrabat', 'Watford', 'False', 7,'Forward', 'Morocco'),
	('Younes Kaboul', 'Watford', 'False', 4,'Defender', 'France'),
	('Daryl Janmaat', 'Watford', 'False', 22,'Defender', 'Netherlands'),
	('Tom Cleverley', 'Watford', 'False', 8,'Midfielder', 'England'),
	-- West Bromwich Albion players --
	('Ben Foster', 'West Bromwich Albion', 'False', 1,'Goalkeeper', 'England'),
	('Craig Dawson', 'West Bromwich Albion', 'False', 25,'Defender', 'England'),
	('Darren Fletcher', 'West Bromwich Albion', 'True', 24,'Midfielder', 'Scotland'),
	('Gareth McAuley', 'West Bromwich Albion', 'False', 23,'Defender', 'Northern Ireland'),
	('Salomon Rondon', 'West Bromwich Albion', 'False', 9,'Forward', 'Venezuela'),
	('Jonny Evans', 'West Bromwich Albion', 'False', 6,'Defender', 'Northern Ireland'),
	('Allan Nyom', 'West Bromwich Albion', 'False', 2,'Defender', 'Cameroon'),
	('Chris Brunt', 'West Bromwich Albion', 'False', 11,'Midfielder', 'Northern Ireland'),
	('Nacer Chadli', 'West Bromwich Albion', 'False', 22,'Midfielder', 'Belgium'),
	('Claudio Yacob', 'West Bromwich Albion', 'False', 5,'Midfielder', 'Argentina'),
	('Matt Phillips', 'West Bromwich Albion', 'False', 10,'Midfielder', 'Scotland'),
	-- West Ham United players --
	('Cheikhou Kouyate', 'West Ham United', 'False', 8,'Midfielder', 'Senegal'),
	('Manuel Lanzini', 'West Ham United', 'False', 10,'Midfielder', 'Argentina'),
	('Winston Reid', 'West Ham United', 'False', 2,'Defender', 'New Zealand'),
	('Michail Antonio', 'West Ham United', 'False', 30,'Forward', 'England'),
	('Mark Noble', 'West Ham United', 'True', 16,'Midfielder', 'England'),
	('Aaron Cresswell', 'West Ham United', 'False', 3,'Defender', 'England'),
	('Darren Randolph', 'West Ham United', 'False', 1,'Goalkeeper', 'Ireland'),
	('Pedro Obiang', 'West Ham United', 'False', 14,'Midfielder', 'Spain'),
	('Angelo Ogbonna', 'West Ham United', 'False', 21,'Defender', 'Italy'),
	('James Collins', 'West Ham United', 'False', 19,'Defender', 'Wales'),
	('Dimitri Payet', 'West Ham United', 'False', 27,'Midfielder', 'France')

	
----- COACHES TABLE INSERT VALUES -----
INSERT INTO coaches VALUES
	('Arsene Wenger', 'Arsenal'),
	('Eddie Howe', 'Bournemouth'),
	('Sean Dyche', 'Burnley'),
	('Antonio Conte', 'Chelsea'),
	('Sam Allardyce', 'Crystal Palace'),
	('Ronald Koeman', 'Everton'),
	('Marco Silva', 'Hull City'),
	('Craig Shakespeare', 'Leicester City'),
	('Jurgen Klopp', 'Liverpool'),
	('Pep Guardiola', 'Manchester City'),
	('Jose Mourinho', 'Manchester United'),
	('Steve Agnew ', 'Middelsbrough'),
	('Claude Puel', 'Southampton'),
	('Mark Hughes', 'Stoke City'),
	('David Moyes', 'Sunderland'),
	('Paul Clement', 'Swansea City'),
	('Mauricio Pochettino', 'Tottenham Hotspur'),
	('Walter Mazzarri', 'Watford'),
	('Tony Pulis', 'West Bromwich Albion'),
	('Slaven Bilic', 'West Ham United')

----- STADIUMS TABLE INSERT VALUES -----
INSERT INTO stadiums VALUES
	('Emirates Stadium', 'London', 'Arsenal', 60432),
	('Vitality Stadium', 'Bournemouth', 'Bournemouth', 11464),
	('Turf Moor', 'Burnley','Burnley', 22546),
	('Stamford Bridge', 'London', 'Chelsea', 41623),
	('Selhurst Park', 'London', 'Crystal Palace', 26309),
	('Goodison Park', 'Liverpool', 'Everton', 39572),
	('KCOM Stadium', 'Kingston upon Hull', 'Hull City',	25404),
	('King Power Stadium', 'Leicester', 'Leicester City', 32500),
	('Anfield', 'Liverpool ', 'Liverpool', 	54074),
	('Etihad Stadium', 'Manchester', 'Manchester City', 55097),
	('Old Trafford', 'Manchester', 'Manchester United', 76100),
	('Riverside Stadium', 'Middelsbrough', 'Middelsbrough', 35100),
	('St Marys Stadium', 'Southampton', 'Southampton', 32689),
	('Bet365 Stadium', 'Stoke-on-Trent', 'Stoke City', 28383),
	('Stadium of Light', 'Sunderland', 'Sunderland', 49000),
	('Liberty Stadium', 'Swansea', 'Swansea City', 20972),
	('White Hart Lane', 'London', 'Tottenham Hotspur', 32000),
	('Vicarage Road', 'Watford', 'Watford', 21977),
	('The Hawthorns', 'West Bromwich', 'West Bromwich Albion', 26500),
	('London Stadium', 'London', 'West Ham United', 57000)

----- TOP_SCORERS TABLE INSERT VALUES -----
INSERT INTO top_scorers VALUES
	('Harry Kane', 'Tottenham Hotspur', 29),
	('Romelu Lukaku', 'Everton', 25),
	('Alexis Sanchez', 'Arsenal', 24),
	('Kun Aguero', 'Manchester City', 20),
	('Diego Costa', 'Chelsea', 20),
	('Dele Alli', 'Tottenham Hotspur', 18),
	('Zlatan Ibrahimovic', 'Manchester United', 17),
	('Eden Hazard', 'Chelsea', 16),
	('Joshua King', 'Bournemouth', 16),
	('Christian Benteke', 'Crystal Palace', 15),
	('Jermain Defoe', 'Sunderland', 15),
	('Fernando Llorente', 'Swansea City', 15)

INSERT INTO top_assists VALUES
    ('Kevin De Bruyne', 'Manchester City', 18),
	('Christian Eriksen', 'Tottenham Hotspur', 15),
	('Gylfi Sigurosson', 'Swansea City', 13),
	('Cesc Fabregas', 'Chelsea', 12),
	('Alexis Sanchez', 'Arsenal', 10),
	('Mesut Ozil', 'Arsenal', 9),
	('Pedro Rodriguez', 'Chelsea', 9),
	('Georginio Wijnaldum', 'Liverpool', 9),
	('Wilfried Zaha', 'Crystal Palace', 9),
	('Ross Barkley', 'Everton', 8),
	('Matt Phillips', 'West Bromwich Albion', 8)
	
SELECT * FROM pl_table_2017 
SELECT * FROM teams
SELECT * FROM stadiums
SELECT * FROM coaches
SELECT * FROM players
SELECT * FROM top_scorers
SELECT * FROM top_assists

--DROP TABLE pl_table_2017
--DROP TABLE teams
--DROP TABLE stadiums
--DROP TABLE coaches
--DROP TABLE players
--DROP TABLE top_scorers
--DROP TABLE top_assists











