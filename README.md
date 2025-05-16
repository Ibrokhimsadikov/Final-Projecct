import pandas as pd
import matplotlib.pyplot as plt

# Assuming your DataFrame is called df and the column is 'session_length'
lengths = df['session_length'].sort_values()

# Compute cumulative distribution
cum_dist = lengths.rank(pct=True).values  # percentile rank
sorted_lengths = lengths.values

# Plot cumulative distribution
plt.figure(figsize=(8, 5))
plt.plot(sorted_lengths, cum_dist)
plt.xlabel("Session Length (number of tokens)")
plt.ylabel("Cumulative Proportion")
plt.title("Cumulative Distribution of Session Lengths")
plt.grid(True)
plt.show()

length_95 = lengths.quantile(0.95)
print(f"95% of sessions are shorter than or equal to: {int(length_95)} tokens")

