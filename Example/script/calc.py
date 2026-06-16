#!/usr/bin/env python3
# coding: utf-8

import math,os

def load_data():
    with open("origin") as f:
        origins = [float(line.strip()) for line in f if line.strip()]

    with open("estimated") as f:
        estimates = [float(line.strip()) for line in f if line.strip()]
    return origins, estimates

def calculate(origins, estimates):
    n = min(len(origins), len(estimates))
    squared_diffs = [(origins[i] - estimates[i]) ** 2 for i in range(n)]
    mse = sum(squared_diffs) / n
    rmse = math.sqrt(mse)
    return n, squared_diffs, mse, rmse

if __name__ == "__main__":
    os.chdir(os.path.dirname(os.path.realpath(__file__)))
    
    origins, estimates = load_data()
    n, squared_diffs, mse, rmse = calculate(origins, estimates)

    print(f"Lines: {n}")
    print(f"SSE: {sum(squared_diffs):.4f}")
    print(f"MSE: {mse:.4f}")
    print(f"RMSE: {rmse:.4f}")