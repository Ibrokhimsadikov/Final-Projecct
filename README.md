98% of our user sessions are 50 tokens or fewer, but we're currently using a max sequence length of 128. This leads to excessive padding in most inputs, wasting memory and compute. Since padding tokens are ignored during attention and don’t contribute to learning, they slow training without benefit. Reducing the max length to 64 would significantly improve efficiency while still covering the vast majority of sessions.

import pandas as pd

# Example: df['session_length'] contains the length of each session
lengths = df['session_length']

# Count how many sessions fall under each threshold
count_64 = (lengths <= 64).sum()
count_128 = (lengths <= 128).sum()
count_512 = (lengths <= 512).sum()

total_sessions = len(df)

# Print percentages
print(f"Sessions ≤ 64 tokens:  {count_64} ({100 * count_64 / total_sessions:.2f}%)")
print(f"Sessions ≤ 128 tokens: {count_128} ({100 * count_128 / total_sessions:.2f}%)")
print(f"Sessions ≤ 512 tokens: {count_512} ({100 * count_512 / total_sessions:.2f}%)")
