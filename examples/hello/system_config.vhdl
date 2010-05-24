
configuration system_config of system is
  for default_arch

    for start_dp_inst : start_dp
      use configuration work.start_dp_config;
    end for;

  end for;
end system_config;
