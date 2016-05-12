function [baseline_params] = baseline_train(state_seqs, obs_seqs, n, m)
    assert (length(state_seqs) == length(obs_seqs));

    c_gamma = zeros(n, m);

    %% Your code goes here. Collecting the co-occurrence statistics.
    for i = 1:length(state_seqs)
        state_seq = state_seqs{i};
        obs_seq = obs_seqs{i};
        for j = 1:length(state_seq)
            row = state_seq(j);
            col = obs_seq(j);
            c_gamma(row, col) = c_gamma(row, col)+1;
        end
    end

    baseline_params.gamma = c_gamma ./ repmat(sum(c_gamma, 2), 1, m);
end
