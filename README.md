import pandas as pd

# Assuming your DataFrame is df and session lengths are in 'session_length'
lengths = df['session_length']

# Define the buckets
bucket_1 = (lengths <= 64).sum()
bucket_2 = ((lengths > 64) & (lengths <= 128)).sum()
bucket_3 = ((lengths > 128) & (lengths <= 512)).sum()

# Print results
print(f"Sessions ≤ 64:             {bucket_1}")
print(f"Sessions 65–128:          {bucket_2}")
print(f"Sessions 129–512:         {bucket_3}")
