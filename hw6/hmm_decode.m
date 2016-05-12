function [pred_state_seqs] = hmm_decode(hmm_params, obs_seqs)
    % Working directly in log domain, as it is more numerically stable.
    log_theta = log(hmm_params.theta);
    log_theta_start = log(hmm_params.theta_start);
    log_theta_stop = log(hmm_params.theta_stop);
    log_gamma = log(hmm_params.gamma);
    [n, m] = size(log_gamma); 

    pred_state_seqs = cell(1, length(obs_seqs));

    for k = 1:length(obs_seqs)
        ob_seq = obs_seqs{k};
        Tk = length(ob_seq);

        pred_st_seq = zeros(1, Tk);

        % Tables for keeping the scores and backpointers.
        scores = -1e-7*ones(n, Tk+1);
        back_pts = zeros(n, Tk+1);

        %% Your code goes here. Maintain the Viterbi table and the 
        % backpointer table. Recover the most probable assignment.
		idx = ob_seq(1) ;
        scores(:,1) = log_theta_start' + log_gamma(:, idx);
        
        for t = 2:Tk
			idx = ob_seq(t) ;
            for s = 1:n
                [scores(s,t), back_pts(s,t)] = max(scores(:,t-1)+log_theta(:,s)+log_gamma(s,idx));
            end
        end
        
        pred_st_seq = zeros(1, Tk) ;
        [scores(:, Tk+1), bk_pt] = max( scores(:, Tk) + log_theta_stop ) ;
		for i=Tk:-1:2
			pred_st_seq(i) = bk_pt ;
			bk_pt = back_pts( bk_pt, i) ;
		end
		pred_st_seq(1) = bk_pt ;
        pred_state_seqs{k} = pred_st_seq;
    end
end

