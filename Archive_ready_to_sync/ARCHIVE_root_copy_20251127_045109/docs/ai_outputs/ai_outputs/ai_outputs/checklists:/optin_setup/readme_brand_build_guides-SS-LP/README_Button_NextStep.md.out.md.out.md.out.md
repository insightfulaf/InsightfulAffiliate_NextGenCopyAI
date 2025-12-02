## Notes
This document explains how to link a button to the next step in your funnel without using a form.

## Button → Next Step (No Form)

For a squeeze page without a form, use **html/squeeze-hero.html** (No Form Version).

### Steps to Link Your Button
1. Navigate to **Funnels → (your funnel)** and locate your **next step** (e.g., Thank-You page).
2. Click the **⋯ (three dots)** next to that step and select **Copy link**.
3. In the editor of your squeeze page, open the **Custom HTML** block where you pasted the code.
4. Locate this line and replace **[[NEXT_STEP_URL]]** with the copied link:

   ```html
   <a class="btn btn-primary" href="[[NEXT_STEP_URL]]" id="cta-next">Get the Free Starter Stack</a>
   ```

- You can use a full URL (e.g., https://...systeme.io/thank-you-xxxx) or a relative path like **/thank-you** if your domain is connected.
- Ensure the quotes remain unchanged; only modify the placeholder inside them.