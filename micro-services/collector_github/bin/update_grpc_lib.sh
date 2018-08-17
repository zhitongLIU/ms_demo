#/bin/bash

grpc_tools_ruby_protoc -I ../ms_demo_protos --ruby_out=./lib --grpc_out=./lib ../ms_demo_protos/collector.proto
