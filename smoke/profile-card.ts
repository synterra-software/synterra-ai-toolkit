// Throwaway fixture for testing the pr-review skill's comment posting.
// Delete this branch after the smoke test.

export interface ProfileResponse {
  id: string;
  displayName: string;
  avatarUrl: string;
  plan: 'free' | 'pro';
}

export function renderProfileCard(raw: unknown): string {
  const profile = raw as ProfileResponse;
  const initials = profile.displayName
    .split(' ')
    .map((part) => part[0])
    .join('');

  return `<img src="${profile.avatarUrl}" alt="${initials}" data-plan="${profile.plan}">`;
}

export function planLabel(plan: ProfileResponse['plan']): string {
  switch (plan) {
    case 'free':
      return 'Free';
    case 'pro':
      return 'Pro';
  }
}
