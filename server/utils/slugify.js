/**
 * Generate URL-friendly slug from a string.
 * Handles ASCII + basic Vietnamese diacritics.
 * Examples:
 *   "Present Simple Tense" → "present-simple-tense"
 *   "Thì Hiện Tại Đơn"    → "thi-hien-tai-don"
 */
export function slugify(text) {
  return text
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '') // strip diacritics
    .replace(/đ/g, 'd')
    .replace(/Đ/g, 'D')
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-') // non-alphanumeric → dash
    .replace(/^-|-$/g, ''); // trim leading/trailing dashes
}
