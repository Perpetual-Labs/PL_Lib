#!/usr/bin/env -S bash -l

echo "Running modelica-simulate-task script on $(date --iso-8601)..."

git clone https://github.com/Perpetual-Labs/PL_Lib.git ./lib/PL_Lib

script_name="runPL_Lib.mos"

docker run -v "$PWD/":"/tmp/job/" --workdir '/tmp/job/' --entrypoint sh "docker.io/openmodelica/openmodelica:v1.19.2-minimal" -c "omc ./$script_name"