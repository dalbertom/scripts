if not exist trash md trash
for %%a in (%*) do if exist %%a move %%a trash

