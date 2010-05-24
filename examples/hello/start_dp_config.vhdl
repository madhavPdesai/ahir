
configuration start_dp_config of start_dp is
  for default_arch

    for dpe_20 : APFloat_S_2
      use configuration ahir.APFloatAdd;
    end for;

    for dpe_25 : APInt_S_2
      use configuration ahir.APIntAdd;
    end for;

    for dpe_6 : APInt_S_2
      use configuration ahir.APIntSGT;
    end for;

  end for;
end start_dp_config;
