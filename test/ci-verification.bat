for /f "tokens=2" %%a in ('svn info ^| find "Revision:"') do set SVN_REVISION=%%a
ant -s build/build.xml installer verification -Dci=true -DGWT_MODULE_EXT="" -Drdbms.enabled=true -DDEFAULT_TOPOLOGY_PORT=6000 -Doffset=1
# -DFORCE_CLEAN=true 