## Notes
This document provides instructions for linking a button to the next step in a funnel without using a form.

# Button → Next Step (No Form)

Since you don't have a form on the squeeze page, use **html/squeeze-hero.html** (No Form Version).

## How to Link Your Button

1. Navigate to **Funnels → (your funnel)** and find your **next step** (e.g., Thank-You page).
2. Click the **⋯ (three dots)** next to that step and select **Copy link**.
3. In the editor of your squeeze page, open the **Custom HTML** block you pasted.
4. Locate this line and replace **[[NEXT_STEP_URL]]** with the copied link:

   ```html
   <a class="btn btn-primary" href="[[NEXT_STEP_URL]]" id="cta-next">Get the Free Starter Stack</a>
   ```

- You can use a full URL (e.g., https://...systeme.io/thank-you-xxxx) or a relative path like **/thank-you** if your domain is connected.
- Ensure you keep the quotes; only replace the placeholder inside them.