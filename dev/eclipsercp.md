


### Snippets

# Open perspective
IWorkbenchWindow window = getViewSite().getWorkbenchWindow();
IPerspectiveRegistry registry = workbench.getPerspectiveRegistry();
IWorkbenchPage page = window.getActivePage();
page.setPerspective(registry.findPerspectiveWithId(PRODUCT_PERSPECTIVE_ID));

Depending upon the context in which these calls are made, you might want to null-guard some of these calls, or check Workbench.isClosing() to be safe.


