from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        # Change this to match your latest migration file name
        ('expenses', '0002_paymentmethod_currency_transaction_exchange'),
    ]

    operations = [
        migrations.AlterField(
            model_name='transaction',
            name='transaction_type',
            field=models.CharField(
                choices=[
                    ('expense',       'Expense'),
                    ('income',        'Income'),
                    ('transfer',      'Transfer'),
                    ('topup',         'Top-up'),
                    ('ph_withdrawal', 'PH Withdrawal'),
                    ('tw_withdrawal', 'TW Withdrawal'),
                ],
                default='expense',
                max_length=15,
            ),
        ),
        migrations.AlterField(
            model_name='recurringexpense',
            name='transaction_type',
            field=models.CharField(
                choices=[
                    ('expense',       'Expense'),
                    ('income',        'Income'),
                    ('transfer',      'Transfer'),
                    ('topup',         'Top-up'),
                    ('ph_withdrawal', 'PH Withdrawal'),
                    ('tw_withdrawal', 'TW Withdrawal'),
                ],
                default='expense',
                max_length=15,
            ),
        ),
    ]
