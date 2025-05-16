def has_space_token(token_list):
    return any(" " in str(token) for token in token_list)

df['has_space'] = df['Session_sequence_pages'].apply(has_space_token)

# How many sessions have at least one token with a space?
num_with_spaces = df['has_space'].sum()
print(f"Sessions with tokens containing spaces: {num_with_spaces}")
