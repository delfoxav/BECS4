
%Open savefile
fileID = fopen("saved_results.txt","w");
headers = 'Datetime; best objective result; best yield; best price; best x; best y; best z; price x; price y; price z \n';
result_format = '%s; %.2f; %.2f; %.2f; %.4f; %.2f; %.6f; %.2f; %.2f; %.2f \n'
fprintf(fileID,headers);

for i = 1:100
    GA_multiples_runs;
    fprintf(fileID,result_format, datetime(now,"ConvertFrom","datenum"), best_obj,best_yield,best_price, best_values(1), best_values(2), best_values(3), price_value(1), price_value(2), price_value(3))
    i
end
fclose(fileID);
