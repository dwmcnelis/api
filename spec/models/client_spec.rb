require 'rails_helper'

describe 'Client' do
  #it_behaves_like "xxx_concern"

  #before(:each) do
  #  @defaults = { player_guid: 'jeterde01', birth_year: 1974, name_first: 'Derek', name_last: 'Jeter' }
  #end

  it "should create a new Client instance given valid attributes" do
    Client.create!({
                   first_name: Faker::Name.first_name,
                   last_name: Faker::Name.last_name,
                   email: Faker::Internet.email,
                   phone: Faker::PhoneNumber.phone_number,
                   status: ['new', 'in progress', 'closed', 'bad'].sample,
                   notes: Faker::Lorem.paragraph(2)
                 })
  end

=begin
  describe 'hitting class methods' do
    let!(:player1) { create(:player, @defaults) }
    let!(:player2) { create(:player, player_guid: 'cabremi01', birth_year: 1983, name_first: 'Miguel', name_last: 'Cabrera') }
    let!(:player3) { create(:player, player_guid: 'mccutan01', birth_year: 1986, name_first: 'Andrew', name_last: 'McCutchen') }
    let!(:hitting1) { create(:hitting, player_guid: 'jeterde01', year: 2012, league_guid: 'AL', team_guid: 'NYA', hitting_games: 159, at_bats: 683, runs: 99, hits: 216, doubles: 32, triples: 0, home_runs: 15, runs_batted_in: 58, stolen_bases: 9, caught_stealing: 4) }
    let!(:hitting2) { create(:hitting, player_guid: 'jeterde01', year: 2011, league_guid: 'AL', team_guid: 'NYA', hitting_games: 131, at_bats: 546, runs: 84, hits: 162, doubles: 24, triples: 4, home_runs: 6, runs_batted_in: 61, stolen_bases: 16, caught_stealing: 6) }
    let!(:hitting3) { create(:hitting, player_guid: 'jeterde01', year: 2010, league_guid: 'AL', team_guid: 'NYA', hitting_games: 157, at_bats: 663, runs: 111, hits: 179, doubles: 30, triples: 3, home_runs: 10, runs_batted_in: 67, stolen_bases: 18, caught_stealing: 5) }
    let!(:hitting4) { create(:hitting, player_guid: 'jeterde01', year: 2009, league_guid: 'AL', team_guid: 'NYA', hitting_games: 153, at_bats: 634, runs: 107, hits: 212, doubles: 27, triples: 1, home_runs: 18, runs_batted_in: 66, stolen_bases: 30, caught_stealing: 5) }
    let!(:hitting5) { create(:hitting, player_guid: 'jeterde01', year: 2008, league_guid: 'AL', team_guid: 'NYA', hitting_games: 150, at_bats: 596, runs: 88, hits: 179, doubles: 25, triples: 3, home_runs: 11, runs_batted_in: 69, stolen_bases: 11, caught_stealing: 5) }
    let!(:hitting6) { create(:hitting, player_guid: 'jeterde01', year: 2007, league_guid: 'AL', team_guid: 'NYA', hitting_games: 156, at_bats: 639, runs: 102, hits: 206, doubles: 39, triples: 4, home_runs: 12, runs_batted_in: 73, stolen_bases: 15, caught_stealing: 8) }
    let!(:hitting7) { create(:hitting, player_guid: 'cabremi01', year: 2012, league_guid: 'AL', team_guid: 'DET', hitting_games: 161, at_bats: 622, runs: 109, hits: 205, doubles: 40, triples: 0, home_runs: 44, runs_batted_in: 139, stolen_bases: 4, caught_stealing: 1) }
    let!(:hitting8) { create(:hitting, player_guid: 'cabremi01', year: 2011, league_guid: 'AL', team_guid: 'DET', hitting_games: 161, at_bats: 572, runs: 111, hits: 197, doubles: 48, triples: 0, home_runs: 30, runs_batted_in: 105, stolen_bases: 2, caught_stealing: 1) }
    let!(:hitting9) { create(:hitting, player_guid: 'cabremi01', year: 2010, league_guid: 'AL', team_guid: 'DET', hitting_games: 150, at_bats: 548, runs: 111, hits: 180, doubles: 45, triples: 1, home_runs: 38, runs_batted_in: 126, stolen_bases: 3, caught_stealing: 3) }
    let!(:hitting10) { create(:hitting, player_guid: 'cabremi01', year: 2009, league_guid: 'AL', team_guid: 'DET', hitting_games: 160, at_bats: 611, runs: 96, hits: 198, doubles: 34, triples: 0, home_runs: 34, runs_batted_in: 103, stolen_bases: 6, caught_stealing: 2) }
    let!(:hitting11) { create(:hitting, player_guid: 'cabremi01', year: 2008, league_guid: 'AL', team_guid: 'DET', hitting_games: 160, at_bats: 616, runs: 85, hits: 180, doubles: 36, triples: 2, home_runs: 37, runs_batted_in: 127, stolen_bases: 1, caught_stealing: 0) }
    let!(:hitting12) { create(:hitting, player_guid: 'cabremi01', year: 2007, league_guid: 'NL', team_guid: 'FLO', hitting_games: 157, at_bats: 588, runs: 91, hits: 188, doubles: 38, triples: 2, home_runs: 34, runs_batted_in: 119, stolen_bases: 2, caught_stealing: 1) }
    let!(:hitting13) { create(:hitting, player_guid: 'mccutan01', year: 2012, league_guid: 'NL', team_guid: 'PIT', hitting_games: 157, at_bats: 593, runs: 107, hits: 194, doubles: 29, triples: 6, home_runs: 31, runs_batted_in: 96, stolen_bases: 20, caught_stealing: 12) }
    let!(:hitting14) { create(:hitting, player_guid: 'mccutan01', year: 2011, league_guid: 'NL', team_guid: 'PIT', hitting_games: 158, at_bats: 572, runs: 87, hits: 148, doubles: 34, triples: 5, home_runs: 23, runs_batted_in: 89, stolen_bases: 23, caught_stealing: 10) }
    let!(:hitting15) { create(:hitting, player_guid: 'mccutan01', year: 2010, league_guid: 'NL', team_guid: 'PIT', hitting_games: 154, at_bats: 570, runs: 94, hits: 163, doubles: 35, triples: 5, home_runs: 16, runs_batted_in: 56, stolen_bases: 33, caught_stealing: 10) }
    let!(:hitting16) { create(:hitting, player_guid: 'mccutan01', year: 2009, league_guid: 'NL', team_guid: 'PIT', hitting_games: 108, at_bats: 433, runs: 74, hits: 124, doubles: 26, triples: 9, home_runs: 12, runs_batted_in: 54, stolen_bases: 22, caught_stealing: 5) }

    describe '.hitters' do
      it "should find all hitters" do
        hitters = Player.hitters
        expect(hitters.length).to eq(3)
        expect(hitters.first.id).to eq(player1.id)
        expect(hitters.last.id).to eq(player3.id)
      end

      it "should find hitters for a specific year" do
        hitters = Player.hitters(year: 2009)
        expect(hitters.length).to eq(3)
        expect(hitters.first.id).to eq(player1.id)
      end
    end
  end

  describe 'fielding class methods' do
    let!(:player1) { create(:player, @defaults) }
    let!(:player2) { create(:player, player_guid: 'tejadmi01', birth_year: 1974, name_first: 'Miguel', name_last: 'Tejada') }
    let!(:fielding1) { create(:fielding, player_guid: 'jeterde01', year: 2007, league_guid: 'AL', team_guid: 'NYA', position: 'SS', fielding_games: 155, fielding_starts: 153, fielding_innings: 1318.1, total_chances: 607, put_outs: 199, assists: 390, errs: 18, double_plays: 104, stolen_bases_allowed: nil, caught_stealing: nil, stolen_base_percentage: nil, past_balls: nil, wild_pitches: nil, fielding_percentage: 0.970, range_factor: 3.80) }
    let!(:fielding2) { create(:fielding, player_guid: 'jeterde01', year: 2008, league_guid: 'AL', team_guid: 'NYA', position: 'SS', fielding_games: 148, fielding_starts: 147, fielding_innings: 1258.2, total_chances: 579, put_outs: 220, assists: 347, errs: 12, double_plays: 69, stolen_bases_allowed: nil, caught_stealing: nil, stolen_base_percentage: nil, past_balls: nil, wild_pitches: nil, fielding_percentage: 0.979, range_factor: 3.83) }
    let!(:fielding3) { create(:fielding, player_guid: 'jeterde01', year: 2009, league_guid: 'AL', team_guid: 'NYA', position: 'SS', fielding_games: 150, fielding_starts: 147, fielding_innings: 1260.2, total_chances: 554, put_outs: 206, assists: 340, errs: 8, double_plays: 75, stolen_bases_allowed: nil, caught_stealing: nil, stolen_base_percentage: nil, past_balls: nil, wild_pitches: nil, fielding_percentage: 0.986, range_factor: 3.64) }
    let!(:fielding4) { create(:fielding, player_guid: 'jeterde01', year: 2010, league_guid: 'AL', team_guid: 'NYA', position: 'SS', fielding_games: 151, fielding_starts: 150, fielding_innings: 1303.2, total_chances: 553, put_outs: 182, assists: 365, errs: 6, double_plays: 94, stolen_bases_allowed: nil, caught_stealing: nil, stolen_base_percentage: nil, past_balls: nil, wild_pitches: nil, fielding_percentage: 0.989, range_factor: 3.62) }
    let!(:fielding5) { create(:fielding, player_guid: 'jeterde01', year: 2011, league_guid: 'AL', team_guid: 'NYA', position: 'SS', fielding_games: 122, fielding_starts: 121, fielding_innings: 1047.1, total_chances: 432, put_outs: 140, assists: 280, errs: 12, double_plays: 60, stolen_bases_allowed: nil, caught_stealing: nil, stolen_base_percentage: nil, past_balls: nil, wild_pitches: nil, fielding_percentage: 0.972, range_factor: 3.44) }
    let!(:fielding6) { create(:fielding, player_guid: 'jeterde01', year: 2011, league_guid: 'AL', team_guid: 'NYA', position: 'SS', fielding_games: 135, fielding_starts: 133, fielding_innings: 1186.1, total_chances: 506, put_outs: 172, assists: 324, errs: 10, double_plays: 67, stolen_bases_allowed: nil, caught_stealing: nil, stolen_base_percentage: nil, past_balls: nil, wild_pitches: nil, fielding_percentage: 0.980, range_factor: 3.67) }
    let!(:fielding7) { create(:fielding, player_guid: 'tejadmi01', year: 2007, league_guid: 'AL', team_guid: 'BAL', position: 'SS', fielding_games: 124, fielding_starts: 122, fielding_innings: 1068.2, total_chances: 522, put_outs: 149, assists: 358, errs: 15, double_plays: 77, stolen_bases_allowed: nil, caught_stealing: nil, stolen_base_percentage: nil, past_balls: nil, wild_pitches: nil, fielding_percentage: 0.971, range_factor: 4.09) }
    let!(:fielding8) { create(:fielding, player_guid: 'tejadmi01', year: 2008, league_guid: 'NL', team_guid: 'HOU', position: 'SS', fielding_games: 157, fielding_starts: 154, fielding_innings: 1354.1, total_chances: 640, put_outs: 187, assists: 442, errs: 11, double_plays: 97, stolen_bases_allowed: nil, caught_stealing: nil, stolen_base_percentage: nil, past_balls: nil, wild_pitches: nil, fielding_percentage: 0.983, range_factor: 4.01) }
    let!(:fielding9) { create(:fielding, player_guid: 'tejadmi01', year: 2009, league_guid: 'NL', team_guid: 'HOU', position: 'SS', fielding_games: 158, fielding_starts: 157, fielding_innings: 1371.1, total_chances: 710, put_outs: 214, assists: 475, errs: 21, double_plays: 105, stolen_bases_allowed: nil, caught_stealing: nil, stolen_base_percentage: nil, past_balls: nil, wild_pitches: nil, fielding_percentage: 0.970, range_factor: 4.36) }
    let!(:fielding10) { create(:fielding, player_guid: 'tejadmi01', year: 2010, league_guid: 'NL', team_guid: 'SDN', position: 'SS', fielding_games: 58, fielding_starts: 57, fielding_innings: 496.2, total_chances: 233, put_outs: 68, assists: 162, errs: 3, double_plays: 40, stolen_bases_allowed: nil, caught_stealing: nil, stolen_base_percentage: nil, past_balls: nil, wild_pitches: nil, fielding_percentage: 0.987, range_factor: 3.97) }
    let!(:fielding11) { create(:fielding, player_guid: 'tejadmi01', year: 2010, league_guid: 'NL', team_guid: 'SFN', position: '3B', fielding_games: 44, fielding_starts: 39, fielding_innings: 372.1, total_chances: 130, put_outs: 29, assists: 99, errs: 2, double_plays: 12, stolen_bases_allowed: nil, caught_stealing: nil, stolen_base_percentage: nil, past_balls: nil, wild_pitches: nil, fielding_percentage: 0.985, range_factor: 2.91) }
    let!(:fielding12) { create(:fielding, player_guid: 'tejadmi01', year: 2011, league_guid: 'NL', team_guid: 'SFN', position: 'SS', fielding_games: 42, fielding_starts: 39, fielding_innings: 334.1, total_chances: 162, put_outs: 44, assists: 110, errs: 8, double_plays: 12, stolen_bases_allowed: nil, caught_stealing: nil, stolen_base_percentage: nil, past_balls: nil, wild_pitches: nil, fielding_percentage: 0.951, range_factor: 3.67) }

    describe '.fielders' do
      it "should find all fielders" do
        fielders = Player.fielders
        expect(fielders.length).to eq(2)
        expect(fielders.first.id).to eq(player1.id)
        expect(fielders.last.id).to eq(player2.id)
      end

      it "should find fielders for a specific year" do
        fielders = Player.fielders(year: 2009)
        expect(fielders.length).to eq(2)
        expect(fielders.first.id).to eq(player1.id)
      end
    end
  end

  describe 'pitching class methods' do
    let!(:player1) { create(:player, player_guid: 'hernafe02', birth_year: 1986, name_first: 'Felix', name_last: 'Hernandez') }
    let!(:player2) { create(:player, player_guid: 'hallaro01', birth_year: 1977, name_first: 'Roy', name_last: 'Halladay') }
    let!(:pitching1) { create(:pitching, player_guid: 'hernafe02', year: 2007, league_guid: 'AL', team_guid: 'SEA', wins: 14, losses: 7, earned_run_average: 3.92, pitching_games: 30, pitching_starts: 30, saves: 0, save_opportunities: 0, pitching_innings: 190.1, hits: 209, runs: 88, earned_runs: 83, home_runs: 20, walks: 53, strike_outs: 165, average: 0.281, walks_hits_inning_percentage: 1.38) }
    let!(:pitching2) { create(:pitching, player_guid: 'hernafe02', year: 2008, league_guid: 'AL', team_guid: 'SEA', wins: 9, losses: 11, earned_run_average: 3.45, pitching_games: 31, pitching_starts: 31, saves: 0, save_opportunities: 0, pitching_innings: 200.2, hits: 198, runs: 85, earned_runs: 77, home_runs: 17, walks: 80, strike_outs: 175, average: 0.261, walks_hits_inning_percentage: 1.69) }
    let!(:pitching3) { create(:pitching, player_guid: 'hernafe02', year: 2009, league_guid: 'AL', team_guid: 'SEA', wins: 19, losses: 5, earned_run_average: 2.49, pitching_games: 34, pitching_starts: 34, saves: 0, save_opportunities: 0, pitching_innings: 238.2, hits: 200, runs: 81, earned_runs: 66, home_runs: 15, walks: 71, strike_outs: 217, average: 0.227, walks_hits_inning_percentage: 1.63) }
    let!(:pitching4) { create(:pitching, player_guid: 'hernafe02', year: 2010, league_guid: 'AL', team_guid: 'SEA', wins: 13, losses: 12, earned_run_average: 2.27, pitching_games: 34, pitching_starts: 34, saves: 0, save_opportunities: 0, pitching_innings: 249.2, hits: 194, runs: 80, earned_runs: 63, home_runs: 17, walks: 70, strike_outs: 232, average: 0.212, walks_hits_inning_percentage: 1.72) }
    let!(:pitching5) { create(:pitching, player_guid: 'hernafe02', year: 2011, league_guid: 'AL', team_guid: 'SEA', wins: 14, losses: 14, earned_run_average: 3.47, pitching_games: 33, pitching_starts: 33, saves: 0, save_opportunities: 0, pitching_innings: 233.2, hits: 218, runs: 99, earned_runs: 90, home_runs: 19, walks: 67, strike_outs: 222, average: 0.248, walks_hits_inning_percentage: 1.30) }
    let!(:pitching6) { create(:pitching, player_guid: 'hernafe02', year: 2012, league_guid: 'AL', team_guid: 'SEA', wins: 13, losses: 9, earned_run_average: 3.06, pitching_games: 33, pitching_starts: 33, saves: 0, save_opportunities: 0, pitching_innings: 232.0, hits: 209, runs: 84, earned_runs: 79, home_runs: 14, walks: 56, strike_outs: 223, average: 0.241, walks_hits_inning_percentage: 1.30) }
    let!(:pitching7) { create(:pitching, player_guid: 'hallaro01', year: 2007, league_guid: 'AL', team_guid: 'TOR', wins: 16, losses: 7, earned_run_average: 3.71, pitching_games: 31, pitching_starts: 31, saves: 0, save_opportunities: 0, pitching_innings: 225.1, hits: 232, runs: 101, earned_runs: 93, home_runs: 15, walks: 48, strike_outs: 139, average: 0.268, walks_hits_inning_percentage: 1.80) }
    let!(:pitching8) { create(:pitching, player_guid: 'hallaro01', year: 2008, league_guid: 'AL', team_guid: 'TOR', wins: 20, losses: 11, earned_run_average: 2.78, pitching_games: 34, pitching_starts: 33, saves: 0, save_opportunities: 0, pitching_innings: 246.0, hits: 220, runs: 88, earned_runs: 76, home_runs: 18, walks: 39, strike_outs: 206, average: 0.237, walks_hits_inning_percentage: 1.77) }
    let!(:pitching9) { create(:pitching, player_guid: 'hallaro01', year: 2009, league_guid: 'AL', team_guid: 'TOR', wins: 17, losses: 10, earned_run_average: 2.79, pitching_games: 32, pitching_starts: 32, saves: 0, save_opportunities: 0, pitching_innings: 239.0, hits: 234, runs: 82, earned_runs: 74, home_runs: 22, walks: 35, strike_outs: 208, average: 0.256, walks_hits_inning_percentage: 1.66) }
    let!(:pitching10) { create(:pitching, player_guid: 'hallaro01', year: 2010, league_guid: 'NL', team_guid: 'PHI', wins: 21, losses: 10, earned_run_average: 2.44, pitching_games: 33, pitching_starts: 33, saves: 0, save_opportunities: 0, pitching_innings: 250.2, hits: 231, runs: 74, earned_runs: 68, home_runs: 24, walks: 30, strike_outs: 219, average: 0.245, walks_hits_inning_percentage: 1.61) }
    let!(:pitching11) { create(:pitching, player_guid: 'hallaro01', year: 2011, league_guid: 'NL', team_guid: 'PHI', wins: 19, losses: 6, earned_run_average: 2.35, pitching_games: 32, pitching_starts: 32, saves: 0, save_opportunities: 0, pitching_innings: 233.2, hits: 208, runs: 65, earned_runs: 61, home_runs: 10, walks: 35, strike_outs: 220, average: 0.239, walks_hits_inning_percentage: 1.39) }
    let!(:pitching12) { create(:pitching, player_guid: 'hallaro01', year: 2011, league_guid: 'NL', team_guid: 'PHI', wins: 11, losses: 8, earned_run_average: 4.49, pitching_games: 25, pitching_starts: 25, saves: 0, save_opportunities: 0, pitching_innings: 156.1, hits: 155, runs: 78, earned_runs: 78, home_runs: 18, walks: 36, strike_outs: 132, average: 0.261, walks_hits_inning_percentage: 1.22) }

    describe '.pitchers' do
      it "should find all pitchers" do
        pitchers = Player.pitchers
        expect(pitchers.length).to eq(2)
        expect(pitchers.first.id).to eq(player1.id)
        expect(pitchers.last.id).to eq(player2.id)
      end

      it "should find pitchers for a specific year" do
        pitchers = Player.pitchers(year: 2009)
        expect(pitchers.length).to eq(2)
        expect(pitchers.first.id).to eq(player1.id)
      end
    end
  end

  describe 'hitting instance methods' do
    let!(:player) { create(:player, @defaults) }
    let!(:hitting1) { create(:hitting, player_guid: 'jeterde01', year: 2012, league_guid: 'AL', team_guid: 'NYA', hitting_games: 159, at_bats: 683, runs: 99, hits: 216, doubles: 32, triples: 0, home_runs: 15, runs_batted_in: 58, stolen_bases: 9, caught_stealing: 4) }
    let!(:hitting2) { create(:hitting, player_guid: 'jeterde01', year: 2011, league_guid: 'AL', team_guid: 'NYA', hitting_games: 131, at_bats: 546, runs: 84, hits: 162, doubles: 24, triples: 4, home_runs: 6, runs_batted_in: 61, stolen_bases: 16, caught_stealing: 6) }
    let!(:hitting3) { create(:hitting, player_guid: 'jeterde01', year: 2010, league_guid: 'AL', team_guid: 'NYA', hitting_games: 157, at_bats: 663, runs: 111, hits: 179, doubles: 30, triples: 3, home_runs: 10, runs_batted_in: 67, stolen_bases: 18, caught_stealing: 5) }
    let!(:hitting4) { create(:hitting, player_guid: 'jeterde01', year: 2009, league_guid: 'AL', team_guid: 'NYA', hitting_games: 153, at_bats: 634, runs: 107, hits: 212, doubles: 27, triples: 1, home_runs: 18, runs_batted_in: 66, stolen_bases: 30, caught_stealing: 5) }
    let!(:hitting5) { create(:hitting, player_guid: 'jeterde01', year: 2008, league_guid: 'AL', team_guid: 'NYA', hitting_games: 150, at_bats: 596, runs: 88, hits: 179, doubles: 25, triples: 3, home_runs: 11, runs_batted_in: 69, stolen_bases: 11, caught_stealing: 5) }
    let!(:hitting6) { create(:hitting, player_guid: 'jeterde01', year: 2007, league_guid: 'AL', team_guid: 'NYA', hitting_games: 156, at_bats: 639, runs: 102, hits: 206, doubles: 39, triples: 4, home_runs: 12, runs_batted_in: 73, stolen_bases: 15, caught_stealing: 8) }

    describe '#hittings' do
      it "should find has many hittings" do
        hittings = player.hittings
        expect(hittings.length).to eq(6)
        expect(hittings.first.id).to eq(hitting1.id)
        expect(hittings.last.id).to eq(hitting6.id)
      end
    end
  end

  describe 'fielding instance methods' do
    let!(:player) { create(:player, @defaults) }
    let!(:fielding1) { create(:fielding, player_guid: 'jeterde01', year: 2007, league_guid: 'AL', team_guid: 'NYA', position: 'SS', fielding_games: 155, fielding_starts: 153, fielding_innings: 1318.1, total_chances: 607, put_outs: 199, assists: 390, errs: 18, double_plays: 104, stolen_bases_allowed: nil, caught_stealing: nil, stolen_base_percentage: nil, past_balls: nil, wild_pitches: nil, fielding_percentage: 0.970, range_factor: 3.80) }
    let!(:fielding2) { create(:fielding, player_guid: 'jeterde01', year: 2008, league_guid: 'AL', team_guid: 'NYA', position: 'SS', fielding_games: 148, fielding_starts: 147, fielding_innings: 1258.2, total_chances: 579, put_outs: 220, assists: 347, errs: 12, double_plays: 69, stolen_bases_allowed: nil, caught_stealing: nil, stolen_base_percentage: nil, past_balls: nil, wild_pitches: nil, fielding_percentage: 0.979, range_factor: 3.83) }
    let!(:fielding3) { create(:fielding, player_guid: 'jeterde01', year: 2009, league_guid: 'AL', team_guid: 'NYA', position: 'SS', fielding_games: 150, fielding_starts: 147, fielding_innings: 1260.2, total_chances: 554, put_outs: 206, assists: 340, errs: 8, double_plays: 75, stolen_bases_allowed: nil, caught_stealing: nil, stolen_base_percentage: nil, past_balls: nil, wild_pitches: nil, fielding_percentage: 0.986, range_factor: 3.64) }
    let!(:fielding4) { create(:fielding, player_guid: 'jeterde01', year: 2010, league_guid: 'AL', team_guid: 'NYA', position: 'SS', fielding_games: 151, fielding_starts: 150, fielding_innings: 1303.2, total_chances: 553, put_outs: 182, assists: 365, errs: 6, double_plays: 94, stolen_bases_allowed: nil, caught_stealing: nil, stolen_base_percentage: nil, past_balls: nil, wild_pitches: nil, fielding_percentage: 0.989, range_factor: 3.62) }
    let!(:fielding5) { create(:fielding, player_guid: 'jeterde01', year: 2011, league_guid: 'AL', team_guid: 'NYA', position: 'SS', fielding_games: 122, fielding_starts: 121, fielding_innings: 1047.1, total_chances: 432, put_outs: 140, assists: 280, errs: 12, double_plays: 60, stolen_bases_allowed: nil, caught_stealing: nil, stolen_base_percentage: nil, past_balls: nil, wild_pitches: nil, fielding_percentage: 0.972, range_factor: 3.44) }
    let!(:fielding6) { create(:fielding, player_guid: 'jeterde01', year: 2011, league_guid: 'AL', team_guid: 'NYA', position: 'SS', fielding_games: 135, fielding_starts: 133, fielding_innings: 1186.1, total_chances: 506, put_outs: 172, assists: 324, errs: 10, double_plays: 67, stolen_bases_allowed: nil, caught_stealing: nil, stolen_base_percentage: nil, past_balls: nil, wild_pitches: nil, fielding_percentage: 0.980, range_factor: 3.67) }

    describe '#fieldings' do
      it "should find has many fieldings" do
        fieldings = player.fieldings
        expect(fieldings.length).to eq(6)
        expect(fieldings.first.id).to eq(fielding1.id)
        expect(fieldings.last.id).to eq(fielding6.id)
      end
    end
  end

  describe 'pitching instance methods' do
    let!(:player) { create(:player, player_guid: 'hernafe02', birth_year: 1986, name_first: 'Felix', name_last: 'Hernandez') }
    let!(:pitching1) { create(:pitching, player_guid: 'hernafe02', year: 2007, league_guid: 'AL', team_guid: 'SEA', wins: 14, losses: 7, earned_run_average: 3.92, pitching_games: 30, pitching_starts: 30, saves: 0, save_opportunities: 0, pitching_innings: 190.1, hits: 209, runs: 88, earned_runs: 83, home_runs: 20, walks: 53, strike_outs: 165, average: 0.281, walks_hits_inning_percentage: 1.38) }
    let!(:pitching2) { create(:pitching, player_guid: 'hernafe02', year: 2008, league_guid: 'AL', team_guid: 'SEA', wins: 9, losses: 11, earned_run_average: 3.45, pitching_games: 31, pitching_starts: 31, saves: 0, save_opportunities: 0, pitching_innings: 200.2, hits: 198, runs: 85, earned_runs: 77, home_runs: 17, walks: 80, strike_outs: 175, average: 0.261, walks_hits_inning_percentage: 1.69) }
    let!(:pitching3) { create(:pitching, player_guid: 'hernafe02', year: 2009, league_guid: 'AL', team_guid: 'SEA', wins: 19, losses: 5, earned_run_average: 2.49, pitching_games: 34, pitching_starts: 34, saves: 0, save_opportunities: 0, pitching_innings: 238.2, hits: 200, runs: 81, earned_runs: 66, home_runs: 15, walks: 71, strike_outs: 217, average: 0.227, walks_hits_inning_percentage: 1.63) }
    let!(:pitching4) { create(:pitching, player_guid: 'hernafe02', year: 2010, league_guid: 'AL', team_guid: 'SEA', wins: 13, losses: 12, earned_run_average: 2.27, pitching_games: 34, pitching_starts: 34, saves: 0, save_opportunities: 0, pitching_innings: 249.2, hits: 194, runs: 80, earned_runs: 63, home_runs: 17, walks: 70, strike_outs: 232, average: 0.212, walks_hits_inning_percentage: 1.72) }
    let!(:pitching5) { create(:pitching, player_guid: 'hernafe02', year: 2011, league_guid: 'AL', team_guid: 'SEA', wins: 14, losses: 14, earned_run_average: 3.47, pitching_games: 33, pitching_starts: 33, saves: 0, save_opportunities: 0, pitching_innings: 233.2, hits: 218, runs: 99, earned_runs: 90, home_runs: 19, walks: 67, strike_outs: 222, average: 0.248, walks_hits_inning_percentage: 1.30) }
    let!(:pitching6) { create(:pitching, player_guid: 'hernafe02', year: 2012, league_guid: 'AL', team_guid: 'SEA', wins: 13, losses: 9, earned_run_average: 3.06, pitching_games: 33, pitching_starts: 33, saves: 0, save_opportunities: 0, pitching_innings: 232.0, hits: 209, runs: 84, earned_runs: 79, home_runs: 14, walks: 56, strike_outs: 223, average: 0.241, walks_hits_inning_percentage: 1.30) }

    describe '#pitchings' do
      it "should find has many pitchings" do
        pitchings = player.pitchings
        expect(pitchings.length).to eq(6)
        expect(pitchings.first.id).to eq(pitching1.id)
        expect(pitchings.last.id).to eq(pitching6.id)
      end
    end
  end

  describe '#display_name' do
    let!(:player) { create(:player, @defaults) }

    it "should build proper display name" do
      expect(player.display_name).to eq('Derek Jeter')
    end
  end

  describe '#sort_name' do
    let!(:player) { create(:player, @defaults) }

    it "should build proper sort name" do
      expect(player.sort_name).to eq('Jeter, Derek')
    end
  end

  describe '#method_missing' do
    let!(:player) { create(:player, @defaults) }

    it "should fall through to super" do
      expect {
        player.purposely_missing_method(1,2,3)
      }.to raise_error(StandardError)
    end
  end
=end

end