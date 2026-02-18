export FINN_DEPS=/workspace/.finn/deps

poetry run finn bench --bench_config ci/cfg/live_fifosizing.yml
