
function [hmm_params] = hmm_train(state_seqs, obs_seqs, n, m, alpha_obs, alpha_trans)

    assert (length(state_seqs) == length(obs_seqs));

    % Initialization of the tables for the counts.
    c_theta = zeros(n, n);
    c_theta_start = zeros(1, n);
    c_theta_stop = zeros(n, 1);
    c_gamma = zeros(n, m);

    %% Your code goes here. Collect the statistics from the data.
	for i=1:length(state_seqs)
		state_seq = state_seqs{i} ;
        obs_seq = obs_seqs{i};
        
		%c_theta_start, c_theta_stop
        row = state_seq(1);
		c_theta_start(1, row) = c_theta_start(1, row) + 1 ; 
        row = state_seq( length(state_seq) );
		c_theta_stop(row, 1) = c_theta_stop(row, 1) + 1 ; 

		%observation
        for j = 1:length(state_seq)
			row = state_seq(j);
			col = obs_seq(j);
			c_gamma(row, col) = c_gamma(row, col) + 1;
        end
        
		%update theta
		for j = 2:length(state_seq)
			s = state_seq(j-1) ;
			t = state_seq(j) ;
			c_theta(s, t) = c_theta(s, t) + 1 ;
		end
	end

    
    
    % Adding smoothing.
    c_theta = c_theta + alpha_trans;
    c_theta_start = c_theta_start + alpha_trans;
    c_theta_stop = c_theta_stop + alpha_trans;
    c_gamma = c_gamma + alpha_obs;

    % The sum of the transitions out of each of the states.
    c_trans = sum(c_theta, 2) + sum(c_theta_stop, 2);

    hmm_params.theta = c_theta ./ repmat(c_trans, 1, n);
    hmm_params.theta_start = c_theta_start ./ sum(c_theta_start, 2);
    hmm_params.theta_stop = c_theta_stop ./ c_trans;
    hmm_params.gamma = c_gamma ./ repmat(sum(c_gamma, 2), 1, m);
end

