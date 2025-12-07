#!/bin/bash

# 默认命令是 build
COMMAND="build"
DELETE_CONFLICTING=false

# 解析参数
while [[ $# -gt 0 ]]; do
  case $1 in
    build|watch)
      COMMAND="$1"
      shift
      ;;
    --delete-conflicting-outputs|-d)
      DELETE_CONFLICTING=true
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# 构建命令
CMD="flutter pub run build_runner $COMMAND"

if [ "$DELETE_CONFLICTING" = true ] && [ "$COMMAND" = "build" ]; then
  CMD="$CMD --delete-conflicting-outputs"
fi

echo "Running: $CMD"
eval $CMD
