import { test, expect } from '@playwright/test';

test('homepage loads successfully', async ({ page }) => {
  await page.goto('/');

  // Verify the page has a title
  const title = await page.title();
  expect(title).toBeTruthy();
});

test('page is accessible and interactive', async ({ page }) => {
  await page.goto('/');

  // Verify the page body has rendered content
  const body = page.locator('body');
  await expect(body).toBeVisible();
});
