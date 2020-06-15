
```
header("Content-Type: text/plain");
var_dump(elysia_cron_module_jobs());
exit(0);

$ fgrep -r 'Channels settings'
modules/elysia_cron/elysia_cron.admin.inc:    '#title' => t('Channels settings'),




    $_elysia_cron_db_cache[$name] = db_select('elysia_cron', 'ec')
      ->fields('ec', _elysia_cron_columns())
      ->condition('name', $name)
      ->execute()
      ->fetchAssoc();

```


```
        $payment = entity_load_single('payment', $row->pid);
        $payment->setStatus(new PaymentStatusItem(PAYMENT_STATUS_EXPIRED));
        Payment_Wrapper::unlock_bill_nodes($payment);

        // Manually Save Payment without calling ->complete()
        entity_save('payment', $payment);
        module_invoke_all('payment_pre_finish', $payment);
        if (module_exists('rules'))
        {
            rules_invoke_event('payment_pre_finish', $payment);
        }

```

# Module

REF: https://www.drupal.org/docs/7/creating-custom-modules/creating-drupal-7-hooks

```php
	module_invoke_all('node_view', $entity, $display, $entity_view_mode, $langcode);

	foreach (module_implements($hook) as $module) {}

	drupal_alter('mymodule_data', $alterable1, $alterable2, $context);	 // Calling all modules implementing hook_my_data_alter()
```

# Block

```php

```

=======

# Misc

```

```